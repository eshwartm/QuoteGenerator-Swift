//
//  ViewController.swift
//  TodayWidget
//
//  Created by Eshwar Ramesh on 04/06/14.
//  Copyright (c) 2014 Eshwar Ramesh. All rights reserved.
//

import Foundation
import UIKit

let QUERY_URL = "http://www.iheartquotes.com/api/v1/random?format=json"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tblView : UITableView
    @IBOutlet
    var displayLabel : UILabel
    
    var items: String[] = ["sing a song", "now", "normalfaggotry"]
    var strQuote:String?
    
    class func shared() -> AnyObject {
        var token:dispatch_once_t = 0
        var instance: ViewController?
        // last argument is a closure
        dispatch_once(&token) {
            instance = ViewController()
        }
        return instance!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var url = NSURL(string:QUERY_URL)
        var urlRequest = NSURLRequest(URL:url)
        
//        var eff :UIVisualEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//        var someView = UIVisualEffectView(effect: eff)
//        someView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
//        self.view.addSubview(someView)
        
        self.tblView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tblView.hidden = true;
        
        var newData:NSData?
        var dict: NSDictionary?
        self.getData(urlRequest, completed: {(data:NSData?, response:NSURLResponse?, error:NSError?) in
            dispatch_async(dispatch_get_main_queue(), {
                if error {
                    println("Error fetching data : \(error)")
                }
                else {
                    dict = self.parseJSON(data!)
                    self.strQuote = dict!["quote"] as? NSString
                    println(self.strQuote)
                    self.displayLabel.text = self.strQuote
                }
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(urlRequest:NSURLRequest, completed:((data:NSData?, response:NSURLResponse?, error:NSError?)  -> Void)!) {
        var session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(urlRequest, completionHandler: {(data:NSData?, response:NSURLResponse?, error:NSError?) in
            completed(data: data, response: response, error: error)
        }).resume()
    }
    
    func parseJSON(inputData:NSData) -> NSDictionary {
        var error:NSError?
        var dictJSON:NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableLeaves , error: &error) as NSDictionary
        if error {
            println("Error parsing JSON")
        }
        return dictJSON
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return self.items.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = self.items[indexPath.row]
        return cell
    }
    
    func tableView(tableView:UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        println("selected cell : \(selectedCell.textLabel.text)")
    }

}

