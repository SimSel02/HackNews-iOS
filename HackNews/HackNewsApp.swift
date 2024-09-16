//
//  HackNewsApp.swift
//  HackNews
//
//  Created by Simone Sella on 11/09/24.
//

import SwiftUI
import SwiftData

@main
struct HackNewsApp: App {
    
    @StateObject var storiesVM = StoriesViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(storiesVM)
                .tint(.red)
        }
        .modelContainer(for: [Favourite.self])
    }
}
