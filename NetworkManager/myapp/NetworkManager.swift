//
//  NetworkManager.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//

import Foundation
import Alamofire

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void

private let NetworkAPIBaseUrl = "https://mydev-71bc0.web.app/"

class NetworkManager {
    static let shared = NetworkManager()
    
    var commonHeaders: HTTPHeaders { ["koma": "123", "token": "'#UIsaOSzxAD77fy7z8hcjz8xW8faJ"] }
    
    // 单例模式，限制外部再次实例化
    private init() {}
    
    // 这个标记可以让编译器忽略返回值未使用的警告
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseUrl + path,
                   parameters: parameters,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 12 })
            .responseData { (response) in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(self.handleError(error))
                }
            }
    }
    
    @discardableResult
    func requestPost(path: String, parameters: Parameters, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(NetworkAPIBaseUrl + path,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 12 })
            .responseData { (response) in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(self.handleError(error))
                }
            }
    }
    
    private func handleError(_ error: AFError) -> NetworkRequestResult {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if  code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                var userInfo = nserror.userInfo
                //userInfo[NSLocalizedDescriptionKey] = "去！网络连接出现问题。"
                userInfo[NSLocalizedDescriptionKey] = "My God!Network is error."
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
}
