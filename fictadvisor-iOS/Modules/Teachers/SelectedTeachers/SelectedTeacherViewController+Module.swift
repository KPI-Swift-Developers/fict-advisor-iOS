//
//  SelectedTeacherViewController+Module.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 30.09.2022.
//

import Foundation

extension SelectedTeacherViewController {
    static var module: SelectedTeacherViewController {
        let service = SelectedTeacherService()
        let vc = SelectedTeacherViewController(service: service)
        return vc
    }
}
