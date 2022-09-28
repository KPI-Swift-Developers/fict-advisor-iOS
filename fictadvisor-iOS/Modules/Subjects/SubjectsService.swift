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
    let rating: Float
}
typealias Subjects = [Subject]

protocol SubjectsServiceTarget {
    func getSubjects(
        page: Int,
        sort: SortingType,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)?
    )
}

class SubjectsService: RestService {
    private func linkString(page: Int, sort: SortingType) -> String {
        return baseURL + "subjects?page=\(page)&page_size=\(standardPages)&sort=\(sort.urlName)"
    }
}

extension SubjectsService: SubjectsServiceTarget {
    func getSubjects(
        page: Int,
        sort: SortingType = .byName,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)?
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(
            linkString(page: 0, sort: sort),
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
