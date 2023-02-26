public enum NetworkRequestError: Error {
    case decode
    case invalidUrl
    case noResponse
    case unknown
    case unauthorized
    
    var message: String {
        switch self {
        case .decode:
            return "Decode error"
        case .invalidUrl:
            return "URL passed is invalid"
        case .noResponse:
            return "The server could not respond"
        case .unauthorized:
            return "Unauthorized"
        case .unknown:
            return "Unknown error"
        }
    }
}
