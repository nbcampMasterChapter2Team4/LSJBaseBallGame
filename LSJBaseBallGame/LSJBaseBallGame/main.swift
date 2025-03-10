//
//  main.swift
//  LSJBaseBallGame
//
//  Created by yimkeul on 3/10/25.
//

import Foundation

let game = BaseballGame.shared

print(MessageConstants.startMessage)

while !game.isAnswer {
    print(MessageConstants.inputNumberMessage)
    let input = readLine()!.map { String($0) }

    if game.checkError(for: input) {
        print("\(game.checkHint(for: input))\n")
    } else {
        print(MessageConstants.incorrectInputMessage)
    }
}


