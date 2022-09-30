//
//  SelectedTeacherViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 30.09.2022.
//

import UIKit

class SelectedTeacherViewController: UIViewController {
    
    private let service: SelectedTeacherService
    private var teacher: OneTeacher!
    
    init (service: SelectedTeacherService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        service.getTeacher(teacher: "sirota-olena-petrivna", completion: { [weak self] (_teacher) in
            self?.teacher = _teacher
        }, errorCompletion: nil)
        
    }
}
