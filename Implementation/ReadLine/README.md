# ReadLine

## 🍎 readline 사용법
- 라인 단위로 받아오기
```swift
// 옵셔널이다
let value = readLine()
```
- Line단위로 읽어오는데, 공백(Space)으로 구분되어 있는 입력
    - ex) Input = 1 2 3 4
```swift
let nums = readLine()!.split(seperator:" ")  
// String.SubSequence Type [map]으로 커버 가능
let nums = readLine()!.components(seperatedBy:" ") 
// String Type [import Foundation] 필수.

/*
split, components + mapping!
components는 foundation의 instance method이므로 이를 사용하려면 import Foundation 해주어야 한다.
*/
```
- Int값 바로 읽어오기
```swift
let n: Int = Int(readLine()!)!
```
- Maping할때 Int값으로 바로 읽어오기
    - String.subsequence -> Int 형변환 보다
    - String.subsequence -> String -> Int 형변환이 더 빠르다. (입력에서 시간초과 난다 싶으면 사용)
```swift
let numbers: [Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
```
