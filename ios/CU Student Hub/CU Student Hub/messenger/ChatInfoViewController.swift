//
//  ChatInfoViewController.swift
//  CU Student Hub
//
//  Created by Anthony Yang on 5/4/19.
//  Copyright © 2019 Anthony Yang. All rights reserved.
//

import UIKit

class ChatInfoViewController: UIViewController {

    var sizeOfChat: Int // With current backend probably not possible
    
    init(chatName: String) {
        self.sizeOfChat = 1
        super.init(nibName: nil, bundle: nil)
        self.title = chatName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
