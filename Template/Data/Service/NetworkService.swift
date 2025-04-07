//  Created by Martin Kock on 08/12/2023.
//

import UIKit
import MBKBasic

class NetworkService {
    // MARK: - Private init
    init() {
        networkManager = NetworkManager()
    }
    
    private let networkManager: NetworkManager?
    
    private enum urls {
        static let base = "https://api.example.com"
    }
    
}

// MARK: - How to use
//    func getPeopleAsAsync() async -> Result<String, Error> {
//        do {
//            let response = try await networkManager?.request(method: .get, url: urls.base, headers: [:], params: nil, of: String.self)
//            return .success(response ?? "")
//        } catch let error {
//            print(error.localizedDescription)
//            return .failure(error)
//        }
//    }
//
//    func useGetPeopleAsAsync() async {
//        let result = await getPeopleAsAsync()
//        switch result {
//        case .success(let response):
//            print(response)
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    }
//
//    func getPeopleCompletion(completion: @escaping (Result<String?, Error>) -> Void) {
//        Task {
//            do {
//                let response = try await networkManager?.request(method: .get, url: urls.base, headers: [:], params: nil, of: String.self)
//                await MainActor.run {
//                    completion(.success(response))
//                }
//            } catch let error {
//                await MainActor.run {
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
//
//    func useGetPeopleCompletion() {
//        getPeopleCompletion { result in
//            switch result {
//            case .success(let response):
//                print(response ?? "")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
