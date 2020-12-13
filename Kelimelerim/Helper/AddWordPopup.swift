//
//  AddWordPopup.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 9.12.2020.
//

import SwiftUI

struct AddWordPopup: View {
    
    var deletage : AddWordProtocol
    @State var wordText = ""
    @State var sentence = ""
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.8)).shadow(color: Color.black.opacity(0.3), radius: 5, x: 1, y: 1).frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.gray).opacity(0.4)
                        HStack {
                            TextField("Kelime",text: $wordText)
                        } .padding(.horizontal, 10)
                    }
                    .padding(.horizontal, 10).frame(height: geo.size.height * 0.09)
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.gray).opacity(0.4)
                        HStack {
                            TextField("İçeren cümle (opsiyonel)",text: $sentence)
                        } .padding(.horizontal, 10)
                    }
                    .padding(.horizontal, 10).frame(height: geo.size.height * 0.09)
                    Button {
                        deletage.addNewWordToList(word: wordText, isPresented: false)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).foregroundColor(.blue).opacity(0.5)
                            Text("Ara").foregroundColor(.black)
                        }
                    }.frame(width: geo.size.width * 0.3 ,height: geo.size.height * 0.1).padding()
                    
                }
            }
            
        }
        
    }
}

