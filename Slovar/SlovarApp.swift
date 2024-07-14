//
//  SlovarApp.swift
//  Slovar
//
//  Created by Антон Уханов on 14.7.24..
//

import SwiftUI
import SwiftData

@main
struct SlovarApp: App {
    var body: some Scene {
        let sharedContainer = Self.getContainer()
        WindowGroup {
            ContentView().modelContainer(sharedContainer)
        }
    }
    static private func getContainer() -> ModelContainer {
            do {
                return try ModelContainer(for: WordData.self)
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }
}
