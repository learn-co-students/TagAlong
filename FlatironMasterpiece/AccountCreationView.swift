////
////  AccountCreationView.swift
////  FlatironMasterpiece
////
////  Created by Elias Miller on 11/17/16.
////  Copyright © 2016 Elias Miller. All rights reserved.
////
//
import Foundation
import UIKit

//struct Constants {
//    static let FIRSTNAME = "firstNameTextField"
//    static let LASTNAME = "lastNameTextField"
//    static let EMAILCONFIRMATION = "emailTextField"
//    static let PASSWORD = "password"
//    static let PASSWORDVERIFICATION = "passwordverification"
//    static let INDUSTRY = "industry"
//    static let JOBTITLE = "jobtitle"
//
//}


//class AccountCreationView: UIViewController, UITextFieldDelegate {
//
//
//
//    var firstNameConfirmed = false
//    var lastNameConfirmed = false
//    var emailConfirmed = false
//    var password = false
//    var industry = false
//    var jobtitle = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        firstNameEntryTextField.accessibilityLabel = Constants.FIRSTNAME
//        lastNameEntryTextField.accessibilityLabel = Constants.LASTNAME
//        emailEntryTextField.accessibilityLabel = Constants.EMAILCONFIRMATION
//        passwordEntryTextField.accessibilityLabel = Constants.PASSWORD
//        passwordVerificationTextField.accessibilityLabel = Constants.PASSWORDVERIFICATION
//        industryEntryTextField.accessibilityLabel = Constants.INDUSTRY
//        jobEntryTextField.accessibilityLabel = Constants.JOBTITLE
//
//    }
//
//    func animateFields(textField: UITextField, isInputValid: Bool) {
//        let greenColor = UIColor.green.withAlphaComponent(0.1)
//        let redColor = UIColor.red.withAlphaComponent(0.1)
//        let unchangedState = textField.transform
//        let pulseScale: CGFloat = 1.03
//        let shake = textField.frame.width * 0.02
//
//        if isInputValid {
//            UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
//                    textField.backgroundColor = greenColor
//                }
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
//                    textField.transform = CGAffineTransform(scaleX: pulseScale, y: pulseScale)
//                }
//                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1/3) {
//                    textField.transform = unchangedState
//                }
//
//            }, completion: nil)
//
//
//
//
//        }
//
//        switch textField.accessibilityLabel! {
//        case Constants.FIRSTNAME:
//            firstNameConfirmed = true
//        case Constants.LASTNAME:
//            lastNameConfirmed = true
//        case Constants.EMAILCONFIRMATION:
//            emailConfirmed = true
//        case Constants.PASSWORDVERIFICATION:
//            password = true
//        case Constants.INDUSTRY:
//            industry = true
//        case Constants.JOBTITLE:
//            jobtitle = true
//        default:
//            break
//
//        }
//
//        func isFormCompleted() -> Bool {
//            return firstNameConfirmed && lastNameConfirmed && emailConfirmed && password && industry && jobtitle
//        }
//
//        if isFormCompleted() {
//            submitButton.isEnabled = true
//        } else {
//            UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
//                    textField.backgroundColor = redColor
//                }
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3) {
//                    textField.transform = CGAffineTransform(translationX: shake, y: 0)
//                }
//                UIView.addKeyframe(withRelativeStartTime: 1 / 3, relativeDuration: 1 / 3) {
//                    textField.transform = CGAffineTransform(translationX: shake * -2, y: 0)
//                }
//                UIView.addKeyframe(withRelativeStartTime: 2 / 3, relativeDuration: 1 / 3) {
//                    textField.transform = unchangedState
//                }
//            }, completion: nil)
//            switch textField.accessibilityLabel! {
//            case Constants.FIRSTNAME:
//                firstNameConfirmed = false
//            case Constants.LASTNAME:
//                lastNameConfirmed = false
//            case Constants.EMAILCONFIRMATION:
//                emailConfirmed = false
//            case Constants.PASSWORDVERIFICATION:
//                password = false
//            case Constants.INDUSTRY:
//                industry = false
//            case Constants.JOBTITLE:
//                jobtitle = false
//            default:
//                break
//            }
//        }
//    }
//
//    @IBAction func textFieldDidBeginEditing(_ sender: AnyObject) {
//        let textField = sender as! UITextField
//        textField.backgroundColor = UIColor.white
//    }
//
//    @IBAction func firstNameTextFieldEdit(_ sender: AnyObject) {
////        if !sender.text!.isEmpty {
////            animateFields(textField: sender as! UITextField, isInputValid: sender.text!.contains())
////        }
//    }
//
//    @IBAction func emailTextFieldEdit(_ sender: AnyObject) {
//        if !sender.text!.isEmpty {
//            animateFields(textField: sender as! UITextField, isInputValid: sender.text!.contains("@") && emailEntryTextField.text!.contains("."))
//        }
//    }
//
//    @IBAction func passWordTextFieldEdit(_ sender: AnyObject) {
//        if !sender.text!.isEmpty {
//            animateFields(textField: sender as! UITextField, isInputValid: sender.text!.characters.count >= 5)
//        }
//    }
//
//    @IBAction func passwordConfirmationTextFieldEdit(_ sender: AnyObject) {
//        if !sender.text!.isEmpty {
//            animateFields(textField: sender as! UITextField, isInputValid: sender.text! == passwordEntryTextField.text!)
//        }
//    }
//
//
//
//}





//    firstNameEntry
//    lastNameEntry
//    emailEntry
//    passwordEntry
//    passwordVerification
//    industryEntry
//    jobEntry
//
