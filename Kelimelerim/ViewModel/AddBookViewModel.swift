//
//  AddBookViewModel.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 8.12.2020.
//

import Foundation
import SwiftUI
import Combine

class AddBookViewModel : BaseViewModel {
    
    
    @Published var bookName : String = ""
    @Published var author : String = ""
    @Published var pageCount : String = ""
    @Published var validationError : Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var subject : PassthroughSubject<Book, Never>
    
    init(subject : PassthroughSubject<Book, Never>) {
        self.subject = subject
    }
    
    func createBook() {
        objectWillChange.send()
        if !bookName.isEmpty {
            let book = Book(bookName: bookName, author: author, pageCount: Int(pageCount) ?? 0)
            subject.send(book)
        } else {
            validationError = true
        }
    }
    
    func closeAlert() {
        validationError = false

    }
    
    func pageCountOnReceive(newValue : String) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        if filtered != newValue {
            self.pageCount = filtered
        }
    }
}
