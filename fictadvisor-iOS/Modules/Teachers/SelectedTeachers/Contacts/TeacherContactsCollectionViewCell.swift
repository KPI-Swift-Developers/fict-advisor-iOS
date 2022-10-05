//
//  TeacherContactsCollectionViewCell.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import UIKit

class TeacherContactsCollectionViewCell: UICollectionViewCell {
    static let identifier = "TeacherContactsCollectionViewCell"
    let typeLabel = UILabel()
    let valueLabel = UILabel()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [typeLabel, valueLabel])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.1123788431, green: 0.1361303627, blue: 0.1675599813, alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        contentView.addSubview(stackView)
        setupLabels()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        valueLabel.numberOfLines = 0
        typeLabel.textColor = .secondaryLabel
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
