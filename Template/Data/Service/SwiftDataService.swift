//
//  SwiftDataService.swift
//  Template
//
//  Created by Martin Kock on 23/07/2024.
//

import Foundation
import SwiftData


actor SwiftDataService {
    static let shared = SwiftDataService()
    
    init() {self.modelContext = ModelContext(container)}
    
    var modelContext: ModelContext
    
    private let container: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: User.self, TestModel.self, configurations: config)
        
        return container
    }()
}

extension SwiftDataService {
    func create<T: PersistentModel>(_ items: [T]) throws {
        items.forEach { item in
            modelContext.insert(item)
        }
        try modelContext.save()
    }
    
    func create<T: PersistentModel>(_ item: T) throws {
        modelContext.insert(item)
        try modelContext.save()
    }
    
    func read<T: PersistentModel>(sortBy sortDescriptors: SortDescriptor<T>...) throws -> [T] {
        let context = modelContext
        let fetchDescriptor = FetchDescriptor<T>(
            sortBy: sortDescriptors
        )
        let arrayToReturn = try context.fetch(fetchDescriptor)
        return arrayToReturn
    }
    
    
    func readId<T: PersistentModel>(sortBy sortDescriptors: SortDescriptor<T>...) throws -> [PersistentIdentifier] {
        let context = modelContext
        let fetchDescriptor = FetchDescriptor<T>(
            sortBy: sortDescriptors
        )
        let arrayToReturn = try context.fetch(fetchDescriptor)
        
        let newArrToReturn = arrayToReturn.map { $0.persistentModelID }
        
        return newArrToReturn
    }
    
    
    func update<T: PersistentModel>(_ item: T) throws {
        let context = modelContext
        context.insert(item)
        try context.save()
    }
    
    func delete<T: PersistentModel>(_ item: T) throws {
        let context = modelContext
        let idToDelete = item.persistentModelID
        try context.delete(model: T.self, where: #Predicate { item in
            item.persistentModelID == idToDelete
        })
        try context.save()
    }
}
