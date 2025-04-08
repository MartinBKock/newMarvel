//
//  TestScructs.swift
//  Template
//
//  Created by Martin Kock on 08/12/2023.
//

import Foundation

struct GetTest: Codable {
      let args: Args?
      let headers: Headers
      let origin: String?
      let url: String?
}
struct Args: Codable {
}
struct Headers: Codable {
      let accept, acceptEncoding, acceptLanguage, host: String?
      let secFetchDest, secFetchMode, secFetchSite, secFetchUser: String?
      let upgradeInsecureRequests, userAgent, xAmznTraceID: String?
      
      enum CodingKeys: String, CodingKey {
            case accept = "Accept"
            case acceptEncoding = "Accept-Encoding"
            case acceptLanguage = "Accept-Language"
            case host = "Host"
            case secFetchDest = "Sec-Fetch-Dest"
            case secFetchMode = "Sec-Fetch-Mode"
            case secFetchSite = "Sec-Fetch-Site"
            case secFetchUser = "Sec-Fetch-User"
            case upgradeInsecureRequests = "Upgrade-Insecure-Requests"
            case userAgent = "User-Agent"
            case xAmznTraceID = "X-Amzn-Trace-Id"
      }
}
