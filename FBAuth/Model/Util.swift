//
//  Util.swift
//  FBAuth
//
//  Created by Swayam Infotech on 23/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class Util: NSObject {
    
    private override init() {
    }
    
    static let sharedInstance: Util = Util()

    // to get particular storyboard name.
    class func getStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }

    // to check string is null or not.
    class func isStringNull(srcString: String) -> Bool {
        if srcString != "" && srcString !=  "null" && !(srcString == "<null>") && !(srcString == "(null)") && (srcString.count) > 0
        {
            return false
        }
        return true
    }

    // to check is internet connectivity is available or not.
    class func isInternetAvailable() -> Bool {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    // to set localizable string into project.
    public func localize(str: String) -> String{
        return String.localizedStringWithFormat(NSLocalizedString(str, comment: ""))
    }
}
