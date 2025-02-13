//
//  CitiesViewModel.swift
//  iOSAssessment
//
//  Created by Nirmal Ashokkumar on 12/02/25.
//


import Foundation
import SwiftUI

// ViewModel to manage city data
class CitiesViewModel: ObservableObject {
    @Published var cityArray: [CitiesModel] = []
    @Published var isReversed: Bool = false

    // Group cities by admin_name (State)
    var groupedCities: [String: [CitiesModel]] {
        Dictionary(grouping: cityArray, by: { $0.admin_name })
    }

    // Sorted and Reversed Sections
    var sortedSections: [String] {
        let sections = groupedCities.keys.sorted()
        return isReversed ? sections.reversed() : sections
    }

    // Sorted and Reversed Cities per Section
    func sortedCities(for section: String) -> [CitiesModel] {
        let cities = groupedCities[section] ?? []
        return isReversed ? cities.reversed() : cities
    }

    
   //MARK: - Load json Data from JSON file
    func loadJSONData() {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedData = try? JSONDecoder().decode([CitiesModel].self, from: data) else {
                  print("Failed to load or decode JSON")
                return
              }
        cityArray = decodedData
    }
    
    
}
