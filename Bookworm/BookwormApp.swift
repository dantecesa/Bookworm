//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Dante Cesa on 2/1/22.
//

import SwiftUI

@main
struct CoreDataExample: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
