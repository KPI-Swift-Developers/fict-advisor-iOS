//
//  TeacherSubjectsService.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import Foundation
import Alamofire

struct TeacherSubject: Codable {
    let id, link, name, state: String
    let reviewCount, rating: Int
    let recommended: Bool
}

typealias TeacherSubjects = [TeacherSubject]

protocol TeacherSubjectsServiceTarget {
    func getSubjects(for teacher: String, completion:  @escaping(TeacherSubjects) -> Void, errorCompletion: ((Error) -> Void)?)
}

class TeacherSubjectsService: RestService {
    func linkString(for teacher: String) -> String {
        return baseURL + "teachers/\(teacher)/courses"
    }
}

extension TeacherSubjectsService: TeacherSubjectsServiceTarget {
    func getSubjects(for teacher: String, completion: @escaping (TeacherSubjects) -> Void, errorCompletion: ((Error) -> Void)?) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(linkString(for: teacher), method: .get).responseDecodable(of: APIArrayData<TeacherSubject>.self, decoder: decoder) { (response) in
            if response.response?.statusCode == 200, let value = response.value {
                completion(value.items)
            }
        }
    }
}
