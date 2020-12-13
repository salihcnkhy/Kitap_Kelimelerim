//
//  Book.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 8.12.2020.
//

import Foundation
import FirebaseFirestoreSwift


struct Book: JsonModelProtocol, Identifiable {
    
    init(id: String = UUID().uuidString, bookName: String, author: String = "", pageCount: Int = 0, words: [String] = []) {
        self.id = id
        self.bookName = bookName
        self.author = author
        self.pageCount = pageCount
        self.words = words
    }
    
    var id : String
    var bookName : String
    var author : String
    var pageCount : Int
    var words : [String]
    
 
    
    enum CodingKeys : String, CodingKey {
        case id
        case bookName
        case author
        case pageCount
        case words
    }
}
