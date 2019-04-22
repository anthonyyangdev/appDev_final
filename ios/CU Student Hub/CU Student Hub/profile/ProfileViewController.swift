//
//  ProfileViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var profileImage: UIImageView!
    var profileInfoDisplay: UITextView!

    // Use Google API
    var switchAccount: UIButton!
    var logoutButton: UIButton!
    var profile: Profile!

    init(profile: Profile) {
        super.init(nibName: nil, bundle: nil)
        self.profile = profile
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        profileInfoDisplay = UITextView()
        profileInfoDisplay.translatesAutoresizingMaskIntoConstraints = false
        
        switchAccount = UIButton()
        switchAccount.translatesAutoresizingMaskIntoConstraints = false
        logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
    }

}
