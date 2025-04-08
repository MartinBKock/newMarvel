//
//  CreatorModel.swift
//  Dev
//
//  Created by Martin Kock on 02/04/2024.
//

import Foundation

// MARK: - CreatorAPIObject
struct CreatorAPIObject: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: CreatorData
}

// MARK: - DataClass
struct CreatorData: Codable {
    let offset, limit, total, count: Int
    var results: [CreatorResult]
}

// MARK: - Result
struct CreatorResult: Codable, Identifiable {
    let id: Int
    let firstName, middleName, lastName, suffix: String
    let fullName: String
//    let modified: Date
    let thumbnail: Thumbnail
//    let resourceURI: String
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
}

