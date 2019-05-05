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
        
        subjectPicker = UIPickerView(frame: CGRect(origin: CGPoint(x: 0, y: view.frame.height/3), size: CGSize(width: view.frame.width, height: 220.0)))
        subjectPicker.delegate = self
        view.addSubview(subjectPicker)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        subjectPicker.frame = CGRect(origin: CGPoint(x: 0, y: size.height/3), size: CGSize(width: size.width, height: 220.0))
    }
    
    
    private func setupConstraints() {

        subjectPicker.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
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
        delegate.updateSubject(with: AllSubject.array[row])
    }
    
}
