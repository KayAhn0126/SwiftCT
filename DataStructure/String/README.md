# String

## 🍎 String 정리

### 📖 연결(joined)
```swift
let str = ["str", "ing", "!"]
var string = str.joined() // "string!"
string = str.joined(separator: " ") // str ing !
string = str.joined(separator: ", ") // str, ing, !
string = str.joined(separator: "a") // strainga!
```

### 📖 알파벳 대소문자 변환
```swift
var str = "string"
str = str.capitalized  // 첫번째만 대문자로 변경 "Abcdef" import Foundation 필수
str = str.uppercased() // 전체 대문자로 변경 "ABCDEF"
str = str.lowercased() // 전체 소문자로 변경 "abcdef
```

### 📖 문자열 치환
- import Foundation 필수
```swift
import Foundation
var str = "abcd"
var str2 = str.replacingOccurrences(of: "a", with: "b")

print(str)  // 원본에 영향 없음
print(str2) // bbcd
```

### 📖 포함하는 값 찾기 (output: Bool)
```swift
import Foundation
var str = "string"
str.contains("g")  // true
str.contains("st") // true
str.contains("ring") // true
str.contains("sti") // false
```

### 📖 문자열 상태에서 계산 / 문자열안에 계산식이 들어 있을때
```swift
import Foundation
let mathExpression = NSExpression(format: "3+4+2-1*6") // result : 3
let mathValue = mathExpression.expressionValue(with: nil, context: nil) as! Int
```

### 📖 문자열 인덱스(index) 명령어 정리
```swift
import Foundation
 
// 문자열 원소 접근
var str = "Hello World!"
//str[0] // 직접 접근 불가능, String.Index로 접근가능

print(str.prefix(n)) // 앞에서부터 n글자 가져오기
print(str[str.startIndex]) // "a" 시작 원소

let secondIndex = str.index(after: str.startIndex) // 2번째 원소

let second = str[secondIndex]

let endIndex = str.index(before: str.endIndex) // 마지막 원소
 
// n번째 문자 가져오기 n == 3
var index = str.index(str.startIndex, offsetBy: 3 - 1)
str[index] // "c"
 
// 일정 범위의 문자열만 가져오기
let sub = str[str.startIndex...index] // "abc"
  
// 특정 원소 값으로 인덱스 찾기 (옵셔널 값) 해당하는 원소값이 없으면 에러(nil)
str.firstIndex(of: "n")!
 
// subString 구하는 법 특정 원소 첫 return 까지
let substring = str[str.startIndex...str.firstIndex(of: "n")!]
```

### 📖 작은 따옴표 (') 큰따옴표 (")
```swift
print("작은 따옴표는 \' 큰 따옴표는 \" ")
```

## 🍎 특이 케이스
```swift
let text = "$12$ \-\ $25$" // 안됨

let text = #"$12$ \-\ $25$"# // 됨!
```
- swift5에서 특수문자를 string으로 받는법이 소개되었는데 좌우를 #과 "으로 감싸면 가장 밖에 있는 " " 안에 있는 모든 문자들을 문자열로 인식한다.

## 🍎 아스키코드 치환
- char to ascii
    - Int(char.asciiValue!)!
- ascii to char
    - String(UnicodeScalar(97)!)

## 🍎 특정 인덱스를 중심으로 문자열을 둘로 나눌때
```swift
var starIndex = pattern.firstIndex(of: "*")!
let startString = String(pattern[pattern.startIndex..<starIndex])
let endString = String(pattern[pattern.index(after: starIndex)...pattern.index(before: pattern.endIndex)])
// index(after:) 메서드와 index(before:)메서드 사용하기

// endIndex 주의
// 만약 "Hello"라면 endIndex는 4가 아니라 5다.
```

## 🍎 ~으로 시작하고 ~으로 끝나는지 확인하기
```swift
.hasPrefix(String) -> Bool
.hasSuffix(String) -> Bool
```
