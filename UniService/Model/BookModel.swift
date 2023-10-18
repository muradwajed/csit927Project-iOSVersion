//
//  BookModel.swift
//  UniService
//
//  Created by Murad Al Wajed on 18/10/2023.
//

import Foundation
struct BookModel: Codable {

    var id, bookId, availableCopyNumber: Int
    var bookName: String

    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case bookId = "bookId"
        case availableCopyNumber = "availableCopyNumber"
        case bookName = "bookName"
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            self.bookId = try container.decodeIfPresent(Int.self, forKey: .bookId) ?? 0
            self.availableCopyNumber = try container.decodeIfPresent(Int.self, forKey: .availableCopyNumber) ?? 0
            self.bookName = try container.decodeIfPresent(String.self, forKey: .bookName) ?? ""
        }
    }
    
    init() {
        self.id = 0
        self.bookId = 0
        self.bookName = ""
        self.availableCopyNumber = 0
    }
    
}
