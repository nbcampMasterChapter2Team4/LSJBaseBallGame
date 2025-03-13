# 숫자 야구 게임 (Number Baseball Game)
내일배움캠프 iOS 마스터 6기 2주차

## 프로젝트 소개
숫자 야구 게임은 두 명이 즐길 수 있는 추리 게임으로, 상대방이 설정한 3자리 숫자를 맞히는 것이 목표입니다. 각 자리의 숫자와 위치가 모두 맞으면 '스트라이크', 숫자만 맞고 위치가 다르면 '볼'로 판정됩니다. 올바른 힌트를 바탕으로 정답을 맞혀야 합니다.

## 기능 설명
### 1. 필수 기능
- **랜덤 정답 생성**: 1~9까지의 서로 다른 숫자로 이루어진 3자리 숫자를 생성합니다.
- **사용자 입력 처리**: 세 자리의 숫자를 입력받아 유효성을 검사합니다.
- **힌트 제공**: 입력한 숫자에 대해 '스트라이크'와 '볼'의 개수를 알려줍니다.
- **정답 체크 및 게임 종료**: 사용자가 정답을 맞히면 게임이 종료됩니다.

### 2. 추가 구현 기능
- **정답 0 추가**: 정답이 되는 숫자를 0에서 9까지로 변경합니다.
  - 맨 앞자리에 0이 오는 것은 불가능합니다. 
- **메뉴 제공**: 게임 시작 시 다음 옵션을 제공합니다.
  - 1. 게임 시작하기
  - 2. 게임 기록 보기
  - 3. 종료하기
- **게임 기록 저장**: 게임마다 시도 횟수를 저장하고, `게임 기록 보기`를 통해 확인할 수 있습니다.
- **입력값 검증 강화**: 숫자가 아닌 입력, 중복된 숫자, 잘못된 숫자 길이에 대한 예외 처리를 구현했습니다.
- **게임 종료 기능**: `3`을 입력하면 게임이 종료되고, 기록이 초기화됩니다.


## 코드 구조
```
📂 숫자야구게임
├── 📂 Contents
│   ├── MessageContents.swift  # 메시지 문자열을 관리
├── 📂 Data
│   ├── Hint.swift            # 힌트(스트라이크, 볼) 데이터 구조체
│   ├── NumberType.swift      # 사용자 입력 옵션 (1,2,3) 관리
│   ├── ErrorType.swift       # 입력값 검증 결과 관리
├── BaseballGame.swift       # 게임의 주요 로직을 담당하는 클래스
├── RecordManager.swift      # 게임 기록을 저장하고 출력하는 클래스
└── main.swift               # 프로그램 실행을 위한 진입점
```

## 구현 방식
### 1. `BaseballGame` 클래스
- 게임의 핵심 로직을 담당하며, 정답 생성(`makeAnswer`), 입력 검증(`checkError`), 힌트 제공(`checkHint`) 등의 기능을 포함합니다.
- `start()` 메서드를 통해 게임 메뉴를 표시하고, 사용자의 입력을 받아 동작합니다.

### 2. `RecordManager` 클래스
- 사용자의 게임 기록(시도 횟수)을 저장하고, 이를 출력하는 기능을 수행합니다.
- 싱글톤 패턴(`shared`)을 사용하여 전역적으로 접근할 수 있도록 구현되었습니다.

BaseballGame와 RecordManager를 class로 구현한 이유

1. BaseballGame

BaseballGame은 게임의 상태를 관리하는 객체로, 내부에서 정답 숫자와 게임 진행 상태(isAnswer, isQuit)를 유지해야 합니다.

값 타입(struct)으로 구현할 경우, 메서드 호출 시 값이 복사되어 게임 상태를 유지하기 어려움


2. RecordManager

RecordManager는 게임 기록을 저장하는 싱글톤 패턴으로 구현되었습니다.

tryCountHistory 배열을 저장하고 게임 간에 공유해야 하므로 참조 타입인 class 사용

값 타입(struct)으로 구현할 경우, 새로운 인스턴스가 생성될 때마다 기록이 초기화될 위험

