//
//  SelectedTeacherService.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 30.09.2022.
//

import Foundation
import Alamofire

struct OneTeacher: Codable {
    let id, link, firstName, middleName: String
    let lastName: String
    let oneTeacherDescription: JSONNull?
    let image: String
    let tags: [String]
    let rating: Int
    let state, createdAt, updatedAt: String
}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

protocol OneTeacherServiceTarget {
    func getTeacher(teacher: String, completion: @escaping (OneTeacher) -> Void, errorCompletion: ((Error) -> Void)?)
}

class SelectedTeacherService: RestService {
    private func linkString(teacher: String) -> String {
        return baseURL + "teachers/\(teacher)"
    }
}

extension SelectedTeacherService: OneTeacherServiceTarget {
    func getTeacher(teacher: String, completion: @escaping (OneTeacher) -> Void, errorCompletion: ((Error) -> Void)?) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(linkString(teacher: teacher), method: .get).responseDecodable(of: OneTeacher.self, decoder: decoder) { (response) in
            if response.response?.statusCode == 200, let value = response.value {
                
                completion(value)
            }
        }
    }
}
