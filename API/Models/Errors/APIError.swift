//
//  APIError.swift
//  API
//
//  Created by Farid Ullah on 17/12/2020.
//
import Foundation
import Resources

public enum APIError: String, Error {
    case unknown
}

public enum GenericError: LocalizedError {
    case timeout
    case unknown
    case withMessage(message: String)

    public var errorDescription: String? {
        switch self {

        case .timeout:
            // TODO: Replace with localizable string
            return R.string.base.timeoutErrorOccur()

        case .unknown:
            // TODO: Replace with localizable string
            return R.string.base.unkownErrorOccur()

        case .withMessage(let msg):
            return msg
        }
    }

}
