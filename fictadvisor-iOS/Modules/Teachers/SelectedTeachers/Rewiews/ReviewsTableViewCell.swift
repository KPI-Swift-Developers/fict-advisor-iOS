//
//  ReviewsTableViewCell.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 03.10.2022.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    static let identifier = "ReviewsTableViewCell"
    
    let ratingView = RatingView()
    let subjectLabel = UILabel()
    let reviewTextLabel = UILabel()
    
    private lazy var supplementaryStackView = UIStackView(arrangedSubviews: [ratingView, subjectLabel])
    private lazy var rootStackView = UIStackView(arrangedSubviews: [supplementaryStackView, reviewTextLabel])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(rootStackView)
        setupLabels()
        setupStackViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        subjectLabel.textColor = .secondaryLabel
        reviewTextLabel.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        subjectLabel.text = nil
        ratingView.setRating(rating: 0)
        reviewTextLabel.text = nil
    }
    
    private func setupStackViews() {
        supplementaryStackView.axis = .horizontal
        supplementaryStackView.distribution = .fillEqually
        
        rootStackView.axis = .vertical
        rootStackView.distribution = .fill
        
        rootStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
