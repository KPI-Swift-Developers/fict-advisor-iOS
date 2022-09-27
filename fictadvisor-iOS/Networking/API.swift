//
//  API.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import Foundation

class RestService {
    var baseURL = "https://api.fictadvisor.com/"
    var standardPages = 10
}

struct APIArrayData<Data: Codable>: Codable {
    let count: Int
    let items: [Data]
}
