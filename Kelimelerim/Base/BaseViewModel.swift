//
//  BaseViewModel.swift
//  Chatapp
//
//  Created by Salihcan Kahya on 18.11.2020.
//

import Foundation
import SwiftUI

class BaseViewModel : ObservableObject {
    
    @Published var isFetching : Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var isFecthSuccess : Bool = false {
        willSet {
            objectWillChange.send()

        }
    }
    @Published  var isFirstFetch : Bool = true {
        willSet {
            objectWillChange.send()

        }
    }
        
    func startLoading() {
        isFetching = true
    }
    
    func stopLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isFetching = false
        }
    }

    
    func onFetchSuccess(data : Decodable) {
        stopLoading()
        isFetching = false
        if isFirstFetch {
            isFirstFetch = false
        }
        isFecthSuccess = true
    }
    func onFetchFailure(error : Error) {
        stopLoading()
    }
    func onFetchFailure(error : WordDictionaryError) {
        stopLoading()
    }
}
