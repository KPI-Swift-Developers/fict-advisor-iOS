//
//  CoreViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 30.09.2022.
//

import UIKit

class CoreViewController: UIViewController {
    
    private var isAppeared = false
    private let largeNavigation: Bool
    
    init(
        buttonImage1: UIImage? = UIImage(systemName: "arrow.up.arrow.down"),
        buttonImage2: UIImage? = UIImage(systemName: "plus"),
        largeNavigation: Bool = true
    ) {
        self.largeNavigation = largeNavigation
        super.init(nibName: nil, bundle: nil)
        navigationItem.rightBarButtonItems = []
        view.backgroundColor = .systemBackground
        configureButtons(buttonImage1: buttonImage1, buttonImage2: buttonImage2)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isAppeared { return }
        isAppeared = true
        
        if largeNavigation {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        viewDidCreated()
    }
    
    @objc func didTapNavigationButton1() {}
    @objc func didTapNavigationButton2() {}
    func viewDidCreated() {}
}

private extension CoreViewController {
    func configureButtons(buttonImage1: UIImage?, buttonImage2: UIImage?) {
        if let image1 = buttonImage1 {
            let button1 = UIBarButtonItem(
                image: image1,
                style: .plain,
                target: self,
                action: #selector(didTapNavigationButton1)
            )
            navigationItem.rightBarButtonItems?.append(button1)
        }
        
        if let image2 = buttonImage2 {
            let button2 = UIBarButtonItem(
                image: image2,
                style: .plain,
                target: self,
                action: #selector(didTapNavigationButton2)
            )
            navigationItem.rightBarButtonItems?.append(button2)
        }
    }
}
