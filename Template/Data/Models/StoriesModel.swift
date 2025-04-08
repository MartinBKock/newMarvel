//
//  StoriesModel.swift
//  Dev
//
//  Created by Martin Kock on 02/04/2024.
//

import Foundation

// MARK: - StoriesAPIObject
struct StoryAPIObject: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: StoryData
}

// MARK: - DataClass
struct StoryData: Codable {
    let offset, limit, total, count: Int
    var results: [StoryResult]
}

// MARK: - Result
struct StoryResult: Codable, Identifiable {
    let id: Int
    let title, description: String?
//    let resourceURI: String
//    let type: String
//    let modified: Date
//    let thumbnail: Thumbnail?
//    let creators, characters, series, comics: Characters
//    let events: Characters
//    let originalIssue: OriginalIssue
}


// MARK: - OriginalIssue
struct OriginalIssue: Codable {
    let resourceURI: String
    let name: String
}
