//
//  OneSubjectViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 04.10.2022.
//

import UIKit

class OneSubjectViewController: UIViewController {
        
    init() {
        super.init(nibName: nil, bundle: nil)
        
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        title = "Big title Big titleBig titleBig titleBig titleBig titleBig titleBig titleBig titleBig titleBig titleBig titleBig titleBig titleBig titleBig title"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
