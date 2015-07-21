//
//  DonateViewController.swift
//  TJU120
//
//  Created by 秦昱博 on 15/7/21.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

import UIKit
import WebKit

class DonateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "捐赠"
        
        var webView = WKWebView(frame: self.view.bounds)
        webView.clipsToBounds = false
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://120news.wenjin.in/donate/")!))
        self.view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
