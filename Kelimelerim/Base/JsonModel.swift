//
//  BaseRequestModel.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import Foundation

protocol JsonModelProtocol : Codable { }


extension JsonModelProtocol {
    public func toJsonString() -> String? {
        if let data = try? JSONEncoder().encode(self) {
            if let jsonString = String(data: data, encoding: .utf8) {
                return jsonString
            }
        }
        return nil
    }
}
