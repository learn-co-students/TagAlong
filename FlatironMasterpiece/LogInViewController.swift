
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
    
    var imageView: UIImageView!
    var loginLabel = UILabel()
    var loginEmail = UITextField()
    var loginPassword = UITextField()
    var registerButton = UIButton()
    var forgotPasswordButton = UIButton()
    var loginButton = UIButton()
    var fbLoginButton: FBSDKLoginButton =  FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("login view controller working")
        
        //Code needed for Core motion
        self.becomeFirstResponder()
        
        //sets background image
        let backgroundImage = UIImage(named: "foodWoodenTable")
        self.imageView = UIImageView(frame: CGRect.zero)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = backgroundImage
        self.imageView.alpha = 1.0
        self.view.addSubview(imageView)
        createViews()
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        loginEmail.becomeFirstResponder()
        view.addGestureRecognizer(tap)

        // Logic for Logging in
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                // Move to next screen
                // Add logout button to user's settings screen
            } else {
                // No user is signed in.
                // Display log in screen
                // createViews()
            }
        }
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageView.frame = self.view.bounds
    }
    
    
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEventSubtype.motionShake) {
            print("shaken")
            loginEmail.text? = ""
        }
    }
    
    
    func createViews() {
        // login label
        view.addSubview(loginLabel)
        loginLabel.text = "Log In"
        loginLabel.font = UIFont(name: "OpenSans-Bold", size: 30.0)
        loginLabel.textColor = UIColor.white
        loginLabel.backgroundColor = UIColor.clear
        loginLabel.layer.cornerRadius = 6
        loginLabel.layer.masksToBounds = true
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // login email Textfield
        view.addSubview(loginEmail)
        loginEmail.placeholder = "  Email Address"
        loginEmail.textAlignment = .center
        loginEmail.font = UIFont(name: "OpenSans-Light", size: 14.0)
        loginEmail.layer.borderWidth = 2
        loginEmail.layer.cornerRadius = 5
        loginEmail.layer.borderColor = phaedraDarkGreen.cgColor
        loginEmail.translatesAutoresizingMaskIntoConstraints = false
        loginEmail.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 150).isActive = true
        loginEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginEmail.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginEmail.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        loginEmail.backgroundColor = UIColor.white
        loginEmail.autocapitalizationType = .none

   
        // login password textfield
        view.addSubview(loginPassword)
        loginPassword.placeholder = "Password"
        loginPassword.textAlignment = .center
        loginPassword.font = UIFont(name: "OpenSans-Light", size: 14.0)
        loginPassword.layer.borderWidth = 2
        loginPassword.layer.cornerRadius = 5
        loginPassword.layer.borderColor = phaedraDarkGreen.cgColor
        loginPassword.translatesAutoresizingMaskIntoConstraints = false
        loginPassword.topAnchor.constraint(equalTo: loginEmail.bottomAnchor, constant: 5).isActive = true
        loginPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginPassword.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginPassword.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        loginPassword.backgroundColor = UIColor.white
        loginPassword.isSecureTextEntry = true
        loginPassword.autocapitalizationType = .none
        
        // login button
        view.addSubview(loginButton)
        loginButton.backgroundColor = phaedraYellow
        loginButton.layer.borderColor = phaedraLightGreen.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Enter", for: UIControlState.normal)
        loginButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.setTitleColor(phaedraDarkGreen, for: .normal)
        loginButton.setTitleColor(phaedraOliveGreen, for: .highlighted)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: loginPassword.bottomAnchor, constant: 150).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Register Button
        view.addSubview(registerButton)
        registerButton.setTitle("Create An Account", for: UIControlState.normal)
        registerButton.layer.borderColor = phaedraLightGreen.cgColor
        registerButton.layer.borderWidth = 2
        registerButton.layer.cornerRadius = 5
        registerButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 15)
        registerButton.backgroundColor = phaedraYellow
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
        registerButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // FB Log in Button
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.delegate = self
        view.addSubview(fbLoginButton)
        fbLoginButton.center = self.view.center
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        fbLoginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 50).isActive = true
        fbLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true

        
        // Forgot Password Button
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle("Forgot Password?", for: UIControlState.normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        forgotPasswordButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 10)
        forgotPasswordButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        forgotPasswordButton.backgroundColor = UIColor.clear
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.topAnchor.constraint(equalTo: loginPassword.bottomAnchor, constant:15).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
    }
    
    func loginButtonTapped(sender: UIButton!) {
        
        if self.loginEmail.text == "" || loginPassword.text == "" {
            // TODO: - Create action
            print("Enter email or password")
        } else {
            guard let email = loginEmail.text, let password = loginPassword.text else { return }
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error == nil {
                    print("Successful Log In")
                    //TODO: - Send to next screen after logging in
                    // Send to preferences (for now)
                    let preferencesVC = PreferenceViewController()
                    self.navigationController?.pushViewController(preferencesVC, animated: true)
                }
                else {
                    //TODO: - Notify user of error
                    print(error?.localizedDescription)
                }
            })
        }
        
        if self.loginEmail.text == "" || loginPassword.text == "" {
            
            // TODO: - Create action
            
            print("Enter email or password")
            
            //For testing purposes
            FIRAuth.auth()?.signIn(withEmail: "joyce@gmail.com", password: "123456", completion: { (user, error) in
                if error == nil {
                    print("Successful Log In")
                    //TODO: - Send to next screen after logging in
                }
                    
                else {
                    //TODO: - Notify user of error
                    print(error?.localizedDescription)
//                    let alert = UIAlertController(title: "Invalid credentials", message: "Please enter a valid email and password", preferredStyle: .alert)
//                    show(alert, sender: self)
                }
            })
            
            
            
        } else {
            
            guard let email = loginEmail.text, let password = loginPassword.text else { return }
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("Successful Log In")
                    //TODO: - Send to next screen after logging in
                }
                else {
                    //TODO: - Notify user of error
                    print(error?.localizedDescription)
                    
                }
            })
            
        }
        
    }
    
    func registerButtonTapped(sender: UIButton!) {
        print("register button tapped")
        let accountCreationVC = AccountCreationViewController()
        self.navigationController?.pushViewController(accountCreationVC, animated: true)
    }
    
    func forgotPasswordTapped(sender: UIButton!) {
        
        let forgotPasswordAlert = UIAlertController(title: "Forgotten Password", message: "Your password has been emailed to you.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("User pushed OK on alertController")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("User cancelled in alertController")
        }
        forgotPasswordAlert.addAction(OKAction)
        forgotPasswordAlert.addAction(cancelAction)
//        forgotPasswordAlert.addTextField { (<#UITextField#>) in
//            <#code#>
//        }
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    
        print("buttonpress")
        //        if loginEmail.text == "" {
        //            print("please type your registered email address")
        //        }
        print("user forgot password")
        
        
        guard let email = loginEmail.text else { return }
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("reset email sent")
            }
            else {
                print(error?.localizedDescription)
            }
        })
    }
    
    
    // Facebook - Log in and log out functions
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("=================\(#function)=============\n\n\n")
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        if let token = FBSDKAccessToken.current() {
            print("ALL good")
            if let tokenString = token.tokenString {
                print("Token string is here \(tokenString)")
            }
            
        } else {
        }
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            print("User has logged into Firebase")
            // TODO: - Segue into home screen after user has logged in
            // Send to preferences (for now)
            let preferencesVC = PreferenceViewController()
            self.navigationController?.pushViewController(preferencesVC, animated: true)
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
        print("User has logged in")
        print("=====================================================\n\n\n")
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User has logged out")
        
        //TODO: - Segue back to login screen after user has logged out
    }
    
    
    
    // Testing Segue to chat
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showChat" {
    //
    //            let chatVC = segue.destination as! ChatViewController
    //            let allChatsRef = FIRDatabase.database().reference().child("chats")
    //            // chatRef should point to only one single chat --- eventually Auto ID
    //            chatVC.chatRef = allChatsRef.child("testChat")
    //
    //        }
    //    }
    
    
    
    
    
    
    
}
