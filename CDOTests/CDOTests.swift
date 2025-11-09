//
//  CDOTests.swift
//  CDOTests
//
//  Created by Jon Alaniz on 11/7/25.
//

import XCTest
@testable import CDO

final class CDOTests: XCTestCase {
    let service = CDOService.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code
        // to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testServiceDecode() async throws {
        do {
            _ = try await service.fetchClients()
            _ = try await service.fetchCounselors()
            _ = try await service.fetchEmployers()
            _ = try await service.fetchPOs()
            _ = try await service.fetchReminders()
        } catch {
            print(error)
        }
    }

    func testStateService() async throws {
        let service = StatesService.shared

        do {
            _ = try await service.fetchAll()
        } catch {
            print(error)
        }
    }

    func testSingleClient() async throws {
        do {
            let client = try await service.fetchClient(id: 2663)
            print(client)
        }
    }
}
