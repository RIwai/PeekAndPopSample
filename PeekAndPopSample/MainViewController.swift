//
//  MainViewController.swift
//  PeekAndPopSample
//
//  Created by Ryota Iwai on 2015/11/11.
//  Copyright © 2015年 Ryota Iwai. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.viewControllers = [UIStoryboard(name: "TopTableViewController", bundle: nil).instantiateViewControllerWithIdentifier("TopTableViewController")]
    }
}
