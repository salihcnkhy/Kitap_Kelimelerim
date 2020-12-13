//
//  BookViewModel.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 8.12.2020.
//

import Foundation
import Combine

class BookViewModel : BaseViewModel {

    @Published var searchingBookName : String = ""

    @Published var listOfBooks = [Book]() {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var isGoingBookWordsPage = false {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var isAddingNewBook = false {
        willSet {
            objectWillChange.send()
        }
    }
    var selectedBook : Book?
    
    var addBookCancellable : AnyCancellable?
    
    public func openBookWordPage(selectedBook : Book) {
        self.selectedBook = selectedBook
        isGoingBookWordsPage = true
    }
    public func addNewBook() {
        isAddingNewBook = true
    }
    
    public func createAddBookSubject() -> PassthroughSubject<Book, Never> {
        let subject = PassthroughSubject<Book, Never>()
        addBookCancellable = subject.sink(receiveValue: { [weak self] book in
            self?.addBookCancellable = FirebaseService.shared.addNewBook(data: book).sink(receiveCompletion: {_ in }, receiveValue: { [weak self]  in
                self?.listOfBooks.append(book)
                self?.isAddingNewBook = false
                self?.addBookCancellable?.cancel()
            })
        })
        return subject
    }
    
    
    deinit {
        print("removed")
    }
}
