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
        errorCompletion: ((Error) -> Void)?)
}

protocol PagingSubjectsService {
    func pagedSubjects(
        sort: SortingType,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)?)
   
    var page: Int { get }
    
    func clearPage()
}

class SubjectsService: RestService {
    private func linkString(page: Int, sort: SortingType) -> String {
        return baseURL + "subjects?page=\(page)&page_size=\(standardPages)&sort=\(sort.urlName)"
    }
    
    private(set) var page: Int = 0
}

extension SubjectsService: SubjectsServiceTarget {
    func getSubjects(
        page: Int,
        sort: SortingType = .byName,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)? = nil
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(
            linkString(page: page, sort: sort),
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

extension SubjectsService: PagingSubjectsService {
    func pagedSubjects(
        sort: SortingType = .byName,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)? = nil
    ) {
        page += 1
        getSubjects(
            page: page,
            sort: sort,
            completion: completion,
            errorCompletion: errorCompletion)
    }
    
    func clearPage() {
        page = 0
    }
}
