//
//  PopulationInfoViewModel.swift
//  USAPopulation
//
//  Created by michael on 05/11/2024.
//

import Foundation

public protocol PopulationInfoViewModelProtocol {
    var title: String { get }
    var year: String { get }
    var population: String { get }
}

public class PopulationInfoViewModel: PopulationInfoViewModelProtocol {
    
    public struct Dependecies {
        public var USAData: USAData?
        public var segment: Segment?
        
        public init(USAData: USAData?, segment: Segment?) {
            self.USAData = USAData
            self.segment = segment
        }
    }
    
    public var dependencies: Dependecies?
    
    public init(dependencies: Dependecies?) {
        self.dependencies = dependencies
    }
    
    private var nation: String {
        return dependencies?.USAData?.nation ?? ""
    }
    
    private var state: String {
        return dependencies?.USAData?.state ?? ""
    }
    
    public var title: String {
        return dependencies?.segment == .nation ? nation : state
    }
    
    public var year: String {
        let year = dependencies?.USAData?.year ?? ""
        return year.isEmpty ? "" : "Year: \(year)"
    }
    
    public var population: String {
        let population = dependencies?.USAData?.population.formattedWithSeparator() ?? ""
        return population.isEmpty ? "" : "Population: \(population)"
    }
}
