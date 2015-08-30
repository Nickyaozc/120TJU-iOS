//
//  ActivityDetailViewController.swift
//  TJU120
//
//  Created by yaozican on 15/8/29.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var index:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NewsDataManager.getNewsDetail(index, success: { html in
            self.webView.loadHTMLString(html, baseURL: nil)
            }, failure: { error in
                MsgDisplay.showErrorMessage(error)
        })

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
