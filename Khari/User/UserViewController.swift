//
//  UserViewController.swift
//  Khari
//
//  Created by Evan Gruère on 08/12/2019.
//  Copyright © 2019 Evan Gruère. All rights reserved.
//

import UIKit
import Combine

class UserViewController: UITabBarController {
    
    let detailViewController = DetailViewController()
    let messageViewController = MessageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailViewController.tabBarItem = UITabBarItem(title: "user",
                                                            image: UIImage(systemName: "person.fill"),
                                                            tag: 0)
        
        self.messageViewController.tabBarItem = UITabBarItem(title: "message",
                                                            image: UIImage(systemName: "message.fill"),
                                                            tag: 1)
        
        self.setViewControllers([self.detailViewController, self.messageViewController], animated: true)
    }
    
}
