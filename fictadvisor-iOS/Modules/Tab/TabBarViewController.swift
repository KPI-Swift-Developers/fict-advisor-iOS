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
        let vc2 = SubjectsViewController.module
        
        vc1.view.backgroundColor = .red
        vc1.title = "Teachers"
        
        setViewControllers(
            [UINavigationController(rootViewController: vc2), vc1],
            animated: false
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


