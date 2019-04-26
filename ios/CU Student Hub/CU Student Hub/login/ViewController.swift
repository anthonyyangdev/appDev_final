//
//  ViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/19/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit
import SnapKit

// This will be the beginning of the App, i.e. the login screen
// Uses the Google Developer Kit for sign in
class ViewController: UIViewController {

    var logo: UIImageView!
//    var usernameInput: UITextField!
//    var passwordInput: UITextField!
    var loginButton: UIButton!
    var aboutButton: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)

//        usernameInput = UITextField()
//        usernameInput.translatesAutoresizingMaskIntoConstraints = false
//        usernameInput.layer.borderColor = UIColor.black.cgColor
//        usernameInput.layer.borderWidth = 2
//        view.addSubview(usernameInput)
//
//        passwordInput = UITextField()
//        passwordInput.translatesAutoresizingMaskIntoConstraints = false
//        passwordInput.layer.borderColor = UIColor.black.cgColor
//        passwordInput.layer.borderWidth = 2
//        view.addSubview(passwordInput)

        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.setTitle("Login with Google", for: .normal)
        view.addSubview(loginButton)
        
        aboutButton = UILabel()
        aboutButton.text = "About"
        aboutButton.textColor = .blue
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: aboutButton)
        
        setupConstraints()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupConstraints() {
        let height = view.bounds.height
        let width = view.bounds.width
        let loginHeight = height/20
        let loginWidth = width*2/5

        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: loginHeight),
            loginButton.widthAnchor.constraint(equalToConstant: loginWidth)
        ])
        
//        NSLayoutConstraint.activate([
//            usernameInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
//            usernameInput.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            usernameInput.heightAnchor.constraint(equalToConstant: textHeight),
//            usernameInput.widthAnchor.constraint(equalToConstant: textWidth),
//        ])
//
//        NSLayoutConstraint.activate([
//            passwordInput.topAnchor.constraint(equalTo: usernameInput.bottomAnchor, constant: ySpacing),
//            passwordInput.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            passwordInput.heightAnchor.constraint(equalToConstant: textHeight),
//            passwordInput.widthAnchor.constraint(equalToConstant: textWidth),
//        ])
        
    }


}

