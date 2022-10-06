//
//  RatingView.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 05.10.2022.
//

import UIKit

class RatingView: UIView {
    
    private var imageViews: [UIImageView] = []
    
    init(maxStars: Int = 5, color: UIColor = .systemBlue) {
        super.init(frame: .zero)
        
        let st = UIStackView()
        addSubview(st)
        st.snp.makeConstraints() {

            $0.edges.equalToSuperview()
        }
        st.distribution = .fill
        st.alignment = .center
        
        for _ in 0 ..< maxStars {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "star")
            imageView.tintColor = color
            st.addArrangedSubview(imageView)
            imageViews.append(imageView)
        }
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        st.addArrangedSubview(spacerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRating(rating: Float, maxStars: Int = 5) {
        let floatingPart = rating.truncatingRemainder(dividingBy: 1)
        let intRating = Int(rating)
        
        for i in 0 ..< intRating {
            imageViews[i].image = UIImage(systemName: "star.fill")
        }
        
        if floatingPart > 0 {
            imageViews[intRating].image = UIImage(systemName: "star.leadinghalf.filled")
        }
    }
}
