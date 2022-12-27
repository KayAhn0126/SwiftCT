# Loop

## 🍎 loop 사용법
### 📖 for loop
```swift
// 기본 for loop 
for i in 0...10 // 0 ~ 10
for i in 0..<10 // 0 ~ 9
for i in 0...10 where i % 2 == 0 // 0 2 4 6 8 10

for i in stride(from: 0, to 5, by 1) // 0 이상 5 미만, 1씩 증가
for i in stride(from: 5, to 0, by -1) // 5 이하 0 초과 , 1씩 감소

for i in stride(from: 0, through: 5, by 1) // 0 이상 5 이하, 1씩 증가
for i in stride(from: 5, through: 0, by -1) // 5 이하 0 이상, 1씩 감소


// Array와 자주 사용하는 forEach loop
arr.enumerated().forEach {
    print($0.offset) // 인덱스
    print($0.element) // 값
}
```

### 📖 while loop
```swift
var i = 0
while i < 5 {
    print(i)
    i += 1
}
```

### 📖 repeat while
```swift
var j = 10

repeat {

    print(j)
    j += 1
    
} while j < 10
```

## 🍎 enumerated()메서드와 reversed()메서드
- enumerated() 메서드
    - (index, element) 반환
- reversed() 메서드
    - O(1)
    - 컬렉션의 요소들을 반대로 보여준다.

## 🍎 enumerated()와 reversed()를 같이 사용 할 때 조심하기.
- 둘을 앞뒤로 바꿔서 구현한 예제 코드를 보자.
```swift
var userInput = readLine()! // ABCDE를 넣음
var countingArr = [Int](repeating: 0, count: 26)
var resultStr = ""
var centerChar = ""
var checkCount = 0
userInput.enumerated().forEach {
    countingArr[Int($0.element.asciiValue!) - 65] += 1
}

print(countingArr) // [1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

// 1
countingArr.enumerated().reversed().forEach {
    // $0.offset과 $0.element를 출력하면 아래와 같이 나온다.
    // offset : 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0 
    // element: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1
}

// 2
countingArr.reversed().enumerated().forEach {
    // $0.offset과 $0.element를 출력하면 아래와 같이 나온다.
    // offset : 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 
    // element: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1
}
```
- 1번(enumerated()가 먼저, reversed() 나중)에 대한 설명.
    - enumerated() 메서드는 offset과 element를 **한뭉텅이로** 쭈욱 나열한다고 생각하면 된다.
    - offset : 0 1 2 3 4 5 6 7 8 9 ... 24 25 26
    - element: 1 1 1 1 1 0 0 0 0 0 ... 0 0 0
    - 이후 reversed를 하면 offset과 element가 같이 움직인다.
- 2번(reversed()가 먼저, enumerated() 나중)에 대한 설명.
    - reversed()는 안에 있는 값 들을 역순으로 보여준다. (원본은 그대로)
        - reverse()는 원본 바꿈
    - 이후 역순으로 바뀐값에 enumerated()를 적용하면 현재 상태를 기준으로 offset과 element를 묶어서 쭈욱 나열한다.
    - offset : 0 1 2 3 4 5 6 7 8 9 ... 24 25 26
    - element: 0 0 0 0 0 0 0 0 0 0 ... 1 1 1


## 🍎 RandomAccessCollection
- RandomAccessCollection은 어느 위치에 있던 임의의 인덱스 접근은 O(1)의 시간복잡도로 수행한다.
- Swift에서 제공하는 배열이 RandomAccessCollection을 사용한다.
- String 타입은 양방향 접근 컬렉션(BidirectionalCollection)
    - 양방향 접근 컬렉션들은 뒤에서 부터 접근이 가능하고 추가적인 프로퍼티와 메서드를 제공한다.
    - 예를들면, last, reversed(), suffix(_:)가 있다.
- 양방향 접근 컬렉션은 첨자 접근시 해당 인덱스에 이동하는 동안 모든 위치를 순회해야 하므로 O(N)
- 하지만 랜덤 접근 컬렉션은 O(1)

## 🍎 Citation
- [applebuddy 블로그](https://0urtrees.tistory.com/138)
- [BidirectionalCollection](https://developer.apple.com/documentation/swift/bidirectionalcollection)
