//
//  AddBook.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 8.12.2020.
//

import SwiftUI
import Combine

struct AddBookView: View {
    
    @StateObject var vm : AddBookViewModel
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    VStack {
                        Image("book").resizable()
                            .frame(width: geo.size.width * 0.4, height:  geo.size.width * 0.4)
                            .padding()
                        TextField("Kitap adı girin...", text: $vm.bookName).padding()
                        TextField("Yazar adı girin...", text: $vm.author).padding()
                        TextField("Sayfa sayısı girin...", text: $vm.pageCount).onReceive(Just(vm.bookName), perform: vm.pageCountOnReceive).padding()
                    }
                }.frame(height: geo.size.height * 0.9)
                Button(action: vm.createBook) {
                    ZStack {
                        Rectangle().fill(Color.orange).opacity(0.75)
                        Text("Ekle").font(.title3).bold().foregroundColor(.black)
                    }
                }.frame(height: geo.size.height * 0.1)
                .alert(isPresented: $vm.validationError) {
                    Alert(title: Text("Zorunlu Alan"), message: Text("Kitap adı zorunlu"), dismissButton: .cancel(Text("Tamam"),action: vm.closeAlert))
                }
            }
        }
    }
}

