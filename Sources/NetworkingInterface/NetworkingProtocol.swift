public protocol NetworkingProtocol {
    func request<T: Codable>(
        _ request: NetworkRequest,
        responseModel: T.Type
    ) async throws -> T
}
