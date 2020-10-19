//
//  MultiSegmentPickerDemo.swift
//  MultiSegmentDemo
//
//  Created by Yonat Sharon on 17/09/2019.
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

#if canImport(SwiftUI)
import MultiSelectSegmentedControl
import SwiftUI

struct MultiSegmentPickerStruct: View {
    @State private var selectedSegmentIndexes: IndexSet = []

    var body: some View {

            MultiSegmentPicker(
                selectedSegmentIndexes: $selectedSegmentIndexes,
                
                items: [
                    "Mon",
                    "Tue",
                    "Wed",
                    "Thu",
                    "Fri",
                    "Sat",
                    "Sun"]
            )
            .backgroundColor(.blue)
            
        }
    }


#endif
