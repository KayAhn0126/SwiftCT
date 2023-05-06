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

## 🍎 while문을 사용한 문자 제거
- 간단한 예시 from Q. Math Homework
```swift
func removeZero(_ temp: String) -> String {
    var newString = temp
    while newString.hasPrefix("0") { // 문자열이 0으로 시작할때까지만 실행
        if newString.count == 1 {
            break
        }
        newString.removeFirst()
    }
    return newString
}
```
- "002" -> "2"
- "000" -> "0"
- 문자열의 갯수가 0이 될때까지 또는 문자열이 0으로 시작하지 않을때까지 라는 두가지 조건으로 빠져 나올 수 있다.

## 🍎 문자열 정렬하기
- 간단한 예시 from Q. Math Homework
- 문자열로 되어있는 숫자를 오름차순으로 출력하는 방법
    - 아래 코드는 문자열의 크기가 같다면 아스키코드 순서대로 정렬한다
```swift
numberArr = ["0", "33", "9", "100", "34"]
numberArr.sorted(by: {
    if $0.count == $1.count { // 크기가 같다면
        return $0 < $1    // 아스키 코드 순서대로
    }
    return $0.count < $1.count // 크기가 같지 않다면 크키가 작은것이 앞으로
}).forEach {
    print($0)
}
```
- 크기가 같다면 아스키 코드 순서대로 정렬하는데, 예를 들면 33과 34을 보자.
- 33의 앞자리 3과 34의 앞자리 3을 먼저 비교한다.
- 이후 둘이 같다면 다음 숫자인 3과 4의 아스키코드값을 비교하고 33을 앞, 34를 뒤로 정렬한다.

## 🍎 문자열에서 인덱스 편하게 사용하기
- 먼저 subscript를 사용해 인덱스로 편하게 사용하는 방법을 보자.
```swift
extension String {
    subscript(idx: Int) -> Character? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}
```
- 다른언어는 인덱스로 접근이 가능한데 스위프트는 무엇이 다르길래 startIndex등을 사용해 접근해야 하는지 찾아보았다.

### 📖 유니코드
- 스위프트의 문자열은 유니코드 스칼라 벨류를 기반으로 만들어졌다.
- 유니코드는 여러 시스템에서 encoding, representing, processing text의 국제 기준이다.
- 유니코드는 어느 언어의 어떤 문자도 표현할 수 있다.
- 아래는 공식문서에서 가져온 부가적인 유니코드 설명
    - A Unicode scalar value is a unique 21-bit number for a character or modifier, such as U+0061 for LATIN SMALL LETTER A ("a"), or U+1F425 for FRONT-FACING BABY CHICK ("🐥"). 
    - Note that not all 21-bit Unicode scalar values are assigned to a character—some scalars are reserved for future assignment or for use in UTF-16 encoding.
    - Scalar values that have been assigned to a character typically also have a name, such as LATIN SMALL LETTER A and FRONT-FACING BABY CHICK in the examples above.

### 📖 다른언어에서는 인덱스로 쉽게 가능한데..
- 스위프트는 문자를 어떻게 저장하는지 알면 왜 인덱스로 직접적인 접근이 안되는지 알 수 있다.
- 공식문서에서 [Extended Grapheme Clusters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html#ID294)을 보면 아래와 같이 캐릭터 타입의 객체는 single extended grapheme cluster라고 한다.
- Graphemes는 대조를 일으킬 수 있는 글자 체계에서 가장 작은 단위.
- 즉 single extended grapheme cluster는 전 세계에 있는 모든 글자를 조각조각 세분화한 단위라는것.
- 그리고 이 조각들은 조합이 가능하다.
- 공식문서의 예시를 보자.
```swift
// 첫번째 예시
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
// eAcute is é, combinedEAcute is é

// 두번째 예시
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed is 한, decomposed is 한
```
- \u{something} <- 처럼 21비트 유니코드 스칼라에 조각조각으로 세분화 된것끼리 조합을 할 수 있고, 각각의 유니코드 스칼라는 모두 다른 비트를 가지고 있으므로 메모리의 크기 또한 다르다.
- 공식문서에는 아래와 같이 문자열에 접근해야 한다고 나와있다.
    - As mentioned above, different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. 
    - For this reason, Swift strings can’t be indexed by integer values.
- 공식 문서에는 나와있지 않지만, 나의 추측을 써본다.
    - 각각의 문자는 21비트 유니코드 스칼라 값으로 정해져있다.
    - 다른 언어에서 사용하는 아스키 코드에서 볼 수 있듯이 A(65)(100 0001), a(97)(110 0001)인것처럼 스위프트의 유니코드 스칼라로 만들어진 문자들도 각각의 비트가 있을것이고 그것에 따라 할당된 메모리가 모두 다를것이다.
    - 다른 언어에서는 한글자마다 메모리가 딱,딱 떨어졌다면 스위프트에서는 그렇지 않은 특성 때문에 인덱스로 접근할 수 없는것이다.

## 🍎 특수 문자를 있는 그대로 출력하기
```swift
print(#"!@#$%^&*(\'"<>?:;"#)
```
- print(#"특수문자가 들어갈 곳"#)
- 쌍 따옴표 양 옆에 #을 넣어주면 된다!
