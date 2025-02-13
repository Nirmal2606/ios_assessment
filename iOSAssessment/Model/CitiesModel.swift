//
//  CitiesModel.swift
//  iOSAssessment
//
//  Created by Nirmal Ashokkumar on 12/02/25.
//

import Foundation

struct CitiesModel: Codable, Identifiable {
    let id = UUID()
    let city: String
    let lat: String
    let lng: String
    let country: String
    let iso2: String
    let admin_name: String
    let capital: String
    let population: String
    let population_proper: String

    enum CodingKeys: String, CodingKey {
        case city, lat,lng,country,iso2,admin_name,capital,population,population_proper
    }
}
