//
//  SubjectSerivce+Model.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 05.10.2022.
//

import Foundation

struct Subject: Codable {
    let id: String
    let link: String
    let name: String
    let description: String?
    let teacherCount: String
    let rating: Float
}
typealias Subjects = [Subject]

struct SubjectTeacher: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let middleName: String
    let link: String
    
    var fullTeacherName: String {
        return lastName + " " + firstName + " " + middleName
    }
}
typealias SubjectTeachers = [SubjectTeacher]

struct SubjectCourse: Codable {
    let id: String
    let link: String
    let teacher: SubjectTeacher
    let reviewCount: Int
    let rating: Float
    let recommended: Bool
}
typealias SubjectCourses = [SubjectCourse]

struct CourseReview: Codable {
    let id: String
    let content: String
    let rating: Float
    let date: String
}
typealias CourseReviews = [CourseReview]

