//
//  TestModels.swift
//  Dev
//
//  Created by Martin Kock on 31/07/2024.
//

import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var firstname: String
    var surname: String
    
    init(id: UUID, firstname: String, surname: String) {
        self.id = id
        self.firstname = firstname
        self.surname = surname
    }
}

struct UserModel: Sendable, Identifiable {
    let id: UUID
    let firstname: String
    let surname: String
}

@Model
final class TestModel {
    @Attribute(.unique) var id: UUID
    var firstname: String
    var surname: String
    
    init(id: UUID, firstname: String, surname: String) {
        self.id = id
        self.firstname = firstname
        self.surname = surname
    }
}
