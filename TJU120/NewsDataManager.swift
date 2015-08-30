//
//  NewsDataManager.swift
//  
//
//  Created by Qin Yubo on 15/8/23.
//
//

import UIKit

class NewsDataManager: NSObject {
   
    class func getNewsData(type: Int, page: Int, success: Array<NewsTitleData> -> () , failure: String -> ()) {
        var manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        var typeAddress = (type == 0 ? "news" : "feature")
        manager.GET("http://120news.wenjin.in/index.php?s=/Article/lists/category/\(typeAddress).html&p=\(page)", parameters: nil, success: {(operation, responseObject) in
            if responseObject["errno"] as! Int == 1 {
                var dataArr = NewsTitleData.objectArrayWithKeyValuesArray(responseObject["rsm"]) as AnyObject as! [NewsTitleData]
                success(dataArr)
            } else {
                failure(responseObject["error"] as! String)
            }
        }, failure: {(operation, error) in
            failure(error.description)
        })
    }
    
    class func getNewsDetail(index: String, success: String -> (), failure: String -> ()) {
        var manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        manager.GET("http://120news.wenjin.in/index.php?s=/Article/detail/id/\(index).html", parameters: nil, success: {(operation, responseObject) in
            if responseObject["errno"] as! Int == 1 {
                var rsmDic = (responseObject as! NSDictionary).objectForKey("rsm") as! NSDictionary
                var rawHTML = rsmDic["content"] as! String
                success(FrontEndConvertor.convertHTMLToBootstrap(rawHTML))
            } else {
                failure(responseObject["error"] as! String)
            }
        }, failure: {(operation, error) in
            failure(error.description)
        })
    }
    
}
