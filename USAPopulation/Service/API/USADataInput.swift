//
//  USADataInput.swift
//  USAPopulation
//
//  Created by michael on 05/11/2024.
//

import Foundation

public struct USADataParameters: ModelProtocol {
    public var drilldowns: String?
    public var measures: String
    public var year: String?
    
    public init(drilldowns: String? = nil, measures: String, year: String? = nil) {
        self.drilldowns = drilldowns
        self.measures = measures
        self.year = year
    }
}
