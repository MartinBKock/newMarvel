//  Created by Martin Kock on 08/12/2023.
//

import UIKit
import MBKBasic

actor NetworkService {
    // MARK: - Private init
    init() {
        networkManager = NetworkManager()
    }
    
    // MARK: - Private properties
    private let networkManager: NetworkManager?
    
    private let apiKey = "b5f83b578bf097743f554eb4beaec4ca"
    private let baseUrl = "https://gateway.marvel.com/v1/public/"
    private let hash = "3e1e2985ccefaba6f313d43aa85dac09"
    
    private var charOffset = 0
    private var comicOffset = 0
    
    enum url: String {
        case characters = "characters"
        case comics = "comics"
        case creators = "creators"
        case events = "events"
        case series = "series"
        case stories = "stories"
    }
    
    // MARK: - Public properties
    
    
    // MARK: - private functions
    private func makeHeaders() -> [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        return headers
    }
    
    private func makeParams() -> [String: String] {
        var params = [String: String]()
        params["ts"] = "1"
        params["apikey"] = apiKey
        params["hash"] = hash
        params["offset"] = "\(charOffset)"
        params["limit"] = "20"
        return params
    }
    
    private func makeParamsForCharNameSearch(name: String) -> [String: String] {
        var params = [String: String]()
        params["ts"] = "1"
        params["apikey"] = apiKey
        params["hash"] = hash
        params["name"] = name
        return params
    }
    
    // MARK: - public functions
    // MARK: - Characters
//    func fetchSingleChar(url: String) async throws -> Result<ResultData, Error> {
//
//            let newUrl = url.setHTTPSinsteadOfHTTP()
//
//        do {
//            let res = try await HTTPClient.request(urlString: newUrl, method: .GET, parameters: makeParameters(), responseType: ResultData.self, header: makeHeaders())
//            return .success(res)
//        } catch let error {
//
//            return .failure(error)
//        }
//    }
    
    func fetchSingleChar(url: String) async throws -> ResultData {
        let newUrl = url.setHTTPSinsteadOfHTTP()
        do {
//            let res = try await HTTPClient.request(urlString: newUrl, method: .GET, parameters: makeParameters(), responseType: ResultData.self, header: makeHeaders())
            let res = try await networkManager?.request(
                method: .get,
                url: newUrl,
                headers: makeHeaders(),
                params: makeParams(),
                of: ResultData.self
            )
            guard let res = res else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch single character"])
            }
            
            return res
        } catch let error {
            throw error
        }
    }



    
    func fetchCharByName(name: String) async throws -> MarvelAPIObject {
        do {
//            let result: MarvelAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.characters.rawValue)", method: .GET, parameters: makeParametersForCharNameSearch(name: name), responseType: MarvelAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.characters.rawValue)",
                headers: makeHeaders(),
                params: makeParamsForCharNameSearch(name: name),
                of: MarvelAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch character by name"])
            }
            return result
        } catch let error {
            
            throw error
        }
    }

    func GetAllChars() async throws -> MarvelAPIObject {
        do {
//            let result: MarvelAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.characters.rawValue)", method: .GET, parameters: makeParameters(), responseType: MarvelAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.characters.rawValue)",
                headers: makeHeaders(),
                params: makeParams(),
                of: MarvelAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch all characters"])
            }
            return result
        } catch let error {
            
            throw error
        }
    }

    func fetchPaginatedChars (offset: Int) async throws -> MarvelAPIObject {
        do {
           charOffset = offset
//            let result: MarvelAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.characters.rawValue)", method: .GET, parameters: makeParameters(), responseType: MarvelAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.characters.rawValue)",
                headers: makeHeaders(),
                params: makeParams(),
                of: MarvelAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch paginated characters"])
            }
            return result
        } catch let error {
            
            throw error
        }
    }
    
    // MARK: - Comics
    func fetchPaginatedComics(offset: Int) async throws -> ComicAPIObject {
        do {
            charOffset = offset
//            let result: ComicAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.comics.rawValue)", method: .GET, parameters: makeParameters(), responseType: ComicAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.comics.rawValue)",
                headers: makeHeaders(),
                params: makeParams(),
                of: ComicAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch paginated comics"])
            }
            return result
        } catch let error {
            
            throw error
        }
    }
    
    func fetchSingleComic(url: String) async throws -> ComicAPIObject {
        do {
            let newUrl = url.setHTTPSinsteadOfHTTP()
//            let result: ComicAPIObject = try await HTTPClient.request(urlString: newUrl, method: .GET, parameters: makeParameters(), responseType: ComicAPIObject.self, header: makeHeaders())
            
            let result = try await networkManager?.request(
                method: .get,
                url: newUrl,
                headers: makeHeaders(),
                params: makeParams(),
                of: ComicAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch single comic"])
            }
            return result
        } catch let error {
            
            throw error
        }
    }
    
    // MARK: - Creators

    func fetchPaginatedCreators(offset: Int) async throws -> CreatorAPIObject {
        do {
            charOffset = offset
//            let result: CreatorAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.creators.rawValue)", method: .GET, parameters: makeParameters(), responseType: CreatorAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.creators.rawValue)",
                headers: makeHeaders(),
                params: makeParams(),
                of: CreatorAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch paginated creators"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
    }

    func fetchSingleCreator(url: String) async throws -> CreatorAPIObject {
        do {
            let newUrl = url.setHTTPSinsteadOfHTTP()
//            let result: CreatorAPIObject = try await HTTPClient.request(urlString: newUrl, method: .GET, parameters: makeParameters(), responseType: CreatorAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: newUrl,
                headers: makeHeaders(),
                params: makeParams(),
                of: CreatorAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch single creator"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
    }

    // MARK: - Events

    func fetchPaginatedEvents(offset: Int) async throws -> EventAPIObject {
        do {
            charOffset = offset
//            let result: EventAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.events.rawValue)", method: .GET, parameters: makeParameters(), responseType: EventAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.events.rawValue)",
                headers: makeHeaders(),
                params: makeParams(),
                of: EventAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch paginated events"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
    }

    func fetchSingleEvent(url: String) async throws -> EventAPIObject {
        do {
            let newUrl = url.setHTTPSinsteadOfHTTP()
//            let result: EventAPIObject = try await HTTPClient.request(urlString: newUrl, method: .GET, parameters: makeParameters(), responseType: EventAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: newUrl,
                headers: makeHeaders(),
                params: makeParams(),
                of: EventAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch single event"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
    }

    // MARK: - Series

    func fetchPaginatedSeries(offset: Int) async throws -> SeriesAPIObject {
        do {
            charOffset = offset
//            let result: SeriesAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.series.rawValue)", method: .GET, parameters: makeParameters(), responseType: SeriesAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.series.rawValue)",
                headers: makeHeaders(),
                params: makeParams(),
                of: SeriesAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch paginated series"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
    }

    func fetchSingleSeries(url: String) async throws -> SeriesAPIObject {
        do {
            let newUrl = url.setHTTPSinsteadOfHTTP()
//            let result: SeriesAPIObject = try await HTTPClient.request(urlString: newUrl, method: .GET, parameters: makeParameters(), responseType: SeriesAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: newUrl,
                headers: makeHeaders(),
                params: makeParams(),
                of: SeriesAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch single series"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
    }
    

    // MARK: - Stories

    func fetchPaginatedStories(offset: Int) async throws -> StoryAPIObject {
        do {
            charOffset = offset
//            let result: StoryAPIObject = try await HTTPClient.request(urlString: "\(baseUrl)\(url.stories.rawValue)", method: .GET, parameters: makeParameters(), responseType: StoryAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: "\(baseUrl)\(url.stories.rawValue)",
                headers: makeHeaders(),
                params: makeParams(),
                of: StoryAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch paginated stories"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
    }

    func fetchSingleStory(url: String) async throws -> StoryAPIObject {
        do {
            let newUrl = url.setHTTPSinsteadOfHTTP()
//            let result: StoryAPIObject = try await HTTPClient.request(urlString: newUrl, method: .GET, parameters: makeParameters(), responseType: StoryAPIObject.self, header: makeHeaders())
            let result = try await networkManager?.request(
                method: .get,
                url: newUrl,
                headers: makeHeaders(),
                params: makeParams(),
                of: StoryAPIObject.self
            )
            guard let result = result else {
                throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch single story"])
            }
            return result
        } catch let error {
            print(error)
            throw error
        }
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
