//
//  Skills_CompareApp.swift
//  Skills_Compare
//
//  Created by Web_Dev on 2/28/23.
//

import SwiftUI

@main
struct Skills_CompareApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            MainView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//
            
            MainView() .frame(minWidth: 800, idealWidth: 800, maxWidth: 800,
                              minHeight: 800, idealHeight: 800, maxHeight: 800,
                              alignment: .center).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
