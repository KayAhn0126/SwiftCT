# 9935 문자열 폭발
- 스택
- 구현

## 🍎 지문 해석
- 문자열의 길이가 최대 100만이다.
- 폭발 문자열은 같은 문자를 두 개 이상 포함하지 않는다.

## 🍎 문제 접근
- replacingOccurrences로 치환해서 풀자 했는데 44%에서 시간초과.
- 최악의 경우를 생각하지 않았었다. -> 100만이고 CCCCCCCCCCCCCCCCCCCCC444444444444444 이런식이라면 대략 적으로 100만개에서 2개씩 줄어들면서 * 50만번 수행 -> 시간초과

## 🍎 문제 풀이 및 전체 코드
### 📖 시간초과 코드
```swift
import Foundation

var myString = readLine()!
var explosiveStr = readLine()!

while myString.contains(explosiveStr) {
   myString = myString.replacingOccurrences(of: explosiveStr, with: "")
}
if myString.isEmpty {
   print("FRULA")
} else {
   print(myString)
}
```
### 📖 스택을 활용한 코드
- 문자열 입력 받고, 한글자씩 넣으면서 마지막글자가 나오면 폭발문자열의 길이만큼 끝에서 부터 체크, 맞다면 그 길이만큼 pop
    - 문자열 길이만큼 체크할때 문자열이 충분히 긴지 체크하기!
```swift
var myString = readLine()!.map { Character(String($0)) }
var explosiveStr = readLine()!
let lastCharIndex = explosiveStr.index(before: explosiveStr.endIndex)
let lastChar = explosiveStr[lastCharIndex]
let explosiveStrLength = explosiveStr.count

var result = ""
var count = 0
for i in myString {
    result += String(i)
    count += 1
    if i == lastChar {
        if count >= explosiveStrLength {
            let fromIndex = result.index(result.endIndex, offsetBy: -explosiveStrLength)
            let endIndex = result.index(before: result.endIndex)
            if result[fromIndex...endIndex] == explosiveStr {
                result.removeLast(explosiveStrLength)
                count -= explosiveStrLength
            }
        }
    }
}
if result.isEmpty {
    print("FRULA")
} else {
    print(result)
}
```

## 🍎 주의할 점
- 시간복잡도 + 최악의 경우를 구현하기전 미리 생각하자!
