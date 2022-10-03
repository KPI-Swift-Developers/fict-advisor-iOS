//
//  RewiewsViewController+Module.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 03.10.2022.
//

import Foundation

extension ReviewsViewController {
    static var module: ReviewsViewController {
        let service = ReviewsService()
        let vc = ReviewsViewController(service: service)
        return vc
    }
}
