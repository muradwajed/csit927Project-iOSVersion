//
//  ResourcesModel.swift
//  UniService
//
//  Created by Murad Al Wajed on 17/10/2023.
//

import Foundation
struct ResourceModel: Codable {

    var id: Int
    var resourceName, resourceURL: String
    var isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case resourceName = "resourceName"
        case resourceURL = "resourceURL"
        case isAvailable = "isAvailable"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            self.resourceName = try container.decodeIfPresent(String.self, forKey: .resourceName) ?? ""
            self.resourceURL = try container.decodeIfPresent(String.self, forKey: .resourceURL) ?? ""
            self.isAvailable = try container.decodeIfPresent(Bool.self, forKey: .isAvailable) ?? false
        }
    }
    
    init() {
        self.id = 0
        self.resourceName = ""
        self.resourceURL = ""
        self.isAvailable = false
    }
    
}
