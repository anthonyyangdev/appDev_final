//
//  LocationSelectionViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 5/4/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class LocationSelectionViewController: UIViewController {


    init() {
        locations = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var locations: [Location]
    var locationTable: UITableView!
    let locationID = "location_id_reusable"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTable = UITableView()
        locationTable.allowsSelection = false
        locationTable.delegate = self
        locationTable.dataSource = self
        locationTable.register(LocationTableViewCell.self, forCellReuseIdentifier: locationID)
        locationTable.tableFooterView = UIView() // so there's no empty lines at the bottom
        view.addSubview(locationTable)

    }
}

extension LocationSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.cellForRow(at: indexPath)!
    }
    
    
}
extension LocationSelectionViewController: UITableViewDelegate {
    
}
