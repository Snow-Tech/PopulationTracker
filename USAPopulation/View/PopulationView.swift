//
//  ContentView.swift
//  USAPopulation
//
//  Created by michael on 04/11/2024.
//

import SwiftUI

struct PopulationView<ViewModel>: View where ViewModel: PopulationViewModelProtocol {
    
    @State public var viewModel: ViewModel
    // @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        VStack {
            if let error = viewModel.requestError {
                ContentUnavailableView("",
                                       systemImage: "exclamationmark.triangle.fill",
                                       description: Text(error.customMessage))
            } else {
                List(viewModel.population) { data in
                    PopulationInfoView(viewModel: viewModel.populationInfoViewModel(data))
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Home")
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                SegmentPicker(currentSegment: $viewModel.currentSegment)
                    .onChange(of: viewModel.currentSegment) { _, _ in
                        Task {
                            await viewModel.fetchPopulation()
                        }
                    }
            }
        }
        .task {
            await viewModel.fetchPopulation()
        }
    }
}

#Preview {
    NavigationStack {
        let dependencies = PopulationViewModel.Dependecies(service: USADataService())
        PopulationView(viewModel: PopulationViewModel(dependencies: dependencies))
    }
}
