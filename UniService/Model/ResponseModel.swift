//
//  ResponseModel.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import Foundation

enum CodingKeysResponse: String, CodingKey {
    case status, message, data
    case statusCode = "status_code"
}

struct ResponseArray<T>: Codable where T: Codable {
    let responseCode: Int
    let result: String
    let errormessage: String
    let data: [T]
    
    enum CodingKeys: String, CodingKey{
        case responseCode = "responseCode"
        case result = "result"
        case errormessage = "errormessage"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.responseCode = try container.decodeIfPresent(Int.self, forKey: .responseCode) ?? 0
            self.result = try container.decodeIfPresent(String.self, forKey: .result) ?? ""
            self.errormessage = try container.decodeIfPresent(String.self, forKey: .errormessage) ?? ""
            self.data = try container.decodeIfPresent([T].self, forKey: .data) ?? [T]()
        }
    }
}
