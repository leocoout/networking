import NetworkingInterface
import Foundation

public extension NetworkRequestResultHandlerInput {
    static func fixture(
        response: URLResponse = URLResponse(),
        data: Data = Data()
    ) -> Self {
        .init(
            response: response,
            data: data
        )
    }
}
