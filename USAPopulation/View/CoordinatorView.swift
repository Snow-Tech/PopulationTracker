//
//  CoordinatorView.swift
//  USAPopulation
//
//  Created by michael on 07/11/2024.
//

import SwiftUI

public struct CoordinatorView: View {
    
    @State private var coordinator = Coordinator()
    
    public var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                NavigationStack(path: $coordinator.path) {
                    coordinator.buil(tab: tab)
                        .navigationDestination(for: Page.self) { page in
                            coordinator.buil(page: page)
                        }
                        .sheet(item: $coordinator.sheet) { page in
                            coordinator.buil(page: page)
                        }
                        .fullScreenCover(item: $coordinator.fullScreen) { page in
                            coordinator.buil(page: page)
                        }
                }
                .tabItem { Text(tab.title) }
                .tag(tab)
                .environment(coordinator)
            }
        }
    }
}
