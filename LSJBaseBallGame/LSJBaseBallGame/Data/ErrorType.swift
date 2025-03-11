//
//  ErrorType.swift
//  LSJBaseBallGame
//
//  Created by yimkeul on 3/11/25.
//

import Foundation

enum ErrorType {
    case error
    case success
    
    var rawValue: Bool {
        switch self {
        case .error: return true
        case .success: return false
        }
    }
}

