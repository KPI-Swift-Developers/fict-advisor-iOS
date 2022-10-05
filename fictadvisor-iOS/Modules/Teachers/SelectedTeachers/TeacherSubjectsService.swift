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
        return baseURL + "https://api.fictadvisor.com/teachers/\(teacher)/courses"
    }
}

extension TeacherSubjectsService: TeacherSubjectsServiceTarget {
    func getSubjects(for teacher: String, completion: @escaping (TeacherSubjects) -> Void, errorCompletion: ((Error) -> Void)?) {
        let decoder = JSONDecoder()
        AF.request(linkString(for: "bazaka-yurij-anatolijovich"), method: .get).responseDecodable(of: APIArrayData<TeacherSubject>.self, decoder: decoder) { (response) in
            if response.response?.statusCode == 200, let value = response.value {
                completion(value.items)
            }
        }
    }
}
