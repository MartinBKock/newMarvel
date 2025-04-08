//
//  SeriesModel.swift
//  Dev
//
//  Created by Martin Kock on 02/04/2024.
//

import Foundation

// MARK: - SeriesAPIObject
struct SeriesAPIObject: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: SeriesData
}

// MARK: - DataClass
struct SeriesData: Codable {
    let offset, limit, total, count: Int
    var results: [SeriesResult]
}

// MARK: - Result
struct SeriesResult: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
//    let resourceURI: String
//    let urls: [URLElement]
//    let startYear, endYear: Int
//    let rating, type: String
//    let modified: Date
//    let thumbnail: Thumbnail
//    let creators: Creators
//    let characters: Characters
//    let stories: Stories
//    let comics, events: Characters
}
