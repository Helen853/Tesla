//
//  TeslaApp.swift
//  Tesla
//
//  Created by Киса Мурлыса on 13.05.2024.
//

import SwiftUI

@main
struct TeslaApp: App {
    var body: some Scene {
        WindowGroup {
            StartedView()
                .environment (\.colorScheme, .dark)
        }
    }
}
