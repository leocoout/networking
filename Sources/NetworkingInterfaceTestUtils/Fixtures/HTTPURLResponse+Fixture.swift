import Foundation

public class HTTPURLResponseFixture {
    public static func fixture(
        url: URL = .forcedURL(),
        statusCode: Int = 0,
        httpVersion: String? = nil,
        headerFields: [String: String]? = nil
    ) -> HTTPURLResponse {
        .init(
            url: url,
            statusCode: statusCode,
            httpVersion: httpVersion,
            headerFields: headerFields
        ) ?? HTTPURLResponse()
    }
}
