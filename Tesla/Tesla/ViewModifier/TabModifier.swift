//
//  TabModifier.swift
//  Tesla

import SwiftUI

struct TabItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabItem] = []
    static func reduce (value: inout [TabItem], nextValue: () -> [TabItem]) {
        value += nextValue ()
    }
}

struct TabItemModifire: ViewModifier {
    let tabBarItem: TabItem
    func body (content: Content) -> some View {
        content
            .preference (key: TabItemPreferenceKey.self, value: [tabBarItem])
    }
}
