//
//  SubjectsService.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import Foundation
import Alamofire

protocol SubjectsServiceTarget {
    func getSubjects(
        page: Int,
        sort: SortingType,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)?)
    
    func getCourses(
        subjectLink: String,
        page: Int,
        sort: SortingType,
        completion: @escaping (SubjectCourses) -> Void,
        errorCompletion: ((Error) -> Void)?)
    
    func getCourseReviews(
        courseLink: String,
        page: Int,
        sort: SortingType,
        completion: @escaping (CourseReviews) -> Void,
        errorCompletion: ((Error) -> Void)?)
    
    func searchSubjects(
        _ searchString: String,
        page: Int,
        pageSize: Int,
        sort: SortingType,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ErrorCompletion?)
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
    private func linkString(_ sublink: String, page: Int, sort: SortingType) -> String {
        return baseURL + "\(sublink)?page=\(page)&page_size=\(standardPages)&sort=\(sort.urlName)"
    }
    
    private(set) var page: Int = 0
}

extension SubjectsService: SubjectsServiceTarget {
    func searchSubjects(
        _ searchString: String,
        page: Int,
        pageSize: Int,
        sort: SortingType,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)?
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let urlString = (baseURL + "subjects?page=\(page)&page_size=\(pageSize)&search=\(searchString)&sort=\(sort.urlName)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        AF.request(
            urlString,
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
    
    func getCourses(
        subjectLink: String,
        page: Int,
        sort: SortingType,
        completion: @escaping (SubjectCourses) -> Void,
        errorCompletion: ((Error) -> Void)?
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(
            baseURL + "subjects/\(subjectLink)/courses?page=\(page)&page_size=\(standardPages)",
            method: .get
        ).responseDecodable(
            of: APIArrayData<SubjectCourse>.self,
            decoder: decoder
        ) {
            response in
            if response.response?.statusCode == 200, let value = response.value {
                completion(value.items)
            }
        }
    }
    
    func getSubjects(
        page: Int,
        sort: SortingType = .byName,
        completion: @escaping (Subjects) -> Void,
        errorCompletion: ((Error) -> Void)? = nil
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(
            linkString("subjects", page: page, sort: sort),
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
    
    func getCourseReviews(
        courseLink: String,
        page: Int,
        sort: SortingType,
        completion: @escaping (CourseReviews) -> Void,
        errorCompletion: ((Error) -> Void)? = nil
    ) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(
            baseURL + "courses/\(courseLink)/reviews?page=\(page)&page_size=\(standardPages)&search=&sort=\(sort.urlName)",
            method: .get
        ).responseDecodable(
            of: APIArrayData<CourseReview>.self,
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
