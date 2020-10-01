//
//  NetworkAPI.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//

import Foundation
import Alamofire

class NetworkAPI {
    static func videoList(completion: @escaping (Result<VideoList, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "videos.json", parameters: nil) { (result) in
            switch result {
            case let .success(data):
                let result: Result<VideoList, Error> = parseData(data)
                completion(result)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let docodeData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkAPI Error",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "无法解析数据"])
            return .failure(error)
        }
        return .success(docodeData)
    }
}
