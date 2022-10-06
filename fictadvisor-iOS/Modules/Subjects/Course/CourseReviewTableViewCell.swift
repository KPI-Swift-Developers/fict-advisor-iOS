//
//  CourseReviewTableViewCell.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 05.10.2022.
//

import UIKit

class CourseReviewTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
        }
        
        addSubview(ratingView)
        ratingView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalTo(dateLabel.snp.left)
        }
        
        dateLabel.textAlignment = .right
        
        addSubview(reviewLabel)
        reviewLabel.numberOfLines = 0
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(ratingView.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let ratingView = RatingView()
    private let dateLabel = UILabel()
    private let reviewLabel = UILabel()
    
    func setModel(review: CourseReview) {
        ratingView.setRating(rating: review.rating)
        reviewLabel.text = review.content
        dateLabel.text = review.date
    }
}
