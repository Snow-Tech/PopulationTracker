//
//  PopulationInfoView.swift
//  USAPopulation
//
//  Created by michael on 05/11/2024.
//

import SwiftUI

public struct PopulationInfoView<ViewModel>: View where ViewModel: PopulationInfoViewModelProtocol {
    
    public var viewModel: ViewModel
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(viewModel.year)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(viewModel.population)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    let viewModel = PopulationInfoViewModel(dependencies: nil)
    PopulationInfoView(viewModel: viewModel)
}
