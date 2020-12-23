//
//  NetworkManager.swift
//  API
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import RxSwift
import Alamofire
import Moya



class DefaultAlamofireManager: Alamofire.Session {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

public class NetworkManager {
    public static let shared = NetworkManager()
    private let provider: MoyaProvider<MultiTarget>
    private let errorsKeyPath = "errors"

    private init() {
        var plugins: [PluginType] = []
        #if DEBUG
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        plugins = [networkLogger]
        #endif

        provider = MoyaProvider<MultiTarget>(plugins: plugins)
    }

//    var baseURL: String = Bundle.main.infoDictionary?["API_BASE_PATH"]! as! String

    // MARK: - generic function to fetch data

    public func fetchData<Type: Decodable>(fromApi api: TargetType,
                                           decodeFromKeyPath keyPath: String? = nil) -> Single<Type> {

        let request = MultiTarget(api)

        let response = provider.rx.request(request)

        return convert(response, into: Type.self, atKeyPath: keyPath)
    }

    // converts a Single<Response> to a decodable type
    private func convert<Type: Decodable>(_ response: Single<Response>,
                                          into type: Type.Type,
                                          atKeyPath keyPath: String? = nil,
                                          usingDecoder decoder: JSONDecoder = JSONDecoder(),
                                          failsOnEmptyData: Bool = true) -> Single<Type> {

        response.flatMap({ (response) -> Single<Type> in
            do {
                return Single.just(try response.map(type, atKeyPath: keyPath, using: decoder, failsOnEmptyData: failsOnEmptyData))
            } catch {
                if let moyaError = error as? MoyaError {
                    print(moyaError)
                } else {
                    // TODO: log other errors
                }
                return Single.error(GenericError.unknown)
            }
        })
    }

    public func fetchVoidData(fromApi api: TargetType) -> Single<Void> {
        let request = MultiTarget(api)

        let response = provider.rx.request(request)

        return response.flatMap({ (response) -> Single<Void> in

            if let errors = try? JSONDecoder().decode(BaseAPIErrorResponse.self, from: response.data) {
                return Single.error(errors)
            }

            if response.statusCode >= 200 && response.statusCode < 300 {
                return Single.just(())
            }

            return Single.error(GenericError.unknown)
        })
    }
}


struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        if let body = request.httpBody,
           let str = String(data: body, encoding: .utf8) {
            print("request to send: \(str))")
        }
        #endif
        return request
    }
}

