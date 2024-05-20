//
//  TabView.swift
//  Tesla


import SwiftUI

struct Tab: View {
    
    private enum Constants {
        static let personName = "person2"
        static let carName = "carSymbol"
        static let lightNamme = "lightImage"
        static let locationName = "location"
    }
    
    var body: some View {
        CustomTabView(selection: $selection) {
            HomeView()
                .myTabItem {
                    TabItem(icount: Constants.carName)
                }
                .opacity(selection == 0 ? 1 : 0)
            ChargeView()
                .myTabItem {
                    TabItem(icount: Constants.lightNamme)
                }
                .opacity(selection == 1 ? 1 : 0)
            Color.gray
                .myTabItem {
                    TabItem(icount: Constants.locationName)
                }
                .opacity(selection == 2 ? 1 : 0)

            Color.gray
                .myTabItem {
                    TabItem(icount: Constants.personName)
                }
                .opacity(selection == 3 ? 1 : 0)
        }
    }
    @State private var selection = 0
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
            .environment (\.colorScheme, .dark)
    }
}
