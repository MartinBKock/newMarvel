//
//  EventModel.swift
//  Dev
//
//  Created by Martin Kock on 02/04/2024.
//

import Foundation

// MARK: - EventAPIObject
struct EventAPIObject: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: EventData
}

// MARK: - DataClass
struct EventData: Codable {
    let offset, limit, total, count: Int
    var results: [EventResult]
}

// MARK: - Result
struct EventResult: Codable, Identifiable {
    let id: Int
    let title, description: String?
//    let resourceURI: String
//    let urls: [URLElement]
//    let modified: Date
//    let start, end: String
//    let thumbnail: Thumbnail
//    let creators: Creators
//    let characters: Characters
//    let stories: Stories
//    let comics, series: Characters
//    let next, previous: Next
}

// MARK: - Next
struct Next: Codable {
    let resourceURI: String
    let name: String
}
