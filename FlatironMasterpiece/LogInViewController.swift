//
//  LogInViewController.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        var loginLabel = UILabel()
        var loginEmail = UITextField()
        var loginPassword = UITextField()
        var registerButton = UIButton()
        var forgotPasswordButton = UIButton()
        var loginButton = UIButton()
        var fbLoginButton: FBSDKLoginButton =  FBSDKLoginButton()

        
        //need to add LOGIN SCREEN label at very top of view
        view.addSubview(loginLabel)
        loginLabel.text = "Log In"
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // login email Textfield
        view.addSubview(loginEmail)
        loginEmail.placeholder = "  Email Address"
        loginEmail.layer.borderWidth = 1
        loginEmail.layer.cornerRadius = 5
        loginEmail.layer.borderColor = UIColor.lightGray.cgColor
        loginEmail.translatesAutoresizingMaskIntoConstraints = false
        loginEmail.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30).isActive = true
        loginEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginEmail.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginEmail.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        view.addSubview(loginPassword)
        loginPassword.placeholder = "  App Password"
        loginPassword.layer.borderWidth = 1
        loginPassword.layer.cornerRadius = 5
        loginPassword.layer.borderColor = UIColor.lightGray.cgColor
        loginPassword.translatesAutoresizingMaskIntoConstraints = false
        loginPassword.topAnchor.constraint(equalTo: loginEmail.bottomAnchor, constant: 5).isActive = true
        loginPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginPassword.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginPassword.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        
        
        view.addSubview(loginButton)
        loginButton.setTitle("Log In", for: UIControlState.normal)
        loginButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: loginPassword.bottomAnchor, constant: 20).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        
        view.addSubview(registerButton)
        registerButton.setTitle("Register?", for: UIControlState.normal)
        registerButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        

        // FB Log in Button
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.delegate = self
        view.addSubview(fbLoginButton)
        fbLoginButton.center = self.view.center
        fbLoginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20).isActive = true

        
        
        
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle("Forgot Password?", for: UIControlState.normal)
        forgotPasswordButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 120).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
    
    
    
    
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("=================\(#function)=============\n\n\n")
        
        if let error = error {
            
            print(error.localizedDescription)
            return
        }
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)

        
        if let token = FBSDKAccessToken.current() {
            
            print("ALl good")
            
            
            if let tokenString = token.tokenString {
                
                print("Token string is here \(tokenString)")
            }
            
        } else {
            
            
        }
        
        
        
        
//        
//        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//
//        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
//
//            print("User has logged into Firebase")
//            
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }

            
            
        
        print("User has logged in")
        
        print("=====================================================\n\n\n")

        
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User has logged out")
    }

}
