import NetworkingInterface
import NetworkingInterfaceTestUtils
import XCTest

@testable import Networking

final class NetworkResultHandlerTests: XCTestCase {
    private let sut = NetworkRequestResultHandler()
    
    func test_handle_withInput_responseIsNotHTTPURLResponse_shouldReturnNoResponse() throws {
        do {
            _ = try sut.handle(.fixture(), response: ResponseModelDummy.self)
        } catch let error as NetworkRequestError {
            XCTAssertEqual(error, .noResponse)
        }
    }
    
    func test_handle_withInput_responseError401_shouldReturnUnauthorized() throws {
        let expectedResponse = HTTPURLResponseFixture.fixture(statusCode: 401)
        
        do {
            _ = try sut.handle(
                .fixture(response: expectedResponse),
                response: ResponseModelDummy.self
            )
        } catch let error as NetworkRequestError {
            XCTAssertEqual(error, .unauthorized)
        }
    }
    
    func test_handle_withInput_anyResponseError_shouldReturnUnknown() throws {
        let expectedResponse = HTTPURLResponseFixture.fixture(statusCode: 999)
        
        do {
            _ = try sut.handle(
                .fixture(response: expectedResponse),
                response: ResponseModelDummy.self
            )
        } catch let error as NetworkRequestError {
            XCTAssertEqual(error, .unknown)
        }
    }
    
    func test_handle_withInput_with200_badDecode_souldReturnDecodeError() throws {
        let expectedResponse = HTTPURLResponseFixture.fixture(statusCode: 200)
        
        do {
            _ = try sut.handle(
                .fixture(response: expectedResponse),
                response: ResponseModelDummy.self
            )
        } catch let error as NetworkRequestError {
            XCTAssertEqual(error, .decode)
        }
    }
    
    func test_handle_withInput_with200_successDecoding_shouldReturnDecodedResponse() throws {
        let expectedResponse = HTTPURLResponseFixture.fixture(statusCode: 200)
        
        let expectedResult = try sut.handle(
            .fixture(response: expectedResponse, data: correctDataToRespond ?? Data()),
            response: ResponseModelDummy.self
        )
        
        XCTAssertTrue(expectedResult.teste)
    }
    
    private var correctDataToRespond =  """
        {
            "teste": true
        }
        """.data(using: .utf8)
}

fileprivate struct ResponseModelDummy: Codable {
    let teste: Bool
}
