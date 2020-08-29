//
//  DetailViewController.swift
//  Khari
//
//  Created by Evan Gruère on 20/07/2020.
//  Copyright © 2020 Evan Gruère. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    override func loadView() {
        self.view = detailView
    }
    
}
