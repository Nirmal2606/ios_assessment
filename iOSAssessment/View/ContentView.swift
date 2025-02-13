//
//  ContentView.swift
//  iOSAssessment
//
//  Created by Nirmal Ashokkumar on 12/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CitiesViewModel()
    @State private var expandedSections: Set<String> = []

    var body: some View {
        NavigationView {
            VStack {
                // Button to Reverse Order
                Button(action: {
                    viewModel.isReversed.toggle()
                }) {
                    Text("Reverse Order")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                List {
                    ForEach(viewModel.sortedSections, id: \.self) { section in
                        DisclosureGroup(
                            isExpanded: Binding(
                                get: { expandedSections.contains(section) },
                                set: { isExpanded in
                                    if isExpanded {
                                        expandedSections.insert(section)
                                    } else {
                                        expandedSections.remove(section)
                                    }
                                }
                            ),
                            content: {
                                ForEach(viewModel.sortedCities(for: section)) { city in
                                    Text(city.city)
                                        .padding(.leading, 10)
                                }
                            },
                            label: {
                                Text(section).font(.headline)
                            }
                        )
                    }
                }
                .navigationTitle("Cities")
                .onAppear {
                    viewModel.loadJSONData()
                }
            }
        }
    }
}

   
