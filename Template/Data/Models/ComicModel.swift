//
//  Comic.swift
//  Dev
//
//  Created by Martin Kock on 02/04/2024.
//

import Foundation
struct ComicAPIObject: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    var data: ComicDataClass
}

// MARK: - DataClass
struct ComicDataClass: Codable {
    let offset, limit, total, count: Int?
    var results: [ComicResult]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
    
    
}


// MARK: - Result
struct ComicResult: Codable, Identifiable {
    let id: Int
//    let digitalID: Int
    let title: String?
//    let issueNumber: Int
//    let variantDescription: String
    let description: String?
//    let modified: ModifiedUnion
//    let isbn: Isbn
//    let upc: String
//    let diamondCode: DiamondCode
//    let ean, issn: String
//    let format: Format
//    let pageCount: Int
    let textObjects: [TextObject?]?
//    let resourceURI: String
//    let urls: [URLElement]
//    let series: Series
//    let variants: [Series]
////    let collections: [Any?]
//    let collectedIssues: [Series]
//    let dates: [DateElement]
//    let prices: [Price]
    let thumbnail: Thumbnail?
//    let images: [Thumbnail]
//    let creators: Creators
    let characters: Characters?
//    let stories: Stories
//    let events: Characters
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Series]?
    let returned: Int
}

// MARK: - Series
struct Series: Codable, Hashable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: Role
}

enum Role: String, Codable {
    case colorist
    case editor
    case inker
    case letterer
    case penciler
    case penciller
    case pencillerCover
    case writer
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: DateType
    let date: ModifiedUnion
}

enum ModifiedUnion: Codable {
    case dateTime(Date)
    case enumeration(ModifiedEnum)
}

enum ModifiedEnum: String, Codable {
    case the00011130T0000000500
}

enum DateType: String, Codable {
    case digitalPurchaseDate
    case focDate
    case onsaleDate
    case unlimitedDate
}

enum Description: String, Codable {
    case empty
    case nA
}

enum DiamondCode: String, Codable {
    case empty
    case jul190068
}

enum Format: String, Codable {
    case comic
    case digest
    case empty
    case tradePaperback
}

enum Isbn: String , Codable{
    case empty
    case the0785111298
    case the0785114513
    case the0785115609
}

// MARK: - Price
struct Price: Codable {
    let type: PriceType
    let price: Double
}

enum PriceType: String, Codable {
    case digitalPurchasePrice
    case printPrice
}

// MARK: - TextObject
struct TextObject: Codable {
//    let type: TextObjectType?
//    let language: Language?
    let text: String?
}

enum Language: String, Codable {
    case enUs
}

enum TextObjectType: String, Codable {
    case issueSolicitText
}
