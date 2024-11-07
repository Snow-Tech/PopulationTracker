//
//  Extensions.swift
//  USAPopulation
//
//  Created by michael on 07/11/2024.
//

import Foundation

extension String {
    public mutating func append(path: String) {
        self = appendWith(path)
    }
    
    public func appendWith(_ path: String)  -> String {
        var output = self
        
        if output.isEmpty {
            output.append(path)
            
        } else {
            output.append("/\(path)")
        }
        
        return output
    }
}

extension Int {
    func formattedWithSeparator() -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }
}
