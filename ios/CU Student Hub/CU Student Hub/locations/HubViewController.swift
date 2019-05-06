//
//  HubViewController.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class HubViewController: UIViewController {
    
    var locationCollectionView: UICollectionView!
    var locationArray: [Location]!
    var searchedLocationArray: [Location]!
    var searchBar: UISearchBar!
    var searchButton: UIButton!
    
    var choosingFavorites: Bool!
    var chooseFavoriteButton: UIBarButtonItem!
    
    let photoCellReuseIdentifier = "photoCellReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Locations"

        view.backgroundColor = UIColor(red: 0xD6/0xFF, green: 0x36/0xFF, blue: 0x40/0xFF, alpha: 1)
        locationArray = LocationInfo.array
        if let favorites = System.favLocation {
            for loc in locationArray {
                let name = loc.name.replacingOccurrences(of: " ", with: "_")
                if let _ = favorites[name] {
                    loc.isFavorite = true
                } else {
                    continue
                }
            }
        }
        searchedLocationArray = locationArray
        choosingFavorites = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Pick somewhere to chat!"
        searchBar.delegate = self
        searchBar.barTintColor = UIColor(red: 0xD6/0xFF, green: 0x36/0xFF, blue: 0x40/0xFF, alpha: 1)
        view.addSubview(searchBar)
        
        locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        locationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        locationCollectionView.backgroundColor = UIColor(red: 0xD6/0xFF, green: 0x36/0xFF, blue: 0x40/0xFF, alpha: 1)
        locationCollectionView.dataSource = self
        locationCollectionView.delegate = self
        locationCollectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: photoCellReuseIdentifier)
        view.addSubview(locationCollectionView)
        
        chooseFavoriteButton = UIBarButtonItem(title: "Choose Favorites", style: .plain, target: self, action: #selector(chooseFavorite))
        navigationItem.rightBarButtonItem = chooseFavoriteButton
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
            ])
        
        NSLayoutConstraint.activate([
            locationCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            locationCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationCollectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            locationCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    // Places the locations that are favorited in the front of the array of displayed locations.
    // Ought to be called right before the table view gets reloaded.
    private func prioritizeFavorites() {
        var favorites: [Location] = []
        var nonFavorites: [Location] = []
        
        for l in searchedLocationArray {
            if l.isFavorite {
                favorites.append(l)
            } else {
                nonFavorites.append(l)
            }
        }
        searchedLocationArray = (favorites + nonFavorites)
    }
    
    @objc private func chooseFavorite() {
        choosingFavorites.toggle()
        if choosingFavorites {
            chooseFavoriteButton.style = .done
            chooseFavoriteButton.title = "Done"
        } else {
            chooseFavoriteButton.style = .plain
            chooseFavoriteButton.title = "Choose Favorites"
        }
    }
}

extension HubViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedLocationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier, for: indexPath) as! LocationCollectionViewCell
        let location = searchedLocationArray[indexPath.item]
        cell.configure(for: location)
        return cell
    }
}

extension HubViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let location = searchedLocationArray[index]
        var locationName = location.name
        if !choosingFavorites {
            // User is picking a place to enter a chat
            if let course = System.courseSelected {
                System.locationSelected = location
                let subject = course.subject
                let number = course.catalogNbr
                let chatRoomViewController = MessengerViewController(chatName: "\(subject)\(number) @ \(locationName)")
                navigationController?.pushViewController(chatRoomViewController, animated: true)
            } else {
                fatalError()
            }
        } else {
            location.isFavorite.toggle()
            self.prioritizeFavorites()
            self.locationCollectionView.reloadData()
            locationName = locationName.replacingOccurrences(of: " ", with: "_")
            let newStatus = location.isFavorite
            guard let netid = System.currentUser else {fatalError()}
            if var favorites = System.favLocation {
                if newStatus {
                    // if location is now favorited
                    if let _ = favorites[locationName] {
                        fatalError()
                    } else {
                        favorites[locationName] = location
                        System.favLocation = favorites
                        NetworkManager.addFavoriteLocation(at: locationName, for: netid) {
                            print("added from system")
                        }
                    }
                } else {
                    // Remove it from list of favorites
                    if let _ = favorites[locationName] {
                        NetworkManager.deleteFavoriteLocation(at: locationName, for: netid) {
                            print("removed from system")
                        }
                        favorites.removeValue(forKey: locationName)
                        System.favLocation = favorites
                        
                    } else {
                        fatalError()
                    }
                }
            } else {
                // If System.favLocation was not initialized. This will be the first favorite location!
                if newStatus {
                    NetworkManager.addFavoriteLocation(at: locationName, for: netid) {
                        print("added from system")
                    }
                    System.favLocation = [locationName: location]
                } else {
                    fatalError()
                }
            }
        }
    }
}

extension HubViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width - 4 * padding) / 2
        return  CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
}

extension HubViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.text = searchText
        
        searchedLocationArray = searchText.isEmpty ? locationArray : locationArray.filter {(r: Location) -> Bool in
            return r.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        self.prioritizeFavorites()
        locationCollectionView.reloadData()
    }
}
