//
//  TeacherSubjectsViewController+Modulr.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import Foundation

extension TeacherSubjectsViewController {
    static var module: TeacherSubjectsViewController {
        let service = TeacherSubjectsService()
        let vc = TeacherSubjectsViewController(service: service)
        return vc
    }
}
