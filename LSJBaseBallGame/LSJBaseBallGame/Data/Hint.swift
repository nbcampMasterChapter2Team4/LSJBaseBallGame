//
//  Hint.swift
//  LSJBaseBallGame
//
//  Created by yimkeul on 3/10/25.
//

import Foundation

struct Hint {
    var strikeCount: Int
    var ballCount: Int

    init() {
        self.strikeCount = .zero
        self.ballCount = .zero
    }
    
    var isThreeStrike: Bool {
        return strikeCount == 3
    }
    
    var isZeroCount: Bool {
        return strikeCount == .zero && ballCount == .zero
    }
}
