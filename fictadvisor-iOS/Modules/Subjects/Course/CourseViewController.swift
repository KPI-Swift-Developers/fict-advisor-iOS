//
//  CourseViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 05.10.2022.
//

import UIKit

class CourseViewController: SearchCoreViewController {
    
    init(subjectName: String, course: SubjectCourse) {
        self.course = course
        self.subjectName = subjectName
        super.init(
            buttonImage1: UIImage(systemName: ""),
            buttonImage2: nil,
            largeNavigation: true)
        title = "Страничка курса"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            CourseReviewTableViewCell.self,
            forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidCreated() {
        super.viewDidCreated()
       
        let service = SubjectsService()
        service.getCourseReviews(
            courseLink: course.link,
            page: 0,
            sort: .byName,
            completion: {
                [weak self] list in
                guard let self = self else { return }
                self.reviews = list
                list.isEmpty ? self.tableView.setEmptyState() : self.tableView.popEmptyState()
                self.tableView.reloadData()
            },
            errorCompletion: nil)
    }
    
    private let course: SubjectCourse
    private let tableView = StateTableView()
    private let subjectName: String
    
    private var reviews = CourseReviews()
}

extension CourseViewController {
    static func module(subjectName: String, course: SubjectCourse) -> CourseViewController {
        return CourseViewController(subjectName: subjectName, course: course)
    }
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return reviews.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath) as! CourseReviewTableViewCell
        cell.setModel(
            review: reviews[indexPath.row]
        )
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = CourseViewControllerHeader()
        header.setupModel(course: course, subjectName: subjectName)
        return header
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 150
    }
}
