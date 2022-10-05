//
//  TeacherContactsViewController+Module.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import Foundation

extension TeacherContactsViewController {
    static var module: TeacherContactsViewController {
        let service = TeacherContactService()
        let vc = TeacherContactsViewController(service: service)
        return vc
    }
}
