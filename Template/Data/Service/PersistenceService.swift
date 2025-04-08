//
//  PersistenceService.swift
//  Dev
//
//  Created by Martin Kock on 02/04/2024.
//

import Foundation

class PersistenceService {
    
    // MARK: - Singleton
    
    // MARK: - Private init
     init() {}
    
    // MARK: - Public properties
    
    
    
    
    // MARK: - Private functions
    // get documents directory
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // MARK: - public functions
    
    func saveToJSONFile<T: Encodable>(object: T, fileName: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            try data.write(to: url)
        } catch {
            print("Failed to save data to file: \(error.localizedDescription)")
        }
    }

    
    func loadFromJSONFile<T: Decodable>(fileName: String, objectType: T.Type) -> T? {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let object = try decoder.decode(objectType, from: data)
            return object
        } catch {
            print("Failed to load data from file: \(error.localizedDescription)")
            return nil
        }
    }

    
    
    
    
}
