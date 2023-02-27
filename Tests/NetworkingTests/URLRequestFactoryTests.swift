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
    
    func test_make_withValidURL_ifContainsQueryParameter_shouldReturnCorrectURLRequest() {
        let networkRequest = NetworkRequestFixture(
            baseUrl: "teste.com",
            path: "/path",
            method: .get,
            queryParameters: ["query_key": "value"]
        )
        
        let expectedURLRequest = sut.make(from: networkRequest)
    
        XCTAssertEqual(expectedURLRequest?.description, "https://teste.com/path?query_key=value")
    }

    func test_make_withValidURL_ifContainsBody_shouldReturnCorrectURLHttpBody() {
        let networkRequest = NetworkRequestFixture(
            baseUrl: "teste.com",
            path: "/path",
            method: .get,
            body: DummyBodyObject()
        )

        let expectedURLRequest = sut.make(from: networkRequest)

        XCTAssertEqual(expectedURLRequest?.description, "https://teste.com/path?")
        XCTAssertNotNil(expectedURLRequest?.httpBody)
    }
}

private final class DummyBodyObject: Encodable {
    var dummy: String = "dummy_body"
}
