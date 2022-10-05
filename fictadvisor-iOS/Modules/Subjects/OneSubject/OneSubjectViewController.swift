//
//  OneSubjectViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 04.10.2022.
//

import UIKit

class OneSubjectViewController: CoreViewController {
        
    init(subject: Subject) {
        self.subject = subject
        super.init(buttonImage1: nil, buttonImage2: nil, largeNavigation: false)
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidCreated() {
        super.viewDidCreated()
        let service = SubjectsService()
        tableView.startLoading()
        service.getCourses(
            subjectLink: subject.link,
            page: 0,
            sort: .byName,
            completion: {
                [weak self] list in
                guard let self = self else { return }
                self.tableView.stopLoading()
                list.isEmpty ? self.tableView.setEmptyState() : self.tableView.popStateView()
                self.courses = list
                self.tableView.reloadData()
            },
            errorCompletion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let tableView = StateTableView()
    private let subject: Subject
    private var courses = SubjectCourses()
}

extension OneSubjectViewController {
    static func module(subject: Subject) -> OneSubjectViewController {
        return OneSubjectViewController(subject: subject)
    }
}

extension OneSubjectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        navigationController?.pushViewController(
            CourseViewController(subjectName: subject.name, course: courses[indexPath.row]),
            animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return courses.count
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return subject.name
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath)
        let course = courses[indexPath.row]
        cell.textLabel?.text = course.teacher.fullTeacherName
        
        let subtitleText = "Rates count: \(course.reviewCount), avarage rate: \(course.rating)"
        cell.detailTextLabel?.text = subtitleText
        return cell
    }
}
