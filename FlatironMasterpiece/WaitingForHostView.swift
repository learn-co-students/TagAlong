//
//  WaitingForHostView.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 12/7/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class WaitingForHostView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var waitingHostLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("WaitingForHost", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }

}
