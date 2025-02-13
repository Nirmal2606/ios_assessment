//
//  iOSAssessmentTests.swift
//  iOSAssessmentTests
//
//  Created by Nirmal Ashokkumar on 12/02/25.
//

import XCTest
@testable import iOSAssessment
import Foundation
import Testing

struct iOSAssessmentTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test  func testJSONDecoding() throws {
           let json = """
           [
               {
                   "city": "Sydney",
                   "lat": "-33.8678",
                   "lng": "151.2100",
                   "country": "Australia",
                   "iso2": "AU",
                   "admin_name": "New South Wales",
                   "capital": "admin",
                   "population": "4840600",
                   "population_proper": "4840600"
               },
               {
                   "city": "Melbourne",
                   "lat": "-37.8136",
                   "lng": "144.9631",
                   "country": "Australia",
                   "iso2": "AU",
                   "admin_name": "Victoria",
                   "capital": "admin",
                   "population": "4529500",
                   "population_proper": "4529500"
               }
           ]
           """

           let jsonData = json.data(using: .utf8)!
           let decodedCities = try JSONDecoder().decode([CitiesModel].self, from: jsonData)

           XCTAssertEqual(decodedCities.count, 2)
           XCTAssertEqual(decodedCities[0].city, "Sydney")
           XCTAssertEqual(decodedCities[1].country, "Australia")
       }

    @Test func testGroupingCitiesByCountryName() {
           let testCities = [
            CitiesModel(city: "Sydney", lat: "-33.8678", lng: "151.2100", country: "Australia", iso2: "AU", admin_name: "New South Wales", capital: "admin", population: "4840600", population_proper: "4840600"),
            CitiesModel(city: "Melbourne", lat: "-37.8136", lng: "144.9631", country: "Australia", iso2: "AU", admin_name: "Victoria", capital: "admin", population: "4529500", population_proper: "4529500"),
            CitiesModel(city: "New York", lat: "40.7128", lng: "-74.0060", country: "USA", iso2: "US", admin_name: "New York", capital: "admin", population: "8419600", population_proper: "8419600")
           ]

           let groupedCities = Dictionary(grouping: testCities, by: { $0.country })

           XCTAssertEqual(groupedCities["Australia"]?.count, 2)
           XCTAssertEqual(groupedCities["USA"]?.count, 1)
           XCTAssertEqual(groupedCities["USA"]?.first?.city, "New York")
       }

    @Test func testExpandCollapse() {
           let testView_ = ContentView()
           var expandedSections = Set<String>()

           // Simulate expanding a section
           expandedSections.insert("Australia")
           XCTAssertTrue(expandedSections.contains("Australia"))

           // Simulate collapsing a section
           expandedSections.remove("Australia")
           XCTAssertFalse(expandedSections.contains("Australia"))
       }

    @Test  func testLoadingJSONFromBundle() {
           guard let url = Bundle.main.url(forResource: "au_cities", withExtension: "json"),
                 let data = try? Data(contentsOf: url),
                 let decodedCities = try? JSONDecoder().decode([CitiesModel].self, from: data) else {
               XCTFail("Failed to load or decode JSON")
               return
           }

           XCTAssertGreaterThan(decodedCities.count, 0)
           XCTAssertEqual(decodedCities.first?.city, "Sydney")
       }

    @Test  func loadingJsonInCorrectfile() {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decodedCities = try? JSONDecoder().decode([CitiesModel].self, from: data) else {
            XCTFail("File not found")
            return
        }

    }
}
