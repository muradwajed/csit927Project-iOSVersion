//
//  RoomModel.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import Foundation
struct RoomModel: Codable {

    var id, roomNumber: Int
    var date: String
    var isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case roomNumber = "roomNumber"
        case date = "availableDate"
        case isAvailable = "isAvailable"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            self.roomNumber = try container.decodeIfPresent(Int.self, forKey: .roomNumber) ?? 0
            self.date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
            self.isAvailable = try container.decodeIfPresent(Bool.self, forKey: .isAvailable) ?? false
        }
    }
    
    init() {
        self.id = 0
        self.roomNumber = 0
        self.date = ""
        self.isAvailable = false
    }
    
}
