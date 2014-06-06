// Playground - noun: a place where people can play


import Foundation
import UIKit

let QUERY_URL = "http://www.iheartquotes.com/api/v1/random?format=json"

class ViewController: UIViewController, NSURLSessionDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tblView : UITableView
    var items: String[] = ["sing a song", "however", "yahariorenoseishunlovecomewamachigatteiru"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tblView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        var url = NSURL(string:QUERY_URL)
        var urlRequest = NSURLRequest(URL:url)
        
        var strQuote:String?
        var dict: NSDictionary?
        var session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(urlRequest, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) in
            dispatch_async(dispatch_get_main_queue(), {
                if error {
                    println("Error fetching data : \(error)")
                }
                else {
                    dict = self.parseJSON(data!)
                    println(dict!["quote"])
                }
                
                })
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView:UITableView!, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = self.items[indexPath.row]
        return cell
    }
    
    
}
