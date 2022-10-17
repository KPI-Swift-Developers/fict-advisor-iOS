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
        
        let vc1 = TeachersViewController.module
        let vc2 = SubjectsViewController.module
        let vc3 = SettingsViewController()
        
        vc1.view.backgroundColor = .red
        vc1.title = "Teachers"
        vc2.title = "Subjects"
        vc3.title = "Settings"
        
        setViewControllers(
            [
                UINavigationController(rootViewController: vc1),
                UINavigationController(rootViewController: vc2),
                UINavigationController(rootViewController: vc3)
            ],
            animated: false
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


