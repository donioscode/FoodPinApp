//
//  NavigationController.swift
//  FoodPin
//
//  Created by doniyor normuxammedov on 25/11/24.
//

import UIKit

class NavigationController: UINavigationController {

        // Do any additional setup after loading the view.
    override var preferredStatusBarStyle: UIStatusBarStyle{
            return topViewController?.preferredStatusBarStyle ?? .default
        }
    

}
