//
//  KelimelerimApp.swift
//  Kelimelerim
//
//  Created by Salihcan Kahya on 7.12.2020.
//

import SwiftUI
import Firebase

@main
struct KelimelerimApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            BookView()
        }
    }
}
