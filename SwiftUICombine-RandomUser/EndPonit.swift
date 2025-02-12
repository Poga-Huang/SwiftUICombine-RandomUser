//
//  APIEndPonit.swift
//  SwiftUICombine-RandomUser
//
//  Created by 黃柏嘉 on 2025/02/11.
//

import Foundation

enum EndPoint {
    
    case RandomUser
    
    var url: String {
        switch self {
        case .RandomUser: return "https://randomuser.me"
        }
    }
    
    var method: String {
        switch self {
        case .RandomUser: return "GET"
        }
    }
}
