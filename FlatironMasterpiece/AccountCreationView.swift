//
//  AccountCreationView.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let FIRSTNAME = "firstNameTextField"
    static let LASTNAME = "lastNameTextField"
    static let EMAILCONFIRMATION = "emailTextField"
    static let PASSWORD = "password"
    static let INDUSTRY = "industry"
    static let JOBTITLE = "jobtitle"
    
}

class AccountCreationView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameEntryTextField: UITextField!
    @IBOutlet weak var lastNameEntryTextField: UITextField!
    @IBOutlet weak var emailEntry: UITextField!
    @IBOutlet weak var passwordEntry: UITextField!
    @IBOutlet weak var passwordVerification: UITextField!
    @IBOutlet weak var industryEntry: UITextField!
    @IBOutlet weak var jobEntry: UITextField!
    
    var firstNameConfirmed = false
    var lastNameConfirmed = false
    var emailConfirmed = false
    var password = false
    var industry = false
    var jobtitle = false
    
//    firstNameEntry
//    lastNameEntry
//    emailEntry
//    passwordEntry
//    passwordVerification
//    industryEntry
//    jobEntry
//    
    
    
}
