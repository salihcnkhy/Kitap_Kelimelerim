//
//  ContentView.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import SwiftUI

struct ContentView: View {
    @State var wordField = ""
    var body: some View {
        HStack(spacing: 20) {
            TextField("Kelime gir...",text: $wordField)
                .padding()
            Button("Ara") {
                ServiceManager<WordDictionaryElement>.request(url: URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(wordField)")!) { (value) in
                    
                } onFailure: { (err) in
                    print(err)
                }

            }.padding()
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
