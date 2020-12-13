//
//  DetailView.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import SwiftUI

struct WordDetailView: View {
    var contents : [WordDictionaryElement]
    var body: some View {
        GeometryReader { geo in
            
            ScrollView {
                HStack {
                    Text(contents[0].word!.uppercased())
                        .font(.largeTitle).bold()
                    Spacer()
                }.padding()
                ForEach(contents, id: \.self) { content in
                    if ((content.meanings) != nil) {
                        HStack {
                            Text("MEANINGS")
                                .font(.title3).bold()
                            Spacer()
                        }.padding()
                        ForEach(content.meanings!, id: \.self) { meaning in
                            HStack {
                                Text((meaning.partOfSpeech ?? ""))
                                    .font(.subheadline)
                                    .foregroundColor(Color.black).bold()
                                Spacer()
                            }.padding()
                            if meaning.definitions != nil {
                                ForEach(0..<meaning.definitions!.count, id: \.self) { i in
                                    if meaning.definitions![i].definition != nil {
                                        HStack {
                                            Text("\(i+1). \(meaning.definitions![i].definition!)")
                                                .font(.subheadline)
                                                .bold()
                                            Spacer()
                                        }.padding()
                                    }
                                    if meaning.definitions![i].example != nil {
                                        HStack {
                                            Text(meaning.definitions![i].example!)
                                                .font(.subheadline)
                                                .italic()
                                                .foregroundColor(Color.gray)
                                                .bold()
                                                .opacity(0.8)
                                            Spacer()
                                        }.padding()
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
                
            }
            
        }
    }
}
