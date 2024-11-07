//
//  USAPopulationTests.swift
//  USAPopulationTests
//
//  Created by michael on 04/11/2024.
//

import XCTest
@testable import USAPopulation

final class USAPopulationTests: XCTestCase {

    var service: USADataServiceMock!
    var url: USADataRequests.PopulationData!
    
    let nationParameters = USADataParameters(drilldowns: "Nation", measures: "Population")
    let stateParameters = USADataParameters(drilldowns: "State", measures: "Population")

    override func setUp() {
        super.setUp()
        service = USADataServiceMock()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testGetPopulationDataFailure() async {
        let parameters = USADataParameters(drilldowns: "", measures: "")
        let result = await service.getPopulationData(headers: nil, parameters: parameters)

        switch result {
        case .success:
            XCTFail("Expected failure for invalid data, but got success")
        case .failure(let error):
            XCTAssertEqual(error, .invalidURL)
            XCTAssertNotNil(error, "Expected error, but got nil")
        }
    }
    
    func testGetPopulationDataForNation() async {
        let result = await service.getPopulationData(headers: nil, parameters: nationParameters)

        switch result {
        case .success(let response):
            XCTAssertNotNil(response.data?.first?.idNation)
            XCTAssertNotNil(response.data?.first?.nation)
        case .failure:
            XCTFail("Expected success for nation data, but got failure")
        }
    }
    
    func testGetPopulationDataForNationShouldReturnNilForState() async {
        let result = await service.getPopulationData(headers: nil, parameters: nationParameters)

        switch result {
        case .success(let response):
            XCTAssertNil(response.data?.first?.idState)
            XCTAssertNil(response.data?.first?.state)
        case .failure:
            XCTFail("Expected success for nation data, but got failure")
        }
    }
    
    func testGetPopulationDataForStateShouldReturnNilForNation() async {
        let result = await service.getPopulationData(headers: nil, parameters: stateParameters)

        switch result {
        case .success(let response):
            XCTAssertNil(response.data?.first?.idNation)
            XCTAssertNil(response.data?.first?.nation)
        case .failure:
            XCTFail("Expected success for nation data, but got failure")
        }
    }

    func testGetPopulationDataForState() async {
        let result = await service.getPopulationData(headers: nil, parameters: stateParameters)

        switch result {
        case .success(let response):
            XCTAssertNotNil(response.data?.first?.idState)
            XCTAssertNotNil(response.data?.first?.state)
        case .failure:
            XCTFail("Expected success for state data, but got failure")
        }
    }
    
    func testGetPopulationDataForNationYearLatest() async {
        let parameters = USADataParameters(drilldowns: "Nation", measures: "Population", year: "latest")
        let result = await service.getPopulationData(headers: nil, parameters: parameters)

        switch result {
        case .success(let response):
            XCTAssertEqual(response.data?.first?.year, "2022")
        case .failure:
            XCTFail("Expected success for latest nation data, but got failure")
        }
    }
    
    func testGetPopulationDataForStateYearLatest() async {
        let parameters = USADataParameters(drilldowns: "State", measures: "Population", year: "latest")
        let result = await service.getPopulationData(headers: nil, parameters: parameters)

        switch result {
        case .success(let response):
            XCTAssertEqual(response.data?.first?.year, "2022")
        case .failure:
            XCTFail("Expected success for latest state data, but got failure")
        }
    }
    func testGetPopulationDataForStateYearEmpty() async {
        let parameters = USADataParameters(drilldowns: "State", measures: "Population", year: "")
        let result = await service.getPopulationData(headers: nil, parameters: parameters)

        switch result {
        case .success:
            XCTFail("Expected failure for invalid data, but got success")
        case .failure(let error):
            XCTAssertNotNil(error, "Expected error, but got nil")
        }
    }
}