### 3. 데이터 구조체 및 열거형
- `Hint`: 스트라이크와 볼의 개수를 저장하는 구조체입니다.
- `NumberType`: 사용자 입력 옵션(1, 2, 3)을 정의한 열거형입니다.
- `ErrorType`: 입력값 검증 결과(성공/실패)를 관리하는 열거형입니다.




## 트러블 슈팅
### `readLine()` 입력 처리 개선

### 문제 상황
초기 코드에서는 사용자 입력을 받을 때 `readLine()!`을 사용하여 강제 언래핑을 했습니다.

```swift
let input = readLine()!
```

**문제점**

- **입력값이 `nil`일 경우 크래시 발생**
- **빈 문자열 입력 시 예외 처리 부족**
- **공백 포함 입력 시 원치 않는 동작 가능**

### 해결 방법
입력값을 안전하게 처리하기 위해 `compactMap`을 사용하여 문자열을 배열로 변환하는 방식을 도입했습니다.

```swift
if let line = readLine() {
    let input = line.compactMap { String($0) }
}
```

- **`readLine()`이 `nil`일 경우 예외를 방지** 할 수 있습니다.
- **공백이 포함된 입력도 안전하게 변환**할 수 있습니다.
- **각 문자 단위로 변환하여 배열로 활용할 수 있어 숫자 비교 등의 로직을 쉽게 처리**할 수 있습니다.

### 적용 결과
- **입력값을 더 안전하게 다룰 수 있게 되었고, 크래시 가능성이 사라짐**
- **잘못된 입력을 감지하고 예외 처리가 가능해짐**
- **입력값을 쉽게 가공할 수 있어 코드 유지보수가 용이해짐**


## 코드 리뷰 반영 경험  

### 개선 전 코드  
초기에는 `isThreeStrike`와 `isZeroCount`를 `BaseballGame` 클래스 내부에서 별도로 구현하고 있었습니다.  

```swift
class BaseballGame {
    // 기타 코드 생략
      if hint.strikeCount == 3 {
            isAnswer = true
            recordManager.saveCount(count)
            return MessageContents.correctAnswerMessage
        }

        if hint.strikeCount == 0 && hint.ballCount == 0 {
            return MessageContents.nothingMessage
        }
}
```

이 방식도 동작은 하지만, `Hint` 구조체에서 관리하는 데이터(`strikeCount`, `ballCount`)의 상태를 확인하는 로직이 `BaseballGame` 내부에 존재하는 것이 아쉬운 점이었습니다.  

### 코드 리뷰 피드백  
팀원의 코드 리뷰를 통해, **`Hint` 내부에서 관련 로직을 처리하는 것이 응집도를 높이고, 코드의 가독성을 향상시킬 수 있다**는 피드백을 받았습니다.  

### 개선 후 코드  
이에 따라 `isThreeStrike`와 `isZeroCount`를 `Hint` 구조체 내부에 포함시켰습니다.  

```swift
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
```

### 적용 결과 및 느낀 점  
- `Hint`가 **스스로 자신의 상태를 판단할 수 있도록 책임이 분리**되었고, 응집도가 높아졌습니다.  
- `BaseballGame` 클래스가 **불필요한 상태 검사 로직을 가지지 않게 되어 코드가 더 깔끔해짐**  
- **객체 지향적인 설계 원칙을 자연스럽게 반영할 수 있었음**


## 예외 처리
### 1. 게임 기록 없을때 호출한 경우
```swift
class RecordManger { 
...
        // MARK: 게임 기록 없을때 호출한 경우
        if tryCountHistory.isEmpty {
            print(MessageContents.emptyHistoryMessage)
        }
```

### 2. 이전에 실패한 입력인 경우
```swift
class BaseballGame {
...
    private var previousTryAnser: Set<String>
...
private func gameStart() {
...
                // MARK: 이전에 입력한 기록이 있는 경우 추가 안내문 출력
                if previousTryAnser.contains(line) {
                    print(MessageContents.previousInputMessage)
                }

                if checkError(for: input) == .error {
                    print(MessageContents.incorrectInputMessage)
                } else {
                    tryCount += 1
                    previousTryAnser.insert(line)
                    print("\(checkHint(for: input, to: tryCount))\n")
                }
}


``` 
