//
//  APIService.swift
//  Lunches
//
//  Created by Андрей Степанов on 29.03.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case urlSessionError(String)
    case serverError(String = "Server error")
    case invalidResponse(String = "Invalid response from server.")
    case decodingError(String = "Error parsing server response.")

    var errorDescription: String? {
        switch self {
        case let .urlSessionError(message),
             let .serverError(message),
             let .invalidResponse(message),
             let .decodingError(message):
            return message
        }
    }
}

protocol Service {
    func makeRequest<T: Codable>(with request: URLRequest, respModel: T.Type, completion: @escaping (T?, APIError?) -> Void)
}

class APIService: Service {
    let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func makeRequest<T: Codable>(
        with request: URLRequest,
        respModel _: T.Type,
        completion: @escaping (T?, APIError?) -> Void
    ) {
        urlSession.dataTask(with: request) { data, resp, error in
            if let error = error {
                completion(nil, .urlSessionError(error.localizedDescription))
                return
            }

            if let resp = resp as? HTTPURLResponse, 500 ..< 600 ~= resp.statusCode {
                guard let data = data else {
                    completion(nil, .serverError())
                    return
                }

                if let errorResponse = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
                    completion(nil, .serverError(errorResponse.message))
                    return
                }

                completion(nil, .invalidResponse())
                return
            }

            guard let data = data else {
                completion(nil, .invalidResponse())
                return
            }

            do {
                if let errorResponse = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
                    completion(nil, .serverError(errorResponse.message))
                    return
                }

                if T.self == Data.self {
                    completion(data as? T, nil)
                    return
                }

                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch {
                print(error)
                completion(nil, .decodingError())
            }
        }.resume()
    }
}
