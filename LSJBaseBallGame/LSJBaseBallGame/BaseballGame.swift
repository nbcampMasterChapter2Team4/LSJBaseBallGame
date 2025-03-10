//
//  BaseballGame.swift
//  LSJBaseBallGame
//
//  Created by yimkeul on 3/10/25.
//

import Foundation

class BaseballGame {
    
    func start() {}
    
    // Lv1: 1에서 9까지의 서로 다른 임의의 수 3자리 구하기
    func makeAnser() -> [Int] {
        
        var numbers = [Int]()
        
        while numbers.count < 3 {
            // 1에서 9까지 랜덤 수 추출
            let randomNumber = Int.random(in: 1...9)
            
            // 중복인 경우 추가 안함
            if !numbers.contains(randomNumber) {
                numbers.append(randomNumber)
            }
        }
        
        return numbers
    }
}
