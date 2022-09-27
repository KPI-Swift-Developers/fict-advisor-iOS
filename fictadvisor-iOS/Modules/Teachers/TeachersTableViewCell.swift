//
//  TeachersTableViewCell.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 27.09.2022.
//

import UIKit
import SnapKit

class TeachersTableViewCell: UITableViewCell {
    
    static let identifier = "TeachersTableViewCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 25)
        return label
    }()
    //Might change it in some time
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, ratingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
