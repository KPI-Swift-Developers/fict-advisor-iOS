//
//  StateButton.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 06.10.2022.
//

import UIKit
import SnapKit

class StateButton: UIButton {
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        spinner.startAnimating()
        spinner.isHidden = true
        
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let title: String
    private let spinner = UIActivityIndicatorView()
}

extension StateButton {
    func startLoading() {
        self.setTitle("", for: .normal)
        spinner.isHidden = false
    }
    
    func stopLoading() {
        self.setTitle(title, for: .normal)
        spinner.isHidden = true
    }
}
