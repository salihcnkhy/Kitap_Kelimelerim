//
//  WordDictionaryError.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import Foundation

struct WordDictionaryError: JsonModelProtocol {
    var title, message, resolution: String?
}
