//
//  ProfileVC.swift
//  FBAuth
//
//  Created by Swayam Infotech on 23/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ProfileVC: UIViewController {
    
    // define outlets for details display.
    @IBOutlet var imgProfilePicture: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblID: UILabel!

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        // apply round shape and border for profile picture.
        imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.size.width / 2
        imgProfilePicture.clipsToBounds = true
        imgProfilePicture.layer.borderColor = theamColor.cgColor
        imgProfilePicture.layer.borderWidth = 2.0

        // set theme color to profile details
        lblName.textColor = theamColor
        lblEmail.textColor = theamColor
        lblID.textColor = theamColor
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        // to set title of the screen.
        self.title = Util.sharedInstance.localize(str: "profile_details")

        // to get facebook user details.
        getUserDetail()
    }

    func getUserDetail() {

        let parameters = ["fields":"email,name,first_name,last_name, gender, birthday,picture.type(large)"]

        GraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in

            if error != nil {

                print(error?.localizedDescription as Any)

            }else{

                if let graphResponse = result as? NSDictionary {

                    // to display name of logged in user.
                    self.lblName.text = ""
                    if let displayName = graphResponse["name"] as? String {
                        self.lblName.text = displayName
                    }

                    // to display email of logged in user.
                    self.lblEmail.text = ""
                    if let emailAddress = graphResponse["email"] as? String {
                        self.lblEmail.text = emailAddress
                    }

                    // to display id of logged in user.
                    self.lblID.text = ""
                    if let facebookID = graphResponse["id"] as? String {
                        self.lblID.text = "ID: "+facebookID
                    }

                    // to display profile picture of logged in user.
                    if let profilePictureDetails = graphResponse["picture"] as? [String:Any] {
                        if let profilePictureData = profilePictureDetails["data"] as? [String:Any] {
                            if let profilePictureURL = profilePictureData["url"] as? String {
                                if !Util.isStringNull(srcString: profilePictureURL) {
                                    self.imgProfilePicture.load(url: URL(string: "\(profilePictureURL)")!)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
