//
//  ProfileViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 4/22/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController {

    var profileImage: UIImageView! // User profile picture from Google
    var profileName: UILabel!
    
    var profileYear: UILabel!
    var profileYearInput: UITextField!
    
    var profileMajor: UILabel!
    var profileMajorInput: UITextField!
    
    var profileFunFact: UILabel!
    var profileFunFactInput: UITextView!
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func viewDidLoad() {
        title = System.currentUser
        view.backgroundColor = .white
        
        profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        if let url = System.userImage {
            getData(from: url) { (data, response, error) in
                guard let data = data, error == nil else {return}
                DispatchQueue.main.async {
                    self.profileImage.image = UIImage(data: data)
                    self.profileImage.sizeToFit()
                }
            }
        } else {
            print("\n\nNo profile Image found!\n\n")
        }
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        view.addSubview(profileImage)
        
        profileName = UILabel()
        profileName.translatesAutoresizingMaskIntoConstraints = false
        profileName.text = System.name
        profileName.font = profileName.font.withSize(30)
        view.addSubview(profileName)
        
        profileYear = UILabel()
        profileYear.translatesAutoresizingMaskIntoConstraints = false
        profileYear.text = "Year:"
        profileMajor = UILabel()
        profileMajor.translatesAutoresizingMaskIntoConstraints = false
        profileMajor.text = "Major:"
        profileFunFact = UILabel()
        profileFunFact.translatesAutoresizingMaskIntoConstraints = false
        profileFunFact.text = "Fun Fact:"
        view.addSubview(profileYear)
        view.addSubview(profileMajor)
        view.addSubview(profileFunFact)

        profileYearInput = UITextField()
        profileYearInput.translatesAutoresizingMaskIntoConstraints = false
        if let year = System.profileYear {
            profileYearInput.text = year
        } else {
            profileYearInput.text = ""
        }
        profileYearInput.layer.borderColor = UIColor.black.cgColor
        profileYearInput.layer.borderWidth = 1
        profileYearInput.addTarget(self, action: #selector(yearChanged), for: .editingChanged)

        profileMajorInput = UITextField()
        profileMajorInput.translatesAutoresizingMaskIntoConstraints = false
        if let major = System.profileMajor {
            profileMajorInput.text = major
        } else {
            profileMajorInput.text = ""
        }
        profileMajorInput.layer.borderColor = UIColor.black.cgColor
        profileMajorInput.layer.borderWidth = 1
        profileMajorInput.addTarget(self, action: #selector(majorChanged), for: .editingChanged)

        profileFunFactInput = UITextView()
        profileFunFactInput.translatesAutoresizingMaskIntoConstraints = false
        if let funFact = System.profileFunFact {
            profileFunFactInput.text = funFact
        } else {
            profileFunFactInput.text = ""
        }
        profileFunFactInput.font = profileFunFactInput.font?.withSize(18)
        profileFunFactInput.layer.borderColor = UIColor.black.cgColor
        profileFunFactInput.layer.borderWidth = 1
        profileFunFactInput.isEditable = true
        profileFunFactInput.delegate = self
        
        view.addSubview(profileYearInput)
        view.addSubview(profileMajorInput)
        view.addSubview(profileFunFactInput)

        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutAccount))
        self.navigationItem.rightBarButtonItem = logoutButton
    
        setupConstraints()
    }

    @objc private func logoutAccount() {
        GIDSignIn.sharedInstance()?.signOut()
        let new_signIn = SignInViewController()
        navigationController?.setViewControllers([new_signIn], animated: true)
    }
    
    @objc private func yearChanged() {
        if let year = profileYearInput.text {
            System.profileYear = year
        }
    }

    @objc private func majorChanged() {
        if let major = profileMajorInput.text {
            System.profileMajor = major
        }
    }
    
    private func setupConstraints() {
        let nameHeight = view.bounds.height*(0.10)
        let paddingLR = view.bounds.width*(0.04)
        let fieldHeight = view.bounds.height*(0.03)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor),
            profileName.heightAnchor.constraint(equalToConstant: nameHeight),
            profileName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR)
        ])

        NSLayoutConstraint.activate([
            profileYear.topAnchor.constraint(equalTo: profileName.bottomAnchor),
            profileYear.heightAnchor.constraint(equalToConstant: fieldHeight),
            profileYear.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileYear.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
            
            profileYearInput.topAnchor.constraint(equalTo: profileYear.bottomAnchor),
            profileYearInput.heightAnchor.constraint(equalToConstant: fieldHeight),
            profileYearInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileYearInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR)
        ])

        NSLayoutConstraint.activate([
            profileMajor.topAnchor.constraint(equalTo: profileYearInput.bottomAnchor),
            profileMajor.heightAnchor.constraint(equalToConstant: fieldHeight),
            profileMajor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileMajor.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
            
            profileMajorInput.topAnchor.constraint(equalTo: profileMajor.bottomAnchor),
            profileMajorInput.heightAnchor.constraint(equalToConstant: fieldHeight),
            profileMajorInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileMajorInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR)
        ])

        NSLayoutConstraint.activate([
            profileFunFact.topAnchor.constraint(equalTo: profileMajorInput.bottomAnchor),
            profileFunFact.heightAnchor.constraint(equalToConstant: fieldHeight),
            profileFunFact.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileFunFact.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
            
            profileFunFactInput.topAnchor.constraint(equalTo: profileFunFact.bottomAnchor),
            profileFunFactInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileFunFactInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileFunFactInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR)
            ])
    }
    
}

extension ProfileViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let funFact = profileFunFactInput.text {
            System.profileFunFact = funFact
        }
        profileFunFactInput.font = profileFunFactInput.font?.withSize(18)
    }
}
