//
//  BookView.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 8.12.2020.
//

import SwiftUI
import Combine
struct BookView: View {
    
    @StateObject var vm = BookViewModel()
    
    @State var subs : AnyCancellable?
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                
                VStack(spacing: 5){
                    HStack(spacing: 5) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(.gray).opacity(0.2)
                            HStack {
                                Image(systemName: "magnifyingglass").foregroundColor(.orange)
                                TextField("Kitap adı giriniz",text: $vm.searchingBookName)
                            } .padding(.horizontal, 15)
                        }
                    }.padding(.horizontal, 10).frame(height: geo.size.height * 0.05)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(vm.listOfBooks, id : \.id ) { book in
                                BookCard(content: book).frame(minHeight: 100, alignment: .center).onTapGesture(count: 1, perform: {vm.openBookWordPage(selectedBook: book)})
                            }
                        }
                        .padding(.horizontal)
                    }
                    NavigationLink(destination: BookWordsView( vm: BookWordsViewModel(book: vm.selectedBook!)), isActive: $vm.isGoingBookWordsPage, label: { EmptyView() })
                    .padding(.top,5)
                } .navigationTitle("Kitaplarım")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: Button(action: vm.addNewBook, label: {Image(systemName: "plus")}))
            }
            .sheet(isPresented: $vm.isAddingNewBook) { AddBookView(vm: AddBookViewModel(subject: vm.createAddBookSubject()))}
            .onAppear {
               
                self.subs = FirebaseService.shared.getBooks()
                    .sink(receiveCompletion: {_ in}, receiveValue: {[self] (books) in
                        vm.listOfBooks.append(books)
                        print("Hi \(books)")
                        //subs?.cancel()
                })
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
