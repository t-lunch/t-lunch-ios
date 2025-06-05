//
//  URLRequest+Extensions.swift
//  Lunches
//
//  Created by Андрей Степанов on 20.05.2025.
//

import Foundation

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

extension URLRequest {
    mutating func authorize(with token: String) {
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}
