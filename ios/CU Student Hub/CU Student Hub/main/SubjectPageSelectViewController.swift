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
    weak var delegate: ChooseSubject!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        subjectPicker = UIPickerView()
        subjectPicker.translatesAutoresizingMaskIntoConstraints = false
        subjectPicker.delegate = self
        view.addSubview(subjectPicker)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            subjectPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            subjectPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            subjectPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subjectPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
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
        delegate.updateSubject(with: AllSubject.array[row])
    }
    
}
