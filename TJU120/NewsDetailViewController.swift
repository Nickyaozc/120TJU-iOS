//
//  NewsDetailViewController.swift
//  
//
//  Created by Qin Yubo on 15/8/23.
//
//

import UIKit

class NewsDetailViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: UIWebView!
    
    var index: String = ""

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