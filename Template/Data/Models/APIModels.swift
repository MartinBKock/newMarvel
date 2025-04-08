//
//  APIModels.swift
//  Dev
//
//  Created by Martin Kock on 30/03/2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marvelAPIObject = try? JSONDecoder().decode(MarvelAPIObject.self, from: jsonData)

// MARK: - MarvelAPIObject
struct MarvelAPIObject: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    var offset, limit, total, count: Int?
    var results: [ResultData?]?
}

// MARK: - Result
struct ResultData: Codable, Identifiable, Hashable {
    let id: Int?
    let name, description: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?
}

// MARK: - Comics
struct Comics: Codable, Hashable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable, Hashable, Identifiable {
    let id = UUID().uuidString
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable, Hashable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable, Hashable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable, Hashable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable, Hashable {
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable, Hashable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
