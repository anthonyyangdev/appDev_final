//
//  AddViewController.swift
//  CU Student Hub
//
//  Created by Lauren on 5/1/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

protocol ChooseSubject: class {
    func updateSubject(with subject: Subject)
}

class AddViewController: UIViewController {

    var courseTableView: UITableView!
    var courseArray: [Course]!
    var displayedCourseArray: [Course]!
    var searchField: UISearchBar!
    var addButton: UIButton!
    var subject: Subject!
    
    weak var delegate: PageRefresh?
    
    let textCellReuseIdentifier = "textCellReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseArray = []
        displayedCourseArray = []
        subject = .CS
        title = "Add Courses"
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        
        courseTableView = UITableView()
        courseTableView.allowsSelection = false
        courseTableView.delegate = self
        courseTableView.dataSource = self
        courseTableView.register(CourseTableViewCell.self, forCellReuseIdentifier: textCellReuseIdentifier)
        courseTableView.tableFooterView = UIView() // so there's no empty lines at the bottom
        courseTableView.allowsMultipleSelection = true
        view.addSubview(courseTableView)
        
        searchField = UISearchBar()
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.placeholder = "Search a location to chat at!"
        searchField.backgroundColor = .white
        searchField.delegate = self
        view.addSubview(searchField)
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add Selected Courses", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = UIColor.lightGray
        addButton.addTarget(self, action: #selector(addSelectedCourses), for: .touchUpInside)
        view.addSubview(addButton)
        
        let filter = UIBarButtonItem(title: "Choose Subject", style: .plain, target: self, action: #selector(openSubjectPicker))
        navigationItem.rightBarButtonItem = filter
        
        setupConstraints()
        getCourses()
    }
    
    private func setupConstraints() {
        courseTableView.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 40),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func getCourses(){
        NetworkManager.getClasses(subject: subject, completion: { courses in
            self.courseArray = courses
            self.displayedCourseArray = self.courseArray
            DispatchQueue.main.async {
                self.courseTableView.reloadData()
            }
        })
    }
    
    @objc private func openSubjectPicker() {
        let subjectPicker = SubjectPageSelectViewController()
        subjectPicker.delegate = self
        navigationController?.pushViewController(subjectPicker, animated: true)
    }
    
    @objc private func addSelectedCourses() {
        var selectedCourses: [Course] = []
        if let selectedRows = courseTableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                let index = indexPath.row
                let course = displayedCourseArray[index]
                selectedCourses.append(course)
            }
            
            var coursesAdded = 0
            if var userAddedCourses = System.userAddedCourses {
                for c in selectedCourses {
                    if userAddedCourses["\(c.crseID)"] == nil {
                       userAddedCourses["\(c.crseID)"] = c
                        coursesAdded += 1
                    }
                }
                System.userAddedCourses = userAddedCourses
            } else {
                var dict: [String: Course] = [:]
                for c in selectedCourses {
                    dict["\(c.crseID)"] = c
                    coursesAdded += 1
                }
                System.userAddedCourses = dict
            }
            
            let alert: UIAlertController
            if coursesAdded == 1 {
                alert = UIAlertController(title: "Added Courses", message: "\(coursesAdded) course has been added!", preferredStyle: UIAlertController.Style.alert)
            } else {
                alert = UIAlertController(title: "Added Courses", message: "\(coursesAdded) courses have been added!", preferredStyle: UIAlertController.Style.alert)
            }
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            if let d = delegate {
                d.refreshPage()
            } else {
                fatalError()
            }
            
        } else {
            return
        }
    }
    
    @objc func pushProfileViewController() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc func pushAddViewController() {
        let addViewController = AddViewController()
        navigationController?.pushViewController(addViewController, animated: true)
    }
    
}

extension AddViewController: ChooseSubject {
    func updateSubject(with subject: Subject) {
        self.subject = subject
        getCourses()
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellReuseIdentifier, for: indexPath) as! CourseTableViewCell
        cell.configure(for: displayedCourseArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCourseArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension AddViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text {
            displayedCourseArray = searchText.isEmpty ? courseArray : courseArray.filter {(c: Course) -> Bool in
                return "\(c.crseID)".range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                    || c.catalogNbr.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                    || c.titleShort.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            courseTableView.reloadData()
        }
    }
}
