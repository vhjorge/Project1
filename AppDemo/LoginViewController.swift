//
//  LoginViewController.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 07/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogin.readPermissions = ["email","public_profile","user_friends"]
        btnLogin.delegate = self
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        if result.isCancelled
        {
            print("Cancelar Login")
        }
        else
        {
            print("toke \(result.token.tokenString)")
            performSegue(withIdentifier: "SegueLogin", sender: self)
        }
    }
       
   func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
   { }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var btnLogin: FBSDKLoginButton!

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
