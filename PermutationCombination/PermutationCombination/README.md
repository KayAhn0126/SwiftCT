# Permutation & Combination

## 🍎 배열에서 순열 만들기 코드
```swift
import Foundation

func permutation<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result } // 같을때는 가능

    var stack: [([T], [Bool])] = array.enumerated().map {
        var visited = Array(repeating: false, count: array.count)
        visited[$0.offset] = true
        return ([$0.element], visited) // [([1], [true, false, false]), ([2], [false, true, false]), ([3], [false, false, true])]
    }
    print(stack)
    while stack.count > 0 {
        let now = stack.removeLast()

        let elements = now.0
        var visited = now.1

        if elements.count == n {
            result.append(elements)
            continue
        }

        for i in 0...array.count-1 {
            if visited[i] { continue }
            visited[i] = true
            stack.append((elements + [array[i]], visited))
            visited[i] = false
        }
    }

    return result
}

// MARK: - permutation test
var arr: [Int] = [1,2,3]
var finalArr = permutation(arr, 3)
finalArr.enumerated().forEach {
    print($0.element)
}
```
## 🍎 순열 코드 분석
- 먼저 순열을 만들기 위해 뽑으려는 갯수가 배열의 총 갯수 범위안에 있는지 확인한다.
    - 예를들어 [1,2,3]인데 4개를 뽑아서 순열을 만들 수는 없다.
    - 최대 arr.count까지 가능!
- 순열 만들때 사용할 stack[([T],[Bool])] 타입을 만들어 준다.
```swift
var stack: [([T], [Bool])] = array.enumerated().map {
    var visited = Array(repeating: false, count: array.count)
    visited[$0.offset] = true
    return ([$0.element], visited)
}
```
- array가 [1,2,3]일때, stack을 출력하면 아래와 같은 배열이 출력된다.
```swift
[
    ([1], [true, false, false]),
    ([2], [false, true, false]),
    ([3], [false, false, true])
]
```
- 배열 arr은 [1,2,3]이고, arr 배열의 요소를 각각 array.enumerated().forEach에서 생성된 Bool 타입 배열과 튜플로 묶어준다.
- 왜 이렇게 복잡하게 만들었을까?
- 밑에 while문에서 stack.count > 0 조건문이 거짓이 될때 까지 계속 RemoveLast를 해준다.
```swift
let now = stack.removeLast()

let elements = now.0
var visited = now.1
```
- while 문에 들어가자마자 stack의 맨 마지막 요소(튜플 형태)를 빼서 튜플의 첫번째 요소는 element, 두번째 요소는 visited 변수에 담아준다.
```swift
if elements.count == n {
    result.append(elements)
    continue
}
```
- 이 코드는 element가 뽑으려는 갯수와 같아졌을때 result 배열에 지금까지 차곡차곡 쌓인 elements 배열을 넣어주고 더 이상 밑의 코드(stack.append)가 실행되지 않도록 한다.
```swift
for i in 0...array.count-1 {
    if visited[i] { continue }
    visited[i] = true
    stack.append((elements + [array[i]], visited))
    visited[i] = false
}
```
- 제일 중요한 로직이다.
- 위의 stack에서 removeLast()를 하면,
    - element에는 [3]
    - visited에는 [false, false, true]가 담겨있다.
- 0부터 array.count-1인 2까지 총 3번 반복하는데, i가 0일때, visited[0]은 false이므로 if문에 걸리지 않고 visited[0]을 true로 바꿔준다. 그리고 stack.append((element + [array[0]], visited))를 해주는데, 그럼 stack의 맨 마지막에([3,1],[true,false,true])를 더해주는 것이다.
    - 여기서 visited[i] = true의 의미는 "array[i]를 순열을 위해 사용할것이니 방문처리한다"라는 의미이다.
- 방금 true로 바꿔준 visited[i]를 false로 다시 바꿔준다. -> 이 부분이 이해하는데 제일 어려웠다.
    - 이제 for문의 두번째 반복을 보자.
    - stack.append([3,2], [false, true, true])가 실행되고 다시 stack의 마지막에 넣어진다.
    - visited[2]는 true이므로 continue.
    - 다시 while문의 처음으로 간다.
- 이제 element의 count가 n과 같아질때까지 반복하고 n과 같아질때 result 배열에 추가 후 continue로 빠져나온다.

