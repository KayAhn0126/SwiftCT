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

let arr2: [[Int]] = Array(repeating:Array(repeating:1, count: 5), count: 3) 
// 안쪽 count가 행, 바깥 count가 열
arr2[i][j]
```

### 📖 메서드
#### 정렬
```swift
var arr = [1,3,2,4]
 
arr.sort()        // 오름차순 [1,2,3,4]
arr.sort(by: >) // 내림차순 [4,3,2,1]
//sort() - 원본 순서변경으로 배열 정렬
//sorted() - 원본 변경없이 정렬한 배열을 새 배열에 담아 반환.
```

#### 나머지
```swift
arr.append(6) // [1,2,3,4,5,6]
// arr now contains 1 value of type Int
 
// 인덱스로 원소 확인
arr[2] // 3
 
// 원소로 인덱스 확인 (옵셔널, 값이 없으면 오류)
arr.firstIndex(of: 3)! // 2
 
// 인덱스로 원소 지우기
arr.remove(at: 2) // [1,2,4,5,6]
 
// 맨 뒤 원소를 지우고 return (옵셔널이 아님, 배열이 비어있으면 에러)
arr.removeLast() // [1,2,4,5]
 
// 특정 인덱스에 원소 넣기
arr.insert(3, at: 2) // [1,2,3,4,5]
 
// 특정 원소 있는지 체크 bool type
arr.contains(3) // true
 
// 순서 반전
arr.reverse() // [5,4,3,2,1]
 
// 첫 원소를 지우고 return (옵셔널이 아님, 배열이 비어있으면 에러)
arr.removeFirst() // [4,3,2,1]
 
// 첫 원소 return (옵셔널, 값이 없으면 오류)
arr.first! // 4
 
// 마지막 원소 지우고 return (옵셔널, 배열이 비어있으면 return nil)
arr.popLast()!
 
// 마지막 원소 return (옵셔널)
arr.last!
 
// 원소의 최대값, 최소값 (옵셔널)
var min = arr.min()! // 1
var max = arr.max()! // 5
 
// 모든 원소 지우기
arr.removeAll()
 
// 조건을 만족하는 모든 원소 지우기 
arr.removeAll(where: {$0 % 2 == 0}) 
//arr.removeAll{$0 % 2 == 0} // 위 코드 함축
 
// 원소 스왑
arr.swapAt(_:, _:)
```

#### 고차함수
```swift
// map
var testStr = ["1","2","3","4"]
var resultStr = testStr.map { Int($0)! } // void 메서드 아님 + 타입이 바뀌었으므로 새로운 배열에 할당하기
print(resultStr)

// filter
var arr = [1,2,3]
arr = arr.filter { $0 % 2 == 0 } // void 메서드 아님
print(arr)

// reduce
var array = [1,2,3,4]
//array.reduce("", +)// 문자열 합
print(array.reduce(0, +)) // 숫자 합
```

#### 배열 인덱스와 값 순회 참조
```swift
var arr = [1,2,3]
for n in arr {
    print(n)
}

// enumerated() 사용 예시 1
for (index, value) in arr.enumerated() {
    print("\(index), \(value)")
}

// enumerated() 사용 예시 2
arr.enumerated().forEach {
    print($0.offset) // 인덱스
    print($0.element) // 값
}

for i in 0..<arr.count {
    print(arr[i])
}
 
for i in arr.indices {
    print(arr[i])
}
```

#### 배열 뒤집기
```swift
var arr = [1,2,3]
arr.reverse() // 해당 배열에서 리버스 O(n)
arr.reversed() // 해당 배열을 역순으로 access하게 도와줌

var array = [1,2,3,4]
for num in array.reversed() {
    print(num) // 4 3 2 1
}

array.reverse()
print(array) // [4,3,2,1]
```
