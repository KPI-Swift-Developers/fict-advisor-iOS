//
//  TeachersViewController+Module.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 27.09.2022.
//

import Foundation

extension TeachersViewController {
    static var module: TeachersViewController {
        let service = TeachersService()
        let vc = TeachersViewController(service: service)
        return vc
    }
}
