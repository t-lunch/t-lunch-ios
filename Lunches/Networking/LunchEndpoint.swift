//
//  LunchEndpoint.swift
//  Lunches
//
//  Created by Андрей Степанов on 16.04.2025.
//

import Foundation

enum LunchEndpoint {
    case registration(url: String = "/v1/signup", request: RegistrationRequest)
    case login(url: String = "/v1/signin", request: LoginRequest)
    case refresh(url: String = "/v1/refresh", token: String)
    case getProfile(url: String = "/v1/profile", userId: Int64)
    case changeProfile(url: String = "/v1/profile", user: User)
    case getLunches(url: String = "/v1/lunches", userId: Int64, offset: Int32, limit: Int32)
    case createLunch(url: String = "/v1/lunch", request: CreateLunchRequest)
    case joinLunch(url: String = "/v1/lunch", lunchId: Int64, userId: Int64)
    case leaveLunch(url: String = "/v1/lunch", lunchId: Int64, userId: Int64)
    case getDetailLunch(url: String = "/v1/lunch", lunchId: Int64)
    case getLunchHistory(url: String = "/v1/lunch", userId: Int64)
    case rateLunch(url: String = "/v1/lunch", userId: Int64, lunchId: Int64, isLiked: Bool)

    var request: URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.httpBody = httpBody
        request.addValues(for: self)
        return request
    }

    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = path
        components.queryItems = queryItems
        return components.url
    }

    private var path: String {
        switch self {
        case let .registration(url, _):
            return url
        case let .login(url, _):
            return url
        case let .refresh(url, _):
            return url
        case let .getProfile(url, userId):
            return "\(url)/\(userId)"
        case let .changeProfile(url, user):
            return "\(url)/\(user.userId)"
        case let .getLunches(url, _, _, _):
            return url
        case let .createLunch(url, _):
            return url
        case let .joinLunch(url, lunchId, _):
            return "\(url)/\(lunchId)/join"
        case let .leaveLunch(url, lunchId, _):
            return "\(url)/\(lunchId)/leave"
        case let .getDetailLunch(url, lunchId):
            return "\(url)/\(lunchId)"
        case let .getLunchHistory(url, userId):
            return "\(url)/\(userId)/history"
        case let .rateLunch(url, userId, lunchId, _):
            return "\(url)/\(userId)/history/\(lunchId)"
        }
    }

    private var queryItems: [URLQueryItem] {
        switch self {
        case let .getLunches(_, _, offset, limit):
            return [
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
        default:
            return []
        }
    }

    private var httpMethod: String {
        switch self {
        case .getProfile,
             .getLunches,
             .getDetailLunch,
             .getLunchHistory:
            return HTTP.Method.get.rawValue
        case .registration,
             .login,
             .refresh,
             .createLunch:
            return HTTP.Method.post.rawValue
        case .changeProfile,
             .joinLunch,
             .leaveLunch,
             .rateLunch:
            return HTTP.Method.patch.rawValue
        }
    }

    private var httpBody: Data? {
        switch self {
        case let .registration(_, request):
            return try? JSONEncoder().encode(request)
        case let .login(_, request):
            return try? JSONEncoder().encode(request)
        case let .refresh(_, token):
            return try? JSONEncoder().encode(["refresh_token": token])
        case let .changeProfile(_, user):
            return try? JSONEncoder().encode(user)
        case let .createLunch(_, request):
            return try? JSONEncoder().encode(request)
        case let .joinLunch(_, _, userId),
             let .leaveLunch(_, _, userId):
            return try? JSONEncoder().encode(["user_id": userId])
        case let .rateLunch(_, _, _, isLiked):
            return try? JSONEncoder().encode(["is_liked": isLiked])
        default:
            return nil
        }
    }
}

extension URLRequest {
    mutating func addValues(for endpoint: LunchEndpoint) {
        switch endpoint {
        default:
            setValue("*/*", forHTTPHeaderField: "Accept")
            setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
            setValue("keep-alive", forHTTPHeaderField: "Connection")
            setValue("YourApp/1.0", forHTTPHeaderField: "User-Agent")
            setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}

