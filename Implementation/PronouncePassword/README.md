# 4659 비밀번호 발음하기

## 🍎 키워드
- 설계 및 구현
- 특정 상황이 될 때까지 입력 받기

## 🍎 문제 풀이
### 📖 문제의 지문에서 요구하는 사항 3가지
- 모음(a,e,i,o,u)중 반드시 하나를 포함
- 모음이 3개 혹은 자음이 3개 연속으로 오면 안된다.
- 같은 글자가 연속적으로 두번 오면 안되지만 ee와 oo는 허용.

### 📖 변수 및 함수 설명
- isVowel() -> Bool
    - 매개변수로 들어온 문자가 모음인지 확인 후 반환
- vowelCounter
    - 연속적으로 모음이 3개 나오는지 확인하기 위한 카운터
- consonantCounter
    - 연속적으로 자음이 3개 나오는지 확인하기 위한 카운터
- totalVowelCounter
    - 모음이 총 몇개 나오는지 확인하는 카운터
- previousChar
    - 이전 글자가 무엇이였는지 저장하는 변수

## 🍎 전체 코드
```swift
import Foundation

while let password = readLine() {
    if password == "end" { // end를 입력 받을때까지 실행
        break
    }
    if checkPassword(password) { // flag의 값에 따라 분기 출력
        print("<\(password)> is acceptable.")
    } else {
        print("<\(password)> is not acceptable.")
    }
}

func isVowel(_ letter: Character) -> Bool {
    return (letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u")
}

func checkPassword(_ password: String) -> Bool {
    var vowelCounter = 0
    var consonantCounter = 0
    var totalVowelCounter = 0
    var previousChar = ""
    var flag = true
    password.enumerated().forEach {
        if previousChar == String($0.element) { // 이전 문자와 현재 문자가 같다면
            let checkString = previousChar + String($0.element) // 이전 문자와 현재 문자를 더하고
            if !(checkString == "ee" || checkString == "oo") { // 더한 값이 ee 또는 oo가 아니라면 (3번 규칙 위반)
                flag = false    // 불량 패스워드 플래그!
            }
        } else { // 이전 문자와 현재 문자가 다르다면 
            previousChar = String($0.element) // 현재 문자를 이전 문자 변수에 대입
        }
        if isVowel($0.element) { // 모음이라면
            vowelCounter += 1 // 연속적으로 나오는 모음을 세기위한 카운터를 1 올려준다
            consonantCounter = 0 // 자음은 0으로 세팅
            totalVowelCounter += 1 // 토탈 모음은 1 추가
        } else {
            consonantCounter += 1
            vowelCounter = 0
        }
        if vowelCounter == 3 || consonantCounter == 3 { // 모음이나 자음이 3개 연속으로 온다면 (2번 규칙 위반)
            flag = false // 불량 패스워드 플래그!
        }
    }
    if totalVowelCounter == 0 { // 모음이 하나도 없다면, (1번 규칙 위반)
        flag = false
    }
    return flag
}
```
