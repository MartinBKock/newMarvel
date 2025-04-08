//
//  File.swift
//
//
//  Created by Martin Kock on 04/07/2024.
//

import Foundation
import Alamofire

actor NetworkManager {
    func request<T: Decodable>(
        method: HTTPMethod,
        url: String,
        headers: [String: String],
        params: Parameters?,
        of type: T.Type
    ) async throws -> T {
        let encoding: ParameterEncoding = switch method {
            case .post: JSONEncoding.default
            case .get: URLEncoding.default
            default: JSONEncoding.default
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: params,
                encoding: encoding,
                headers: HTTPHeaders(headers)
            ).responseDecodable(of: type) { response in
                Task { @MainActor in
                    switch response.result {
                    case let .success(value):
                        continuation.resume(returning: value)
                        
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}
