//
//  ProfileViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class ProfileViewController: UINavigationController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var profileImage: UIImageView! // User profile picture from Google

    // Potentially can change to an array/series of UILabels for better styling.
    var profileInfoDisplay: UITextView!  // Brief Information About the User

    // Use Google API
//    var switchAccount: UIButton!
//    var logoutButton: UIButton!
    // Retire in preference for a logout button on the navigation bar.
    
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
        // profileImage.getFromServer() Get image data from Google Server
        view.addSubview(profileImage)
        
        profileInfoDisplay = UITextView()
        profileInfoDisplay.translatesAutoresizingMaskIntoConstraints = false
        profileInfoDisplay.text = ""  // Email? School Year? Major? Fun Fact?
        view.addSubview(profileInfoDisplay)
        

        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutAccount))
        self.navigationItem.rightBarButtonItem = logoutButton

//        switchAccount = UIButton()
//        switchAccount.translatesAutoresizingMaskIntoConstraints = false
//
//        // Switch with Google Button for switch account
//        switchAccount.setTitle("Switch Account", for: .normal)
//        view.addSubview(switchAccount)
//
//        logoutButton = UIButton()
//        logoutButton.translatesAutoresizingMaskIntoConstraints = false
//
//        // Switch with Google Button for logout account
//        logoutButton.setTitle("Logout", for: .normal)
//        view.addSubview(logoutButton)

        setupConstraints()
    }

    @objc private func logoutAccount() {
        
        // Network to end account session
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileInfoDisplay.topAnchor.constraint(equalTo: profileImage.bottomAnchor),
            profileInfoDisplay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
