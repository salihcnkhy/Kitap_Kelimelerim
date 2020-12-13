//
//  BaseRequestModel.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import Foundation

protocol JsonModelProtocol : Codable { }

extension JsonModelProtocol {
    public func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        if let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return dict
        }else {
            return nil
        }
    }
    init(with dict : [String: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

class BaseRequest : JsonModelProtocol { }

