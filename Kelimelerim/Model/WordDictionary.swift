//
//  WordDictionary.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import Foundation

// MARK: - WordDictionaryElement
struct WordDictionaryElement: JsonModelProtocol, Hashable {
    var word: String?
    var phonetics: [Phonetic]?
    var meanings: [Meaning]?
}

// MARK: - Meaning
struct Meaning: JsonModelProtocol, Hashable {
    var partOfSpeech: String?
    var definitions: [Definition]?
}

// MARK: - Definition
struct Definition: JsonModelProtocol, Hashable {
    var definition, example: String?
    var synonyms: [String]?
}

// MARK: - Phonetic
struct Phonetic: JsonModelProtocol, Hashable {
    var text: String?
    var audio: String?
}

