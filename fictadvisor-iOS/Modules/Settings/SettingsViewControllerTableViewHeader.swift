//
//  SettingsViewControllerTableViewHeader.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 17.10.2022.
//

import UIKit

class SettingsViewControllerTableViewHeader: UIView {
    
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setupImageView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: ("AppIcon"))
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = frame.size.width / 2
        imageView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
