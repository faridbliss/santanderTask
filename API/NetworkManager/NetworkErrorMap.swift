//
//  NetworkErrorMap.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation

enum NetworkAPIError {
    // returned when the api is trying to refresh the token and requesting the data again
    case failedRequestAttempt
    // returned after 3 attempts to fetch the data after refresh the token
    case failedRequestAfterRefreshToken
    case genericError
}

extension NetworkAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {

        case .failedRequestAttempt:
            return nil

        case .failedRequestAfterRefreshToken:
            return nil

        case .genericError:
            return nil
        }
    }

    static func from(error: Error) -> NetworkAPIError {
        return .genericError
    }
}
