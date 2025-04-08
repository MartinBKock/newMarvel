//
//  PaginationModel.swift
//  Dev
//
//  Created by Martin Kock on 03/04/2024.
//

import Foundation

struct PaginationModel: Codable {
    var offset: Int
    var count: Int
    var timesPageRequested: Int
}
