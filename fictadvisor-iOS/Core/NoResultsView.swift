//
//  NoResultsView.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import UIKit
import SnapKit

class NoResultsView: UIView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        setupLabel()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLabel() {
        label.text = "Немає результатів"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25.0)
    }
    private func setupConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
