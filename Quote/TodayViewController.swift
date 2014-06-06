//
//  TodayViewController.swift
//  Quote
//
//  Created by Eshwar Ramesh on 04/06/14.
//  Copyright (c) 2014 Eshwar Ramesh. All rights reserved.
//

import Foundation
import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        print("There is something")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        /*var url = NSURL(string:QUERY_URL)
        var urlRequest = NSURLRequest(URL:url)
        var vcInstance:ViewController = ViewController.shared() as ViewController
        vcInstance.getData(urlRequest,  {(data:NSData?, response:NSURLResponse?, error:NSError?) in
            dispatch_async(dispatch_get_main_queue(), {
                if error {
                    println("Error retrieving data for extension")
                    self.result = NCUpdateResult.Failed
                }
                else {
                    var dict:NSDictionary? = vcInstance.parseJSON(data!)
                    self.strQuote = dict!["quote"] as? NSString
                    self.displayLabel.text = self.strQuote
                    println("display label text : \(self.displayLabel.text)")
                    self.result = NCUpdateResult.NewData
                }
                })
            })*/
        completionHandler(NCUpdateResult.NewData)
    }
    
    
}
