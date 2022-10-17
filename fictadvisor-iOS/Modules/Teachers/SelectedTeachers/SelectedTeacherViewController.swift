//
//  SelectedTeacherViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 30.09.2022.
//

import UIKit

class SelectedTeacherViewController: SearchCoreViewController {
    
    private let service: SelectedTeacherService
    private let segmenedControl = UISegmentedControl(items: ["Предмети", "Відгуки", "Контакти"])
    private var containerViewController = UIViewController()
    var teacherLink = String()
    
    private var teacher: OneTeacher! {
        didSet {
            let teacherTitle = teacher.firstName + " " + teacher.middleName + " " + teacher.lastName
            self.title = teacherTitle
        }
    }
    
    init (service: SelectedTeacherService) {
        self.service = service
        super.init(buttonImage1: UIImage(systemName: "arrow.up.arrow.down"), buttonImage2: nil, largeNavigation: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidCreated() {
        super.viewDidCreated()
        view.backgroundColor = .systemBackground
        setupView()
        service.getTeacher(teacher: teacherLink, completion: { [weak self] (_teacher) in
            self?.teacher = _teacher
        }, errorCompletion: nil)
        segmentedControllDidTap()
    }
}

private extension SelectedTeacherViewController {
    
    private func setupConstraints() {
        containerViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupView() {
        navigationItem.titleView = segmenedControl
        segmenedControl.addTarget(self, action: #selector(segmentedControllDidTap), for: .valueChanged)
        segmenedControl.selectedSegmentIndex = 0
    }
    @objc private func segmentedControllDidTap() {
        if segmenedControl.selectedSegmentIndex == 0 {
            view.subviews.forEach({ $0.removeFromSuperview() })
            let vc = TeacherSubjectsViewController.module
            vc.teacherLink = teacherLink
            containerViewController = vc
        } else if segmenedControl.selectedSegmentIndex == 1 {
            view.subviews.forEach({ $0.removeFromSuperview() })
            let vc = ReviewsViewController.module
            vc.teacherLink = teacherLink
            containerViewController = vc
        } else {
            view.subviews.forEach({ $0.removeFromSuperview() })
            let vc = TeacherContactsViewController.module
            vc.teacherlink = teacherLink
            containerViewController = vc
        }
        view.addSubview(containerViewController.view)
        self.addChild(containerViewController)
        containerViewController.didMove(toParent: self)
        setupConstraints()
    }
}
