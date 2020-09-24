//
//  ViewController.swift
//  FBAuth
//
//  Created by Swayam Infotech on 23/09/20.
//  Copyright © 2020 Swayam Infotech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeVC: UIViewController {

    var defaultFacebookButton = FBLoginButton()
    var customFacebookButton = UIButton()
    
    override func viewDidLoad() {

        super.viewDidLoad()

        // to set title for screen.
        self.title = Util.sharedInstance.localize(str: "name")

        // to logout from facebook
        let manager = LoginManager()
        manager.logOut()

        if showDefaultButton == 1 {
            // to add facebook default button.
            addFacebookDefaultButton()
        }else{
            // to add facebook custom button.
            addFacebookCustomButton()
        }
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        // to check custom facebook login button already user logged in or not.
        if let token = AccessToken.current,!token.isExpired {
            customFacebookButton.setTitle("Logout", for: .normal)
        }else{
            customFacebookButton.setTitle(Util.sharedInstance.localize(str: "continue_with_facebook"), for: .normal)
        }
    }

    func addFacebookDefaultButton() {

        self.view.addSubview(defaultFacebookButton)
        defaultFacebookButton.center = self.view.center
        defaultFacebookButton.permissions = ["public_profile", "email"]
        defaultFacebookButton.delegate = self
    }

    func addFacebookCustomButton() {

        customFacebookButton.layer.cornerRadius = 5.0
        customFacebookButton.clipsToBounds = true
        customFacebookButton = UIButton(frame: CGRect(x: (screenWidth/2) - 105, y: screenHeight/2, width: 210, height: 35))
        defaultFacebookButton.center = self.view.center
        customFacebookButton.backgroundColor = theamColor
        customFacebookButton.setTitle(Util.sharedInstance.localize(str: "continue_with_facebook"), for: .normal)
        customFacebookButton.addTarget(self, action:#selector(self.facebookCustomButtonAction), for: .touchUpInside)
        self.view.addSubview(customFacebookButton)
    }

    @objc func facebookCustomButtonAction() {

        // to check internet connectivity available or not.
        if (Util.isInternetAvailable()){

            let login : LoginManager = LoginManager.init()

            if let token = AccessToken.current,!token.isExpired {

                // already logged in.
                login.logOut()
                customFacebookButton.setTitle(Util.sharedInstance.localize(str: "continue_with_facebook"), for: .normal)

            }else{
                
                // not logged in.
                login.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in

                    guard let result = result else { return }

                    if error != nil{
                        print(error?.localizedDescription as Any)
                    }else if result.isCancelled{
                        print("facebook login cancelled")
                    }else{
                        // redirect to profile screen.
                        let vc = Util.getStoryboard().instantiateViewController(withIdentifier: "ProfileVC")
                        SharedAppDelegate.navigationVC.pushViewController(vc, animated: true)
                    }
                }
            }

        }else{
            Alert.shared.ShowAlert(title: "internet_not_available", message: "", in: self);
        }
    }
}

extension HomeVC: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {

        guard let result = result else { return }

        if error != nil{
            print(error?.localizedDescription as Any)
        }else if result.isCancelled{
            print("facebook login cancelled")
        }else{
            // redirect to profile screen.
            let vc = Util.getStoryboard().instantiateViewController(withIdentifier: "ProfileVC")
            SharedAppDelegate.navigationVC.pushViewController(vc, animated: true)
        }
    }
}
