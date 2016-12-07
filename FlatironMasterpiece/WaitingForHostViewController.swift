//
//  WaitingForHostViewController.swift
//  
//
//  Created by Erica Millado on 12/7/16.
//
//
import UIKit

class WaitingForHostViewController: UIViewController {
    
    var waitingForHostView: WaitingForHostView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
    }

    override func loadView() {
        super.loadView()
        waitingForHostView = WaitingForHostView()
        self.view = waitingForHostView
    }

}
