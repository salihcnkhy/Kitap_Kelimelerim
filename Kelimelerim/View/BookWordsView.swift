//
//  HomeView.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import SwiftUI

struct BookWordsView: View {
    
    @StateObject var vm : BookWordsViewModel
    
    
    
    let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment : .center) {
                VStack(spacing: 5){
                    HStack(spacing: 5) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).foregroundColor(.gray).opacity(0.2)
                            HStack {
                                Image(systemName: "magnifyingglass").foregroundColor(.orange)
                                TextField("Kelime giriniz",text: $vm.wordField)
                            } .padding(.horizontal, 15)
                        }
                    }.padding(.horizontal, 10).frame(height: geo.size.height * 0.05)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(vm.book.words, id: \.self) { word in
                                WordCard(content: word).frame(minHeight: 100, alignment: .center)//.onTapGesture(count: 1, perform: {vm.openDetailView(selectedContent: word)})
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top,5)
                }
                if self.vm.isFetching {
                    withAnimation(.easeIn(duration: 0.5)){
                        Group {
                            Color(.gray).opacity(0.5).edgesIgnoringSafeArea(.all)
                            ProgressView().padding()
                        }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    }
                }
                if vm.isNewWordPopupAppear {
                    Color(.gray).opacity(0.5).edgesIgnoringSafeArea(.all)
                    AddWordPopup(deletage: vm.self).frame(width: geo.size.width * 0.9, height: geo.size.height * 0.85, alignment: .center).animation(.easeIn(duration: 0.2))
                }
            }
             .navigationTitle("Kelimelerim")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button(action: vm.addNewWord, label: {Image(systemName: "plus")}))
        }
        .sheet(isPresented: $vm.isDetailViewShowing, content: {
            WordDetailView(contents: vm.selectedContent!)
        })
        
        
    }
}
