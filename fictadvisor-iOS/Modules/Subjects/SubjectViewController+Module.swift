//
//  SubjectViewController+Module.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import Foundation

extension SubjectsViewController {
    static var module: SubjectsViewController {
        let service = SubjectsService()
        let vc = SubjectsViewController(service: service)
        return vc
    }
}
