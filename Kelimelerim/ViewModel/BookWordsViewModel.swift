//
//  HomeViewModel.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import Foundation
import Combine
import SwiftUI

class BookWordsViewModel : BaseViewModel {
    
    @Published var wordField : String = ""
    @Published var isDetailViewShowing : Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var isNewWordPopupAppear : Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var book : Book
    
    var selectedContent : [WordDictionaryElement]?
    
    init(book : Book) {
        self.book = book
    }
    
    func fetchWord(word: String) {
        startLoading()
        ServiceManager<WordDictionaryElement>.request(url: URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)")!,onSuccess: onFetchSuccess, onFailure: onFetchSuccess)
    }
    override func onFetchSuccess(data: Decodable) {
        super.onFetchSuccess(data: data)
        if let data = data as? [WordDictionaryElement] {
            print(data)
            self.objectWillChange.send()
            self.book.words.append(data[0].word!)
        }
    }
    override func onFetchFailure(error: WordDictionaryError) {
        super.onFetchFailure(error: error)
        print("aAAAaaaaaAAAaaAa")
    
    }
    
    func getWord() {
        self.isDetailViewShowing.toggle()
        print(self.isDetailViewShowing)

    }
    
    func openDetailView(selectedContent : [WordDictionaryElement]) {
        self.selectedContent = selectedContent
        self.isDetailViewShowing = true
    }
    
    func addNewWord() {
        withAnimation {
            isNewWordPopupAppear.toggle()
        }
    }
}

extension BookWordsViewModel : AddWordProtocol {
    func addNewWordToList(word: String, isPresented: Bool) {
        withAnimation {
            self.isNewWordPopupAppear = isPresented
        }
        fetchWord(word: word)
    }

}
