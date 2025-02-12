//
//  APIService.swift
//  SwiftUICombine-RandomUser
//
//  Created by 黃柏嘉 on 2025/02/11.
//

import Foundation
import Combine
import UIKit

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodeError(Error)
    
    var description: String {
        switch self {
        case .invalidURL:     return "無效的URL"
        case .requestFailed:  return "API 請求失敗"
        case .decodeError(let error): return "回傳解析失敗: \(error.localizedDescription)"
        }
    }
}

class APIService {
    
    func fetchData<T: Decodable>(_ response: T.Type, _ endPoint: EndPoint) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: endPoint.url)
        else {
            //無效URL Return 錯誤
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method
        request.httpBody = endPoint.body
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)//最多重試三次
            .tryMap { result in
                //若回傳結果statusCode不在200~299就回傳錯誤
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode)
                else {
                    throw NetworkError.requestFailed
                }
                return result.data
            }
            .decode(type: response, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return NetworkError.decodeError(decodingError)
                }
                return NetworkError.requestFailed
            }
            .eraseToAnyPublisher()
    }
}

class ImageDownloader {
    
    func downloadImage(_ url: String) -> AnyPublisher<UIImage?, NetworkError> {
        guard let url = URL(string: url)
        else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode)
                else {
                    throw NetworkError.requestFailed
                }
                return UIImage(data: result.data)
            })
            .mapError({ _ in
                return NetworkError.requestFailed
            })
            .eraseToAnyPublisher()
    }
}
