//
//  Util.swift
//  FBAuth
//
//  Created by Swayam Infotech on 23/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import Foundation
import UIKit

class Alert : NSObject {
    
    private override init() { }

    static let shared = Alert()

    // to show alert with title and message
    func ShowAlert(title: String, message: String, in vc: UIViewController , withAction : [UIAlertAction]? = nil , addCloseAction : Bool = true) {
        
        let alert = UIAlertController(title: Util.sharedInstance.localize(str: title), message: Util.sharedInstance.localize(str: message), preferredStyle: UIAlertControllerStyle.alert)

        if addCloseAction {
            alert.addAction(UIAlertAction(title: Util.sharedInstance.localize(str: "ok_text"), style: UIAlertActionStyle.default, handler: nil))
        }
        
        if withAction != nil {
            for ac in withAction! {
                alert.addAction(ac)
            }
        }
        alert.view.tintColor = theamColor

        if !Util.isStringNull(srcString: title) {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
