//
//  ActivityDataManager.swift
//  TJU120
//
//  Created by yaozican on 15/8/29.
//  Copyright (c) 2015年 TWT Studio. All rights reserved.
//

import UIKit

class ActivityDataManager: NSObject {
   
    class func getActivityData(type: Int, page: Int, success: Array<ActivityTitleData> -> () , failure: String -> ()) {
        var manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        var typeAddress = (type == 0 ? "school" : "jxgcxy")
        manager.GET("http://120news.wenjin.in/index.php?s=/Article/lists/category/\(typeAddress).html&p=\(page)", parameters: nil, success: {(operation, responseObject) in
            if responseObject["errno"] as! Int == 1 {
                var dataArr = ActivityTitleData.objectArrayWithKeyValuesArray(responseObject["rsm"]) as AnyObject as! [ActivityTitleData]
                success(dataArr)
            } else {
                failure(responseObject["error"] as! String)
            }
            }, failure: {(operation, error) in
                failure(error.description)
        })
    }
    
    class func getActivityDetail(index: String, success: String -> (), failure: String -> ()) {
        var manager = AFHTTPRequestOperationManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        manager.GET(" http://120news.wenjin.in/index.php?s=/Article/detail/id/\(index).html", parameters: nil, success: {(operation, responseObject) in
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
