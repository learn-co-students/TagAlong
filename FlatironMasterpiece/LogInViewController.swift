

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
    var createAccountButton = UIButton()
    var forgotPasswordButton = UIButton()
    var loginButton = UIButton()
    var fbLoginButton: FBSDKLoginButton =  FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //NOTE: - hides top navcontroller
        navigationController?.isNavigationBarHidden = true
        
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

        
        //dismisses keyboard
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

        loginEmail.becomeFirstResponder()
        view.addGestureRecognizer(tap)
        
        // Logic for Logging in
        
        FirebaseManager.listenForLogIn()
        
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageView.frame = self.view.bounds
    }
    
    func createViews() {
        // login label
        view.addSubview(loginLabel)
        loginLabel.text = "Welcome"
        loginLabel.font = UIFont(name: "OpenSans-Bold", size: 30.0)
        loginLabel.textColor = UIColor.white
        loginLabel.backgroundColor = UIColor.clear
        loginLabel.layer.cornerRadius = 6
        loginLabel.layer.masksToBounds = true
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        
        // login email Textfield
        view.addSubview(loginEmail)
        loginEmail.placeholder = "  Email Address"
        loginEmail.textAlignment = .center
        loginEmail.font = UIFont(name: "OpenSans-Light", size: 16.0)
        loginEmail.layer.cornerRadius = 5
        loginEmail.layer.borderColor = phaedraDarkGreen.cgColor
        loginEmail.translatesAutoresizingMaskIntoConstraints = false
        loginEmail.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 60).isActive = true
        loginEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginEmail.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70).isActive = true
        loginEmail.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        loginEmail.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        loginEmail.autocapitalizationType = .none
        
        
        // login password textfield
        view.addSubview(loginPassword)
        loginPassword.placeholder = "Password"
        loginPassword.textAlignment = .center
        loginPassword.font = UIFont(name: "OpenSans-Light", size: 16.0)
        loginPassword.layer.cornerRadius = 5
        loginPassword.layer.borderColor = phaedraDarkGreen.cgColor
        loginPassword.translatesAutoresizingMaskIntoConstraints = false
        loginPassword.topAnchor.constraint(equalTo: loginEmail.bottomAnchor, constant: 5).isActive = true
        loginPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginPassword.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70).isActive = true
        loginPassword.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        loginPassword.backgroundColor = UIColor.white.withAlphaComponent(0.75)
        
        loginPassword.isSecureTextEntry = true
        loginPassword.autocapitalizationType = .none
        
        // login button
        view.addSubview(loginButton)
        loginButton.backgroundColor = phaedraOrange
   
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Log In", for: UIControlState.normal)
        loginButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        loginButton.titleLabel?.textAlignment = .center
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//        loginButton.setTitleColor(phaedraDarkGreen, for: .normal)
        loginButton.setTitleColor(phaedraYellow, for: .normal)
        loginButton.setTitleColor(phaedraOliveGreen, for: .highlighted)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: loginPassword.bottomAnchor, constant: 120).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Register Button
        view.addSubview(createAccountButton)
        createAccountButton.setTitle("Create An Account", for: UIControlState.normal)
        createAccountButton.layer.borderColor = phaedraLightGreen.cgColor
        createAccountButton.layer.cornerRadius = 5
        createAccountButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 15)
        createAccountButton.backgroundColor = phaedraYellow
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        createAccountButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
        createAccountButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        createAccountButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // FB Log in Button
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.delegate = self
        view.addSubview(fbLoginButton)
        fbLoginButton.center = self.view.center
        fbLoginButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 20).isActive = true
        
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        fbLoginButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 50).isActive = true
        fbLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        fbLoginButton.isHidden = true
        
        
        // Forgot Password Button
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle("Forgot Password?", for: UIControlState.normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        forgotPasswordButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 15)
        forgotPasswordButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        forgotPasswordButton.backgroundColor = UIColor.clear
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.topAnchor.constraint(equalTo: loginPassword.bottomAnchor, constant:5).isActive = true
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        forgotPasswordButton.backgroundColor = UIColor.clear
        
    }
    
    func loginButtonTapped(sender: UIButton!) {
        if self.loginEmail.text == "" || loginPassword.text == "" {
            
            //loginAlert is called
            let loginAlert = UIAlertController(title: "Incomplete Login Information", message: "Enter your complete email and password.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print("User closed alert controller")
            })
            loginAlert.addAction(okAction)
            self.present(loginAlert, animated: true, completion: nil)
            print("Enter email or password")
            
        } else {
            
            guard let email = loginEmail.text, let password = loginPassword.text else { return }
            
            FirebaseManager.loginToFirebase(email: email, password: password, completion: { (success) in
                if success {
                    print("Successful Log In")
                    
                    let storedUserCuisines = UserDefaults.standard.stringArray(forKey: "UserCuisineArray")
                    
                    let shakeInstruct = HostOrTagAlongViewController()
                    self.navigationController?.pushViewController(shakeInstruct, animated: true)
                   FirebaseManager.getUserPref()

                } else {

                    //TODO: - Notify user of error
                    print("error")
                    let loginErrorAlert = UIAlertController(title: "Invalid Credentials", message: "Please enter valid information.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        print("User closed alert controller")
                    })
                    loginErrorAlert.addAction(okAction)
                    self.present(loginErrorAlert, animated: true, completion: nil)
                }
            })
        }

    }
    
    func createAccountButtonTapped(sender: UIButton!) {
        print("register button tapped")
        
        let accountCreationVC = AccountCreationViewController()
        self.navigationController?.pushViewController(accountCreationVC, animated: true)
    }
    
    func forgotPasswordTapped(sender: UIButton!) {


        //MARK: - forgotPasswordAlert code

        let forgotPasswordAlert = UIAlertController(title: "Forgotten Password", message: "Enter your email address so we can send you info on how to reset your password.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("User cancelled in forgotPasswordAlertController")
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("User pushed OK on alertController")
            let emailField = forgotPasswordAlert.textFields![0] as UITextField
            print("the user entered \(emailField)")
            guard let email = emailField.text else { return }

        }
        
        
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Email address"
        }
        forgotPasswordAlert.addAction(cancelAction)
        forgotPasswordAlert.addAction(okAction)
        
        self.present(forgotPasswordAlert, animated: true, completion: nil)
        
        print("buttonpress")
        //        if loginEmail.text == "" {
        //            print("please type your registered email address")
        //        }
        print("user forgot password")
        
        guard let email = loginEmail.text else { return }
        
        FirebaseManager.sendPasswordReset(email: email) { (success) in
            
            if success {
                print("Reset email sent")
            }
            else {
                print("error")
            }
            
        }
        
    }
    
    
    // Facebook - Log in and log out functions
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("=================\(#function)=============\n\n\n")

        if let error = error {
            print(error.localizedDescription)
            return
        }

        
        FirebaseManager.facebookLogIn { (success) in
            
            if success {

                let preferencesVC = PreferenceViewController()
                self.navigationController?.pushViewController(preferencesVC, animated: true)
            }
                
            else {
                print("error")
            }
            
            
        }
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User has logged out")
        
        //TODO: - Segue back to login screen after user has logged out
    }
    
    
    func forgotPassword(sender: UIButton!) {
        print("user forgot password")
    }
    
}
