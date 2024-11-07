//
//  SegmentPicker.swift
//  USAPopulation
//
//  Created by michael on 05/11/2024.
//

import SwiftUI

public struct SegmentPicker: View {
    @Binding var currentSegment: Segment
    
    public var body: some View {
        Menu {
            Picker("", selection: $currentSegment) {
                ForEach(Segment.allCases, id: \.self) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
        } label: {
            Label("", systemImage: "line.3.horizontal.decrease.circle")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SegmentPicker(currentSegment: .constant(.nation))
}
