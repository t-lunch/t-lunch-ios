//
//  String+Extensions.swift
//  Lunches
//
//  Created by Андрей Степанов on 28.04.2025.
//

import Foundation

extension String: @retroactive Identifiable {
    public var id: String { self }
}
