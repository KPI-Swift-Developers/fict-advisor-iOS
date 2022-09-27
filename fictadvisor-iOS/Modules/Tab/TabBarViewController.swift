//
//  TabBarViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        vc1.view.backgroundColor = .red
        vc2.view.backgroundColor = .cyan
        
        vc1.title = "1"
        vc2.title = "2"
        
        setViewControllers([vc1, vc2], animated: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


