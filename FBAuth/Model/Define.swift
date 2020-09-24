//
//  Define.swift
//  FBAuth
//
//  Created by Swayam Infotech on 23/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import Foundation
import UIKit

let SharedAppDelegate = UIApplication.shared.delegate as! AppDelegate

// to get screen height and width.
let screenHeight = UIScreen.main.bounds.size.height
let screenWidth =  UIScreen.main.bounds.size.width

// to identify particular device.
let IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_IPHONE_5 = IS_IPHONE && UIScreen.main.bounds.size.height == 568.0
let IS_IPHONE_6 = IS_IPHONE && UIScreen.main.bounds.size.height == 667.0
let IS_IPHONE_6_PLUS = IS_IPHONE && UIScreen.main.bounds.size.height == 736.0
let IS_IPHONE_4 = IS_IPHONE && UIScreen.main.bounds.size.height == 480.0
let IS_IPHONE_X = IS_IPHONE && (UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0)

// to change apperiance of UI.
let theamColor = UIColor(red: 61.0/255.0, green: 87.0/255.0, blue: 157.0/255.0, alpha: 1.0)

// to show custom of default button of facebook.
let showDefaultButton = 0 // 1-Facebook default button, 0-Facebook custom button
