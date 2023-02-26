import NetworkingInterfaceTestUtils
import XCTest

@testable import Networking

final class URLRequestFactoryTests: XCTestCase {
    private let sut = URLFactory()

    func test_make_withRequest_whenURLIsNotValid_shouldReturnNil() {
        let expectedURLRequest = sut.make(from: NetworkRequestFixture())
        
        XCTAssertNil(expectedURLRequest)
    }

    func test_make_withRequest_whenURLIsValid_shouldReturnCorrectURLRequest() {
        let networkRequest = NetworkRequestFixture(
            baseUrl: "teste.com",
            path: "/path",
            method: .get
        )
        
        let expectedURL = sut.make(from: networkRequest)
    
        XCTAssertEqual(expectedURL?.url?.description, "https://teste.com/path?")
    }
    
    func test_make_withValidURL_ifContainsHeader_shouldReturnCorrectURLRequest() {
        let networkRequest = NetworkRequestFixture(
            baseUrl: "teste.com",
            path: "/path",
            method: .get,
            header: ["test header": "value"]
        )
        
        let expectedURLRequest = sut.make(from: networkRequest)
    
        XCTAssertEqual(expectedURLRequest?.allHTTPHeaderFields?["test header"], "value")
        XCTAssertEqual(expectedURLRequest?.description, "https://teste.com/path?")
    }
    
    func test_make_withValidURL_ifContainsBody_shouldReturnCorrectURLRequest() {
        let networkRequest = NetworkRequestFixture(
            baseUrl: "teste.com",
            path: "/path",
            method: .get,
            body: ["body_key": "value"]
        )
        
        let expectedURLRequest = sut.make(from: networkRequest)
    
        XCTAssertEqual(expectedURLRequest?.description, "https://teste.com/path?body_key=value")
    }
}
