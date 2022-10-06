//
//  RewiewsService.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 03.10.2022.
//

import Foundation
import Alamofire

struct Review: Codable {
    let id, content: String
    let course: Course
    let rating: Int
    let date: String
}

// MARK: - Course
struct Course: Codable {
    let id, name, link: String
}

typealias Reviews = [Review]


protocol ReviewsServiceTarget {
    func getReviews(teacher: String, completion: @escaping (Reviews) -> Void, errorCompletion: ((Error) -> Void)?)
}

class ReviewsService: RestService {
    func linkString(teacher: String) -> String {
        return baseURL + "teachers/\(teacher)/reviews"
    }
}

extension ReviewsService: ReviewsServiceTarget {
    func getReviews(teacher: String, completion: @escaping (Reviews) -> Void, errorCompletion: ((Error) -> Void)?) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(linkString(teacher: teacher), method: .get).responseDecodable(of: APIArrayData<Review>.self, decoder: decoder) { (response) in
            if response.response?.statusCode == 200, let value = response.value {
                completion(value.items)
            }
        }
    }
}
