import Foundation
import NetworkingInterface
import NetworkingInterfaceTestUtils
import XCTest

@testable import Networking

final class NetworkingTests: XCTestCase {
    private let urlFactorySpy = URLFactorySpy()
    private let resultHandlerSpy = NetworkRequestResultHandlerSpy()
    private let urlSessionSpy = URLSessionSpy()
    
    private lazy var sut = Networking(
        urlFactory: urlFactorySpy,
        resultHandler: resultHandlerSpy,
        urlSession: urlSessionSpy
    )
    
    func test_request_withInvalidURL_shouldReturnInvalidURLError() async throws {
        urlFactorySpy.makeToBeReturned = nil
        do {
            _ = try await sut.request(NetworkRequestFixture(), responseModel: ResponseModelDummy.self)
        } catch let error as NetworkRequestError {
            XCTAssertTrue(urlFactorySpy.makeCalled)
            XCTAssertTrue(urlFactorySpy.makeRequestPassed is NetworkRequestFixture)
            XCTAssertEqual(error, .unknown)
        }
    }
    
    func test_request_withValidURL_shouldCallDataForRequest() async throws {
        urlFactorySpy.makeToBeReturned = URLRequest(url: .forcedURL())
        
        do {
            _ = try await sut.request(
                NetworkRequestFixture(),
                responseModel: ResponseModelDummy.self
            )
        } catch {
            XCTAssertTrue(urlSessionSpy.dataForRequestCalled)
        }
    }
}

fileprivate class ResponseModelDummy: Codable {}
