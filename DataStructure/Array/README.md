# Array

## 🍎 Array
### 📖 생성
```swift
let arr1: Array<Int> // 상수형 정수 배열
var arr2: Array<String> // 변수형 문자열 배열

// 단축 문법
let arr1: [Int]
let arr2: [String]

// 타입 추론
let arr1 = [1, 2, 3, 4, 5] // 상수형 정수형 배열
var arr2 = ["일", "이", "삼", "사", "오"] // 변수형 문자열 배열

// 주의!
let emptyArr = [] //error! 타입없음

let arr = [1, "이", 3, "사"] // error! 타입이 일정하지 않음.
```

### 📖 빈배열 만들기
```swift
let emptyArray: [Int] = []
 
// 정식 문법 사용
let emptyArray2 = Array<Int>()
 
// 단축 문법 사용
let emptyArray3 = [Int]()
```

### 📖 임의의 값 넣기
```swift
// 정식 문법
let strArray1: Array<String> = ["정식", "문법"]
 
// 단축 문법
let strArray2: [String] = ["단축", "문법"]
 
// 형식 추론
let strArray3 = ["형식", "추론"]
 
// 시퀀스
let nums = Array(1...3) // [1, 2, 3]
 
// 여러 자료형(타입)
let anyArr: [Any] = [1, 2, "three", "four"] // [1, 2, "three", "four"]
```

### 📖 크기가 정해진 배열
```swift
// (repeating: 배열의 타입과 일치하는 값(1개), count: 값을 반복할 횟수)
 
let zeroArray1 = [Int](repeating: 0, count: 10) // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 
let zeroArray2 = Array(repeating: 0, count: 10) // [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
 
// zeroArray1과 zeroArray2는 완전히 동일합니다.
```
