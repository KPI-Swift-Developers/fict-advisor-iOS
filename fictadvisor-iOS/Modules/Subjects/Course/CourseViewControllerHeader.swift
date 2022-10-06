//
//  CourseViewControllerHeader.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 05.10.2022.
//

import UIKit

class CourseViewControllerHeader: UIView {
    
    init() {
        super.init(frame: .zero)

        addSubview(st)
        st.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        st.axis = .vertical
        st.spacing = 10
        st.distribution = .fillProportionally
        
        st.addArrangedSubview(teacherNameLabel)
        st.addArrangedSubview(courseNameLabel)
        
        teacherNameLabel.numberOfLines = 0
        courseNameLabel.numberOfLines = 0
        
        teacherNameLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        courseNameLabel.font = .systemFont(ofSize: 20, weight: .regular)
        courseNameLabel.textColor = .secondaryLabel
        
        st.addArrangedSubview(ratingView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let teacherNameLabel = UILabel()
    private let courseNameLabel = UILabel()
    private let ratingView: RatingView = RatingView()
    private let st = UIStackView()
    
    func setupModel(course: SubjectCourse, subjectName: String) {
        teacherNameLabel.text = course.teacher.fullTeacherName
        courseNameLabel.text = subjectName
        ratingView.setRating(rating: course.rating)
    }
}
