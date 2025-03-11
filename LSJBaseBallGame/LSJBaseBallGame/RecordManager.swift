//
//  RecordManager.swift
//  LSJBaseBallGame
//
//  Created by yimkeul on 3/10/25.
//

import Foundation

class RecordManager {
    static let shared = RecordManager()
    
    var tryCountHistory: [Int]
    
    private init() {
        tryCountHistory = []
    }
    
    // Lv5: 경기 횟수 기록하기
    func saveCount(_ tryCount: Int) {
        self.tryCountHistory.append(tryCount)
    }
    
    // Lv5: 경기 횟수 출력하기
    func showHistory() {
        print(MessageConstants.showHistoryMessage)
        
        // MARK: 게임 기록 없을때 호출한 경우
        if tryCountHistory.isEmpty {
            print(MessageConstants.emtpyHistoryMessage)
        } else {
            for (i,history) in tryCountHistory.enumerated() {
                print("\(i+1)번째 게임 : 시도 횟수 - \(history)")
            }
        }
        print(MessageConstants.lineSpace)
    }
}
