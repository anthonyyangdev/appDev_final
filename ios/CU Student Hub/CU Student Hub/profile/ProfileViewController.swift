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
import SnapKit

class ProfileViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileImage: UIImageView! // User profile picture from Google
    var profileName: UILabel!
    
    
    var listOfClasses: UITableView!
    let course_reuse_id = "course_reuse_id"
    var listOfFavorites: UITableView!
    let favoriteLoc_reuse_id = "favorite_loc_reuse_id"

    var selectedCourses: [Course]!
    var favoriteLocations: [Location]!
    
    
    
    override func viewDidLoad() {
        title = System.currentUser
//        view.backgroundColor = .white
        view.backgroundColor = UIColor(red: 0xB3/0xFF, green: 0x1B/0xFF, blue: 0x1B/0xFF, alpha: 1)

        profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.image = System.userProfilePic
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        view.addSubview(profileImage)
        
        profileName = UILabel()
        profileName.translatesAutoresizingMaskIntoConstraints = false
        profileName.text = System.name
        profileName.font = profileName.font.withSize(30)
        profileName.textColor = .white
        view.addSubview(profileName)
        
        selectedCourses = []
        if let courses = System.userAddedCourses {
            for key in courses.keys {
                selectedCourses.append(courses[key]!)
            }
            selectedCourses.sort { (c1, c2) -> Bool in
                c1.crseId < c2.crseId
            }
        }
        
        favoriteLocations = []
        if let favorites = System.favLocation {
            for key in favorites.keys {
                favoriteLocations.append(favorites[key]!)
            }
            favoriteLocations.sort { (l1, l2) -> Bool in
                l1.name < l2.name
            }
        }
        
        listOfClasses = UITableView()
        listOfClasses.delegate = self
        listOfClasses.dataSource = self
        listOfClasses.register(CourseSelectedTableViewCell.self, forCellReuseIdentifier: course_reuse_id)
        listOfClasses.sectionHeaderHeight = 50
        view.addSubview(listOfClasses)

        listOfFavorites = UITableView()
        listOfFavorites.delegate = self
        listOfFavorites.dataSource = self
        listOfFavorites.register(FavoritesLocationProfileTableCell.self, forCellReuseIdentifier: favoriteLoc_reuse_id)
        listOfFavorites.sectionHeaderHeight = 50
        view.addSubview(listOfFavorites)
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutAccount))
        self.navigationItem.rightBarButtonItem = logoutButton
        setupConstraints()
    }

    @objc private func logoutAccount() {
        GIDSignIn.sharedInstance()?.signOut()
        let new_signIn = SignInViewController()
        navigationController?.setViewControllers([new_signIn], animated: true)
    }

    private func setupConstraints() {
        let nameHeight = view.bounds.height*(0.10)
        let paddingLR = view.bounds.width*(0.04)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor),
            profileName.heightAnchor.constraint(equalToConstant: nameHeight),
            profileName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
            profileName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
        ])
        
        listOfClasses.snp.makeConstraints { (make) in
            make.top.equalTo(profileName.snp.bottom)
            make.leading.bottom.equalToSuperview()
            make.trailing.equalTo(view.snp.centerX)
        }
        listOfFavorites.snp.makeConstraints { (make) in
            make.top.equalTo(profileName.snp.bottom)
            make.leading.equalTo(view.snp.centerX)
            make.trailing.bottom.equalToSuperview()
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.listOfClasses {
            return selectedCourses.count
        } else {
            return favoriteLocations.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.listOfClasses {
            let cell = tableView.dequeueReusableCell(withIdentifier: course_reuse_id, for: indexPath) as! CourseSelectedTableViewCell
            let index = indexPath.row
            let course = selectedCourses[index]
            cell.configure(for: course)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: favoriteLoc_reuse_id, for: indexPath) as! FavoritesLocationProfileTableCell
            let index = indexPath.row
            let location = favoriteLocations[index]
            cell.configure(for: location)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
