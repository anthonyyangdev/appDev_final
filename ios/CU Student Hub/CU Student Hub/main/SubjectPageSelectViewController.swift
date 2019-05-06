//
//  SubjectPageSelectViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 5/4/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit
import SnapKit

class SubjectPageSelectViewController: UIViewController {

    var subjectPicker: UIPickerView!
    var searchBar: UITextField!

    weak var delegate: ChooseSubject!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
            // UIColor(red: 0xB3/0xFF, green: 0x1B/0xFF, blue: 0x1B/0xFF, alpha: 1)

        title = "Choose a Subject"
        subjectPicker = UIPickerView(frame: CGRect(origin: CGPoint(x: 0, y: view.frame.height/3), size: CGSize(width: view.frame.width, height: 320.0)))
        subjectPicker.delegate = self
        subjectPicker.backgroundColor = UIColor(white: 0.8, alpha: 0.6)
        subjectPicker.layer.cornerRadius = 20
        view.addSubview(subjectPicker)
        
        searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .white
        view.addSubview(searchBar)
        
        setupConstraints()
        if let index = System.lastPickedSubject {
            subjectPicker.selectRow(index, inComponent: 0, animated: true)
        }

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        subjectPicker.frame = CGRect(origin: CGPoint(x: 0, y: size.height/3), size: CGSize(width: size.width, height: 220.0))
    }
    
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
    }

}

extension SubjectPageSelectViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // How many lists
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AllSubject.array.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(AllSubject.array[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        System.lastPickedSubject = row
        delegate.updateSubject(with: AllSubject.array[row])
    }
}
