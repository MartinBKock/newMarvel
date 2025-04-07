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
        var encoding: ParameterEncoding = JSONEncoding.default
        switch method {
        case .post:
            encoding = JSONEncoding.default
        case .get:
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.default
        }
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                url,
                method: method,
                parameters: params,
                encoding: encoding,
                headers: HTTPHeaders(headers)
            ).responseDecodable(of: type) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func upload<T: Decodable>(
        data: Data,
        filename: String,
        fileType: String,
        url: String,
        headers: [String: String],
        of type: T.Type,
        progressHandler: @escaping (Double) -> Void
    ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            let multipartFormData = MultipartFormData()
            multipartFormData.append(data, withName: "file", fileName: filename, mimeType: fileType)
            
            AF.upload(multipartFormData: multipartFormData, to: url, method: .post, headers: HTTPHeaders(headers))
                .uploadProgress { progress in
                    progressHandler(progress.fractionCompleted)
                }
                .responseDecodable(of: type) { response in
                    switch response.result {
                    case let .success(data):
                        continuation.resume(returning: data)
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
