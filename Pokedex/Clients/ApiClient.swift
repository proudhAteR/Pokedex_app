import Foundation

// Exemple de gestion des erreurs en passant en paramètre l'error, etc.
enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case encodingError(Error)
    case decodingError(Error)
}

class ApiClient {
    static let shared = ApiClient()
    
    private init() {
        // Prevent external creation of this class
    }
    
    // T est le type retourné
    func get<T: Decodable>(apiUrl: String) async throws -> T {
        guard let url = URL(string: apiUrl) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response)
        
        return try decode(data: data)
    }
    
	func post<T: Decodable, R: Encodable>(apiUrl: String, body: R, defaultResponse: T) async throws -> T {
		guard let url = URL(string: apiUrl) else {
			throw ApiError.invalidURL
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		// Encode the request body
		request.httpBody = try encode(body: body)
		
		let (data, response) = try await URLSession.shared.data(for: request)
		
		try validate(response: response)
		
		// If the response is empty, return a default value instead
		if data.isEmpty {
			return defaultResponse
		}
		
		// Decode the response data
		return try decode(data: data)
	}

    
    
    
    
    
    
    private func validate(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
    }
    
    // Versions avec Génériques pour pouvoir passer n'importe quel type
    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw ApiError.decodingError(error)
        }
    }
    
    private func encode<T: Encodable>(body: T) throws -> Data {
        do {
            return try JSONEncoder().encode(body)
        } catch {
            throw ApiError.encodingError(error)
        }
    }
}
