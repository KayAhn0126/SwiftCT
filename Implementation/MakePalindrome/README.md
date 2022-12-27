# 1213 팰린드롬 만들기

## 🍎 키워드
- 안되는 경우 먼저 생각하기
- 카운팅 배열
- forEach문 역순으로 접근하기

## 🍎 문제 풀이
- 누가봐도 카운팅 배열로 문제를 풀어야 하므로 입력으로 주어지는 문자열을 카운팅 배열로 처리했다.
- 먼저 팰린드롬이 안되는 경우를 한번 써봤다.
    - AA (A 2)
    - ABA (A 2 B 1)
    - ABBA (A 2 B 2)
    - ABCBA (A 2 B 2 C 1)
    - ABCDCBA (A 2 B 2 C 2 D 1)
    - ABACABA (A 4 B 2 C 1)
    - ADDDA (A 2 D 3)
    - ABABA (A 3 B 2)
    - ABAD (A 2 B 1 D 1) -> 유일하게 홀수가 2개!
- 이제 카운팅 배열 내 홀수가 2개 이상이면 팰린드롬이 될 수 없다는걸 알았다.
- 그럼 카운팅 배열 내 홀수가 없을수도 있고 있다면 1개라는 뜻이다.
- 예를 들어 A가 2개 B가 1개인 상황이라하면
    - B를 centerChar라는 변수에 담는다.
    - B를 하나 썼으니 현재 값에서 -1을 해준다.
    - 다른 작업이 모두 끝나면 해당 문자열의 가운데에 쏙 넣어준다.
    - AA -> ABA 
- 그럼 A가 2개 B가 3개인 상황이라면 어떻게 할까?
    - 마찬가지로 centerChar라는 변수에 담아두고,
    - B를 하나 썼으니 현재 값에서 -1을 해준다.
    - forEach문을 사용해 현재의 알파벳을 result 변수에 앞,뒤로 붙여준다.
- 전체 코드
```swift
import Foundation

var userInput = readLine()!
var countingArr = [Int](repeating: 0, count: 26)
var resultStr = ""
var centerChar = ""
var checkCount = 0
userInput.enumerated().forEach {
    countingArr[Int($0.element.asciiValue!) - 65] += 1
}

countingArr.enumerated().reversed().forEach {
    if $0.element % 2 == 1 {
        checkCount += 1
        centerChar = String(UnicodeScalar($0.offset + 65)!)
        countingArr[$0.offset] -= 1
    }
    if $0.element > 0 {
        for _ in stride(from: 0, to: $0.element/2, by: 1) {
            let currentChar = String(UnicodeScalar($0.offset + 65)!)
            resultStr =  currentChar + resultStr
            resultStr += currentChar
        }
    }
}

if checkCount >= 2 {
    print("I'm Sorry Hansoo")
} else {
    let middleIndex = resultStr.count / 2
    if !centerChar.isEmpty {
        resultStr.insert(Character(centerChar), at: resultStr.index(resultStr.startIndex, offsetBy: middleIndex))
    }
    print(resultStr)
}
```

## 🍎 신경써야 할 점.
- 총 몇개의 홀수가 있는지 카운트 할 때,
    - checkCount == 2가 아니라, checkCount >= 2로 해줘야한다.
        - 반례 : ABCD
- 문제에 "정답이 여러개일 경우, 사전순으로 앞서는 것을 출력한다."
    - 즉, 앞뒤로 문자를 넣어주는 행동을 Z부터 A로 오면서 하도록 반복문을 역순으로 돌린다.
    - 예를들어, A가 4개, B가 1개, Z가 2개인 상황이면 아래와 같이 진행된다.
        - ZZ
        - AZZA
        - AAZZAA
        - AAZBZAA
    - 또 하나 예제!
    - 예를들어, A가 3개 B가 2개 Z가 2개인 상황은 아래와 같이 진행된다.
        - ZZ
        - BZZB
        - A 저장 (중간 글자)
        - ABZZBA
        - ABZAZBA (저장했던 중간 글자를 가운데에 삽입)
