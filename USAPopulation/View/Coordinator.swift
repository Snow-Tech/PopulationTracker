//
//  CoordinatorView.swift
//  USAPopulation
//
//  Created by michael on 07/11/2024.
//

import SwiftUI

public enum Page: String, Identifiable {
    case details
    
    public var id: String {
        self.rawValue
    }
}

public enum TabItem: Hashable, CaseIterable {
    case home
    case other
    
    public var title: String {
        switch self {
        case .home:    return "First tab"
        case .other:   return "Second tab"
        }
    }
}

@Observable
public class Coordinator {
    public var path = NavigationPath()
    public var sheet: Page?
    public var fullScreen: Page?
    
    public var selectedTab: TabItem = .home
    
    public func push(_ page: Page) {
        path.append(page)
    }
    
    public func present(sheet: Page) {
        self.sheet = sheet
    }
    
    public func present(fullScreen: Page) {
        self.fullScreen = fullScreen
    }
    
    public func pop() {
        path.removeLast()
    }
    
    public func popToRoot() {
        path.removeLast(path.count)
    }
    
    public func dismissSheet() {
        self.sheet = nil
    }
    
    public func dismissFullScreen() {
        self.fullScreen = nil
    }
    
    @ViewBuilder
    public func buil(tab: TabItem) -> some View {
        switch tab {
        case .home:
            setupPopulationView()
        case .other:
            Text("🇵🇹")
        }
    }
    
    @ViewBuilder
    public func buil(page: Page) -> some View {
        switch page {
        case .details:
            Text("🇵🇹")
        }
    }
    
    @ViewBuilder
    private func setupPopulationView() -> some View {
        let dependencies = PopulationViewModel.Dependecies(service: USADataService())
        let viewModel = PopulationViewModel(dependencies: dependencies)
        PopulationView(viewModel: viewModel)
    }
}
