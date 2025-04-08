//
//  Consts.swift
//  Dev
//
//  Created by Martin Kock on 23/11/2024.
//

import Foundation

extension String {
   func setHTTPSinsteadOfHTTP() -> String {
       let url = URL(string: self)
       guard let scheme = url?.scheme else { return self }
       if scheme == "http" {
           return self.replacingOccurrences(of: "http://", with: "https://")
       } else {
           return self
       }
   }
}
