//
//  Home.swift
//  little-lemon
//
//  Created by Nanda WK on 2024-11-06.
//

import SwiftUI

struct Home: View {
    private let persistenceController = PersistenceController.shared

    var body: some View {
        TabView {
            Tab("Menu", systemImage: "list.dash") {
                Menu()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }

            Tab("Profile", systemImage: "square.and.pencil") {
                UserProfile()
            }
        }
        .tint(.secondary1)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
