# 10799 쇠막대기
- 구현

## 🍎 지문 해석
- () <- 이런식으로 붙어있는 한쌍의 괄호는 레이저다!
- 잘려진 쇠막대기 조각의 총 개수를 구하는 프로그램을 작성해라!

## 🍎 문제 접근
- 실버 2이지만 많이 어려웠던 문제다.
- 스택을 이용해서 구현하고 예제 코드를 실행했을때는 예상된 결과를 내뱉었지만, 시간초과가 났다.
- 다른 분들의 아이디어를 참고했더니 더 쉽게 푸는 방법이 있었다.
    - () <- 한쌍의 레이저를 특정 문자로 치환해 푸는 방법
    - 치환하지 않고 푸는 방법

## 🍎 문제 해결 및 전체 코드
### 📖 먼저 66%에서 시간초과를 맞은 코드를 보자!
```swift
import Foundation

struct Stack<T> {
   var elements: [T] = []
   var count: Int {
       return elements.count
   }

   var isEmpty: Bool {
       return elements.isEmpty
   }

   var top: T? {
       return elements.last
   }

   mutating func push(_ element: T) {
       elements.append(element)
   }
   mutating func pop() -> T? {
       return elements.popLast()
   }
}

var str = readLine()!
var myStack = Stack<Character>()

var result = 0
var laserFlag = false
var arr = [Int]()
for i in str {
   if i == "(" {
       arr.append(0)
       myStack.push("(")
       laserFlag = true
   } else if laserFlag && !myStack.isEmpty && myStack.top! == "(" && i == ")" {
       arr.popLast()!
       for j in 0..<arr.count {
           arr[j] += 1
       }
       myStack.pop()!
       laserFlag = false
   } else if !laserFlag && !myStack.isEmpty && myStack.top! == "(" && i == ")" {
       result += arr.popLast()! + 1
       myStack.pop()!
   }
}
print(result)
```
- 시간 초과 요인
    - 로직을 처음에 제대로 못 세웠다. 즉, 흘러가는대로 로직을 생각하다보니 arr.count만큼 반복하는 로직(최대 10만 * 10만까지 연산하는..)이 만들어짐. -> 시간초과.

### 📖 () <- 한쌍의 레이저를 특정 문자로 치환해 푸는 방법
```swift
import Foundation
var str = readLine()!
str = str.replacingOccurrences(of: "()", with: "*")
var stackCount = 0
var result = 0
for i in str {
   if i == "(" {
       stackCount += 1
   } else {
       if i == ")" {
           stackCount -= 1
           result += 1
       } else { // *이라면
           result += stackCount
       }
   }
}
print(result)
```

### 📖 () <- 레이저를 다른 모양으로 치환하지 않고 풀기
```swift
import Foundation
let str = readLine()!
var stackCount = 0 // 현재 몇개의 막대기가 있는지
var result = 0
var strArr = Array(str)
for i in 0..<str.count {
    if strArr[i] == "(" {
        stackCount += 1
    } else {
        stackCount -= 1
        if strArr[i-1] == "(" { // 직전이 ( 였고 현재 )라면 레이저다.
            result += stackCount
        } else { // 막대기를 하나 뺀다.
            result += 1
        }
    }
}
print(result)
```

## 🍎 문제 푼 후 느낀점
- 무조건 지문 꼼꼼히 읽기, 시간복잡도 먼저 계산하기 (특히 N이 10만이상일때는!)
- N이 10만일때는 2중 for문이 사용되는지 확인하기
- swift 배열의 count 프로퍼티는 O(1)이다 -> RandomAccessCollection 프로토콜을 채택하고 있기 때문에!
