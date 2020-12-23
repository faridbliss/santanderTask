//
//  TargetType+DefaultBehavior.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Moya
import UIKit

extension TargetType {

    public var baseURL: URL {
        URL(string: "https://pokeapi.co/api/v2")!
    }

    public var sampleData: Data {
        Data()
    }

    public var headers: [String : String]? {
        defaultHeaders
    }

    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }

    public var defaultHeaders: [String: String]? {
        var _headers: [String: String] = [:]

        _headers[HeaderType.contentType.rawValue] = HeaderValue.applicationJson.rawValue
        _headers[HeaderType.acceptLanguage.rawValue] = Locale.current.languageCode

        let _appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let appVersion = (_appVersion ?? "") + "(\(buildNumber ?? ""))"
        _headers[HeaderType.appVersion.rawValue] = appVersion

        _headers[HeaderType.screenDensity.rawValue] = UIScreen.main.scale.description


        return _headers
    }
}

