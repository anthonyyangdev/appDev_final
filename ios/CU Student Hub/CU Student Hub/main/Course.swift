//
//  Course.swift
//  CU Student Hub
//
//  Created by Lauren on 4/23/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import Foundation
import UIKit

class Course{
    
    var profileImage: UIImage?
    var name: String?
    var type: String?
    
    init(imageName: String, Type: String){
        profileImage = UIImage(named: imageName)
        name = imageName
        type = Type
    }
    
}
