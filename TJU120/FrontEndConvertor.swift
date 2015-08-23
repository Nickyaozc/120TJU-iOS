//
//  FrontEndConvertor.swift
//  
//
//  Created by Qin Yubo on 15/8/23.
//
//

import UIKit

class FrontEndConvertor: NSObject {
    
    class func convertHTMLToBootstrap(html: String) -> String {
        
        var converted = html
        
        var imgScanner = NSScanner(string: converted)
        while !imgScanner.atEnd {
            var imgPath: NSString? = nil
            var imgStyle: NSString? = nil
            
            var imgHeaderStr = "<img alt=\"\" src=\"http://"
            imgScanner.scanUpToString(imgHeaderStr, intoString: nil)
            imgScanner.scanUpToString("http://", intoString: nil)
            imgScanner.scanUpToString("\"", intoString: &imgPath)
            imgPath = imgPath?.stringByReplacingOccurrencesOfString(imgHeaderStr, withString: "")
            
            var imgStyleHeaderStr = "\""
            imgScanner.scanUpToString(imgStyleHeaderStr, intoString: nil)
            imgScanner.scanUpToString("/>", intoString: &imgStyle)
            
            // At the last part of NSScanner
            // the strings will be nil
            // so add an if-condition in order to prevent it
            
            if !(imgPath == nil || imgStyle == nil) {
                var originalImageStr = "<img alt=\"\" src=\"\(imgPath as NSString!)\(imgStyle as NSString!)/>"
                var responsiveImageStr = "<img class=\"img-responsive\" alt=\"Responsive image\" src=\"\(imgPath!)\" width=100%/>"
                
                converted = converted.stringByReplacingOccurrencesOfString(originalImageStr, withString: responsiveImageStr)
            }
        }
        
        let cssPath = NSBundle.mainBundle().pathForResource("bootstrap", ofType: "css")!
        let jsPath = NSBundle.mainBundle().pathForResource("bootstrap.min", ofType: "js")!
        var load = "<!DOCTYPE html> <html> <head> <meta charset=\"utf-8\"> <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"> <link href=\"\(cssPath)\" rel=\"stylesheet\"> </head> <body> <div class=\"container\"> <div class=\"row\"> <div class=\"col-sm-12\" style=\"margin-left:8px; margin-right:8px; font-size:16px; line-height:1.5; font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;\"> \(converted) </div></div></div> <script src=\"\(jsPath)\"></script> </body> </html>"
        
//        println("load = \(load)")
        return load
        
    }
    
}
