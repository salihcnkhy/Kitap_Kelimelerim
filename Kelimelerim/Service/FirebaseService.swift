//
//  FirebaseService.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import Foundation
import Firebase
import Combine
import FirebaseFirestoreSwift

class FirebaseService {
    
    public static let shared : FirebaseService = FirebaseService()
    private let db : Firestore
        
    private init() {
         db = Firestore.firestore()
    }
    
    public func addNewBook( data : Book) -> AnyPublisher<Void, Error>{
        let collection = db.collection(Collections.Books.rawValue)
        return collection.document(data.id).setData(from: data, merge: false)
    }
    
    public func getBooks() -> AnyPublisher<Book, Never> {
        
        let collection = db.collection(Collections.Books.rawValue)
        return collection.getDocumentData(as: Book.self)
            .catch({ _ in Just(Book(bookName: ""))  })
            .filter({!$0.bookName.isEmpty})
            .eraseToAnyPublisher()
    }
    
//    public func updateBook() -> AnyPublisher<Void, Error> {
//        let collection = db.collection(Collections.Books.rawValue)
//   
//    }
}

public enum Collections : String{
    case Books = "Books"
    case Words = "Words"
}

extension Query {
    
    func blabla(){
        
    }
    
    func getDocumentData<T: Decodable>(as Type: T.Type) -> AnyPublisher<T, Error>  {
        
       return getDocuments()
           .mapError({$0})
            .flatMap{ $0 }
            .compactMap { doc in doc.data() }
            .compactMap{ dict in try? JSONSerialization.data(withJSONObject: dict, options: [])}
            .decode(type: T.self, decoder: JSONDecoder()).print()
            .eraseToAnyPublisher()
            
    }
    
    private func getDocuments() -> AnyPublisher<AnyPublisher<QueryDocumentSnapshot, Never>, Error> {
        Future<AnyPublisher<QueryDocumentSnapshot, Never>, Error> { [weak self]  promise in
            self?.getDocuments(completion: { (snapshot, error) in
                if let error = error {
                    promise(.failure(error))
                } else if let snapshot = snapshot {
                    
                    promise(.success(snapshot.documents.publisher.eraseToAnyPublisher()))
                }else {
                    promise(.failure(FirestoreError.noData))
                }
            })
        }.eraseToAnyPublisher()
    }
    
}

extension CollectionReference {
    
    
    
    public func addDocument<T: Encodable>(from data: T, encoder: Firestore.Encoder = Firestore.Encoder()) -> AnyPublisher<DocumentReference, Error> {
        var ref: DocumentReference?
        return Future<DocumentReference, Error> { [weak self] promise in
            do {
                ref = try self?.addDocument(from: data, encoder: encoder) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let ref = ref {
                        promise(.success(ref))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

}

extension DocumentReference {
    
    
    public func setData<T: Encodable>(from data: T, merge: Bool, encoder: Firestore.Encoder = Firestore.Encoder()) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            do {
                try self?.setData(from: data, merge: merge, encoder: encoder) { error in
                    guard let error = error else {
                        promise(.success(()))
                        return
                    }
                    promise(.failure(error))
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    public func updateData(_ fields: [AnyHashable: Any]) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.updateData(fields) { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}


enum FirestoreError: Error {
    case noData
}

