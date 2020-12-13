//
//  WordCard.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import SwiftUI

struct WordCard: View {
    
    let content : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(Color.orange).opacity(0.8).shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.4), radius: 3, x: 0, y: 3)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(content)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .bottom, .trailing]).padding(.top, 10)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
