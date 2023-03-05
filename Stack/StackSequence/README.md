# 1874 스택 수열
- 스택

## 🍎 문제 접근
- 문제의 조건에 맞춰 구현 + 예외처리만 잘하면 된다.
```bash
4
3
6
8
7
5
2
1
```
- 이런 수열이 있을 때,
    - 1부터 8까지 넣었다 뺐다 하면서 위의 수열처럼 만들면 된다.
    - 예를 들어 4를 만들기 위해서는 아래와 같이 4번 push를 해야한다.
    ```bash
                          |4|
                   |3|    |3|
    | | ->  |2| -> |2| -> |2|
    |1|     |1|    |1|    |1|
    ```
    - 이때 push를 하면 +, pop을 하면 -를 출력 해주면 되는 문제이고, 만약 수열을 만들지 못하면 NO를 출력하면 되는 문제이다.
- 전체 코드를 통해 자세히 알아보자!

## 🍎 문제 해결
```swift
import Foundation

let stackCount = Int(readLine()!)!

var arr = [Int]() // 이 수열이 기준이다.
for _ in 0..<stackCount {
    arr.append(Int(readLine()!)!)
}

var result = [Character]() // 결과를 담아두고 한번에 출력할 배열
var stack = [Int]() // 1~N까지 수를 push, pop하면서 답을 찾아갈 스택

// 처음에 스택이 비어있으니 1과 '+'를 stack과 result 배열에 넣어준다.
var numberCounter = 1
stack.append(numberCounter)
result.append("+")

while true {
    // 스택이 비어있고 배열도 비어있다면 정상적으로 수열을 만들었다는 이야기이다.
    if stack.isEmpty == true && arr.isEmpty == true {
        break
    }
    // 정상적이지 않은 상황에서 무한루프를 빠져나오기 위한 분기문
    // 스택에 무언가 남아있고 (&& 뒤에 조건을 안전하게 처리하기 위해 써줬다)
    // 스택의 top에 있는것이 배열의 맨 앞과 다르다면 수열을 만들 수 없다.
    if stack.isEmpty == false && stack.last! > arr[0] {
        break
    }
    if stack.isEmpty == true || (stack.isEmpty == false && stack.last! != arr[0]) {
        numberCounter += 1
        stack.append(numberCounter)
        result.append("+")
    } else {
        stack.popLast()!
        arr.removeFirst()
        result.append("-")
    }
}

if stack.count == 0 {
    result.enumerated().forEach {
        print($0.element)
    }
} else {
    print("NO")
}
```

## 🍎 수열을 만들 수 없는 경우
```bash
1
2
5
3
4
```
- 위의 수열을 배열로 만들어 두자. [1,2,5,3,4]
- stack에 1부터 5까지 넣으면서 수열을 만들어보자
```bash
| |           | |           |5|           | |
| | -> pop -> | | -> pop -> |4| -> pop -> |4|
|1|           |2|           |3|           |3|
push          push         push
```
- stack의 top은 4, arr의 0번째 인덱스는 3이다.
- stack은 1부터 차례대로 차오르는데 배열은 3,4로 되어있어서 스택이 절대 비어지지 않는 구조이기 때문에 break로 나온다.
- 그리고 마지막에 stack에 요소가 남아있는지 확인 후 분기 처리 한다.
