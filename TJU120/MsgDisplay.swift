//
//  MsgDisplay.swift
//  
//
//  Created by Qin Yubo on 15/8/23.
//
//

import UIKit

class MsgDisplay: NSObject {
    
    class func showSuccessMessage(msg: String) {
        CRToastManager.showNotificationWithOptions(self.optionsWithMessage(msg, color: UIColor.greenColor()) as [NSObject : AnyObject], completionBlock: nil)
    }
    
    class func showErrorMessage(msg: String) {
        CRToastManager.showNotificationWithOptions(self.optionsWithMessage(msg, color: UIColor.redColor()) as [NSObject : AnyObject], completionBlock: nil)
    }
    
    class func showLoading() {
        
    }
    
    class func dismiss() {
        
    }
    
    class func optionsWithMessage(message: String, color: UIColor) -> NSDictionary {
        var options: NSDictionary = [
            kCRToastNotificationTypeKey: CRToastType.NavigationBar.rawValue,
            kCRToastNotificationPresentationTypeKey: CRToastPresentationType.Cover.rawValue,
            kCRToastTextKey: "\(message)",
            kCRToastTextAlignmentKey: NSTextAlignment.Center.rawValue,
            kCRToastTimeIntervalKey: Double(2.0),
            kCRToastAnimationInTypeKey: CRToastAnimationType.Linear.rawValue,
            kCRToastAnimationOutTypeKey: CRToastAnimationType.Linear.rawValue,
            kCRToastBackgroundColorKey: color,
            kCRToastAnimationInDirectionKey: CRToastAnimationDirection.Top.rawValue,
            kCRToastAnimationOutDirectionKey: CRToastAnimationDirection.Top.rawValue,
            kCRToastFontKey: UIFont.systemFontOfSize(18)
        ]
        return options
    }
}
