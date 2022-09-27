//
//  SubjectsService.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import Foundation
import Alamofire

struct Subject: Codable {
    let id: String
    let link: String
    let name: String
    let description: String?
    let teacherCount: String
    let rating: Int
}
typealias Subjects = [Subject]

protocol SubjectsServiceTarget {
    func getSubjects(
        page: Int,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)?
    )
}

class SubjectsService: RestService {
    private func linkString(page: Int) -> String {
        return baseURL + "subjects?page=\(page)&page_size=\(standardPages)"
    }
}

extension SubjectsService: SubjectsServiceTarget {
    func getSubjects(
        page: Int,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)?
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(
            linkString(page: 0),
            method: .get
        ).responseDecodable(
            of: APIArrayData<Subject>.self,
            decoder: decoder
        ) {
            response in
            if response.response?.statusCode == 200, let value = response.value {
                completion(value.items)
            }
        }
    }
}
