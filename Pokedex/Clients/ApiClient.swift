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
    
    // T est le type retourné, R est le type représentant la requête
    func post<T: Decodable, R: Encodable>(apiUrl: String, body: R) async throws -> T {
        guard let url = URL(string: apiUrl) else {
            throw ApiError.invalidURL
        }
        
        // Il faut indiquer la méthode HTTP utilisée et le format des données passées dans le HTTP Body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // On prend l'objet en mémoire et on l'encode pour retourner la chaîne de caractères représentant le JSON
        // AuthRequest(username: "jrioux", password: "bad") ---> { "username": "jrioux", "password": "bad" }
        request.httpBody = try encode(body: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response)
        
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
