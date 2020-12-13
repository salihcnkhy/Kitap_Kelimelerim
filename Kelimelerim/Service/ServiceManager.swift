//
//  ServiceManager.swift
//  Chatapp
//
//  Created by Salihcan Kahya on 29.11.2020.
//

import Foundation
import Alamofire

class ServiceManager<T> where T : JsonModelProtocol {
    
    static func request(url : URL, body: BaseRequest , onSuccess : @escaping (T) -> Void, onFailure : @escaping (Error)-> Void) {
        
        AF.request(url, method: .post, parameters: body, encoder: JSONParameterEncoder.default).responseDecodable(of: T.self) { response in
            if let responseValue = response.value {
                print(responseValue)
                return
            }
            if let data = response.data {
                if let error = try? JSONDecoder().decode(WordDictionaryError.self, from: data) {
                    print(error)
                    return
                }
            }
        }
    }
    
    static func request(url : URL, onSuccess : @escaping ([T]) -> Void, onFailure : @escaping (WordDictionaryError)-> Void) {
        
        AF.request(url, method: .get).responseString { response in
            if let response =  response.value {
                if let data =  response.data(using: .utf8) {
                    if let value = try? JSONDecoder().decode([T].self, from: data) {
                        print(value)
                        onSuccess(value)
                    }else if let err = try? JSONDecoder().decode(WordDictionaryError.self, from: data) {
                        onFailure(err)
                    }
                }
            }
        }
    }
}
