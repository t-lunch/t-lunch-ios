//
//  ServerErrorResponse.swift
//  Lunches
//
//  Created by Андрей Степанов on 15.05.2025.
//

import Foundation

struct ServerErrorResponse: Decodable {
    let code: Int
    let message: String
    let details: [String]?
}
