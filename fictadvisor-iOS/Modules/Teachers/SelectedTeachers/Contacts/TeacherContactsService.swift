//
//  TeacherContactsService.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import Foundation
import Alamofire

struct TeacherContact: Codable {
    let name, value: String
}

typealias TeacherContacts = [TeacherContact]

protocol TeacherContactServiceTarget {
    func getContacts(for teacher: String, completion: @escaping((TeacherContacts) -> Void), errorCompletion: ((Error)-> Void)?)
}

class TeacherContactService: RestService {
    func linkString(teacher: String) -> String {
        return baseURL + "teachers/\(teacher)/contacts"
    }
}

extension TeacherContactService: TeacherContactServiceTarget {
    func getContacts(for teacher: String, completion: @escaping ((TeacherContacts) -> Void), errorCompletion: ((Error) -> Void)?) {
        let decoder = JSONDecoder()
        AF.request(linkString(teacher: teacher), method: .get).responseDecodable(of: TeacherContactsAPIArrayData<TeacherContact>.self, decoder: decoder) { (response) in
            if response.response?.statusCode == 200, let value = response.value {
                completion(value.items)
            }
        }
    }
}
