//
//  BaseballGame.swift
//  LSJBaseBallGame
//
//  Created by yimkeul on 3/10/25.
//

import Foundation

class BaseballGame {

    let maxLength: Int
    var isAnswer: Bool
    var isQuit: Bool
    var answer: [String]
    let recordManager: RecordManager

    init() {
        maxLength = 3
        isAnswer = false
        answer = []
        isQuit = false
        recordManager = RecordManager.shared
    }

    func start() {
        while !isQuit {
            // Lv4: 프로그램 시작시 안내문구 출력
            print(MessageConstants.welcomMessage)
            let input = Int(readLine()!)!
            switch input {
            case NumberType.gameStart.rawValue:
                gameStart()
            case NumberType.history.rawValue:
                showHistory()
            case NumberType.quit.rawValue:
                quit()
            default:
                print(MessageConstants.incorrectNumberMessage)
            }
        }

    }

    private func gameStart() {
        answer = makeAnser()
        print(MessageConstants.startMessage)
        var tryCount = 0
        isAnswer = false
        while !isAnswer {
            print(MessageConstants.inputNumberMessage)
            let input = readLine()!.map { String($0) }

            if checkError(for: input) {
                tryCount += 1
                print("\(checkHint(for: input, to: tryCount))\n")
            } else {
                print(MessageConstants.incorrectInputMessage)
            }
        }
    }

    // Lv5: 기록보기
    private func showHistory() {
        recordManager.showHistory()
    }

    // Lv6: 종료하기
    private func quit() {
        isQuit = true
        print(MessageConstants.finishGameMessage)
    }

    // Lv1: 1에서 9까지의 서로 다른 임의의 수 3자리 구하기
    // Lv3: 0에서 9까지로 변경, 맨 앞자리, 중복 제외
    private func makeAnser() -> [String] {

        var numbers = [Int]()

        while numbers.count < maxLength {
            // 1에서 9까지 랜덤 수 추출
            let randomNumber = numbers.isEmpty ? Int.random(in: 1...9) : Int.random(in: 0...9)

            // 중복인 경우 추가 안함
            if !numbers.contains(randomNumber) {
                numbers.append(randomNumber)
            }
        }
        return numbers.map { String($0) }
    }

    // Lv2: 올바르지 않은 입력값 체크
    func checkError(for input: [String]) -> Bool {

        // 세자리 숫자가 아닌 경우
        let str = input.joined()
        if !str.allSatisfy({ $0.isNumber }) {
            return false
        }

        // 숫자가 중복되어 있는 경우
        let arrayToSet: Set<Int> = Set(input.map { Int($0)! })
        if arrayToSet.count != maxLength {
            return false
        }
        // 0이 사용된 경우
        if input.contains("0") {
            return false
        }
        return true
    }

    // Lv2: 정답 확인을 위한 힌트
    func checkHint(for input: [String], to count: Int) -> String {

        var hint = Hint()
        var result = ""

        for i in 0 ..< maxLength {
            // 스트라이크, 볼 판별기
            if answer.contains(input[i]) {
                if input[i] == answer[i] {
                    hint.strikes += 1
                } else {
                    hint.balls += 1
                }
            }
        }

        if hint.strikes == 3 {
            isAnswer = true
            recordManager.saveCount(count)
            return MessageConstants.correctAnswerMessage
        }

        if hint.strikes == 0 && hint.balls == 0 {
            return MessageConstants.nothingMessage
        } else {
            result += hint.strikes != 0 ? "\(hint.strikes)스트라이크 " : ""
            result += hint.balls != 0 ? "\(hint.balls)볼" : ""
            return result
        }
    }
}
