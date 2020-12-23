//
//  BaseAPIError.swift
//  API
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
public struct BaseAPIErrorResponse: Codable, Error {
    public let errors: [BaseResponseError]
}

public struct BaseResponseError: Codable, LocalizedError {
    public var status: String
    public var code: String
    public var title: String
    public var detail: String

    public var errorDescription: String? {
        detail
    }
}
