//
//  StringError.swift
//  MyCommandPlugin
//
//  Created by Hosung.Kim on 2026.06.26 10:39.
//

import protocol Foundation.CustomNSError
import var Foundation.NSLocalizedDescriptionKey

/// Represents a string error.
public struct StringError: Equatable, Codable, CustomStringConvertible, Error {

    /// The description of the error.
    public let description: String

    /// Create an instance of StringError.
    public init(_ description: String) {
        self.description = description
    }
}

extension StringError: CustomNSError {
    public var errorUserInfo: [String : Any] {
        return [NSLocalizedDescriptionKey: self.description]
    }
}
