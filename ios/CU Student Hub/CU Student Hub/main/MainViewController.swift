//
//  MainViewController.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit
import SnapKit

protocol PageRefresh: class {
    func refreshPage()
}

class MainViewController: UIViewController {

    var courseTableView: UITableView!
    var courseArray: [Course]!
    var displayedCourseArray: [Course]!
    var searchBar: UISearchBar!
    var addButton: UIBarButtonItem!
    var profileButton: UIBarButtonItem!
    let reuseIdentifier = "ClassTableViewCellReuse"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Your Courses"
        view.backgroundColor = .white
        courseArray = []
        displayedCourseArray = []
        instantiateCoursesFromDefaults()
        
        addButton = UIBarButtonItem(title: "Add Courses", style: .plain, target: self, action: #selector(pushAddViewController))
        self.navigationItem.rightBarButtonItem = addButton
        profileButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(pushProfileViewController))
        self.navigationItem.leftBarButtonItem = profileButton
        
        courseTableView = UITableView()
        courseTableView.allowsSelection = true
        courseTableView.delegate = self
        courseTableView.dataSource = self
        courseTableView.register(CourseTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        courseTableView.tableFooterView = UIView() // so there's no empty lines at the bottom
        view.addSubview(courseTableView)

        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Pick a course to chat in!"
        searchBar.backgroundColor = .white
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        setupConstraints()
        getCourses()
    }
    
    func setupConstraints() {

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        courseTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func instantiateCoursesFromDefaults() {
        if let storedCourses = userDefaults.data(forKey: "mycourses"),
            let courses = try? decode.decode([Course].self, from: storedCourses) {
            var dictionary: [String: Course] = [:]
            for course in courses {
                courseArray.append(course)
                displayedCourseArray.append(course)
                dictionary["\(course.crseId)"] = course
            }
            System.userAddedCourses = dictionary
        }
    }

    
    func getCourses(){
        if let courses = System.userAddedCourses {
            courseArray = []
            for key in courses.keys {
                if let course = courses[key] {
                    courseArray.append(course)
                } else {
                    fatalError()
                }
            }
            displayedCourseArray = courseArray
            displayedCourseArray.sort { c1, c2 -> Bool in
                c1.crseId < c2.crseId
            }
        } else {
            courseArray = []
            displayedCourseArray = []
        }
        courseTableView.reloadData()
    }

    @objc func pushProfileViewController() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc func pushAddViewController() {
        let addViewController = AddViewController()
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
    }
    
}

extension MainViewController: PageRefresh {
    func refreshPage() {
        getCourses()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CourseTableViewCell
        cell.configure(for: displayedCourseArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCourseArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let course = displayedCourseArray[index]
        System.courseSelected = course
        let locationViewController = HubViewController()
        navigationController?.pushViewController(locationViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = displayedCourseArray[indexPath.row]
            let id = "\(removed.crseId)"
            if var systemUserAdded = System.userAddedCourses {
                systemUserAdded.removeValue(forKey: id)
                System.userAddedCourses = systemUserAdded
                if let storedCourses = userDefaults.data(forKey: "mycourses"),
                    var courses = try? decode.decode([Course].self, from: storedCourses) {
                    courses.removeAll { c -> Bool in
                        c.crseId == removed.crseId && c.catalogNbr == removed.catalogNbr
                            && removed.subject == c.subject && removed.titleShort == c.titleShort
                    }
                    if let encodedCourses = try? encoder.encode(courses) {
                        userDefaults.set(encodedCourses, forKey: "mycourses")
                    }
                }
            }
            getCourses()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.courseTableView.indexPathForSelectedRow {
            self.courseTableView.deselectRow(at: index, animated: true)
        }
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text {
            displayedCourseArray = searchText.isEmpty ? courseArray : courseArray.filter {(c: Course) -> Bool in
                return "\(c.crseId)".range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                    || c.catalogNbr.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                    || c.titleShort.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                    || c.subject.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                    || "\(c.subject)\(c.catalogNbr)".range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                    || "\(c.subject) \(c.catalogNbr)".range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil

            }
            courseTableView.reloadData()
        }
    }
}

