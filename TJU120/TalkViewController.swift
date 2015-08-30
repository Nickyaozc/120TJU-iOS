//
//  TalkViewController.swift
//  TJU120
//
//  Created by 秦昱博 on 15/7/21.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

import UIKit
import WebKit

class TalkViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "论坛"
        
        webView = WKWebView(frame: self.view.bounds)
        webView.clipsToBounds = false
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://120.wenjin.in")!))
        self.view.addSubview(webView)
        
        var refreshBtn = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshContent")
        self.navigationItem.rightBarButtonItem = refreshBtn
        
        var backBtn = UIBarButtonItem(title: "后退", style: .Plain, target: self, action: "goBack")
        self.navigationItem.leftBarButtonItem = backBtn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshContent() {
        webView.reload()
    }
    
    func goBack() {
        webView.goBack()
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
