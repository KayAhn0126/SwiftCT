# 12851 숨바꼭질 2
- 숨바꼭질1 + 가장 빠른 시간으로 동생에게 도달 할 수 있는 수까지 출력해야 한다.
## 🍎 문제 접근
- BFS
- 2개의 배열 사용
    - visited
        - 방문했었는지 확인하는 배열
    - waysToFind
        - 다음 방문할 곳의 값이 현재의 값 + 1일때, 즉, 최단거리 일때 다음 방문할 곳으로 가는 방법의 가지 수 추가를 위한 배열

## 🍎 전체 코드
```swift
import Foundation

struct Queue<T> {
    var enqueueList: [T] = []
    var dequeueList: [T] = []
    
    var count: Int {
        return enqueueList.count + dequeueList.count
    }
    
    var isEmpty: Bool {
        return enqueueList.isEmpty && dequeueList.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enqueueList.append(element)
    }
    
    mutating func dequeue() -> T? {
        if dequeueList.isEmpty {
            dequeueList = enqueueList.reversed()
            enqueueList.removeAll()
        }
        return dequeueList.popLast()
    }
}

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var bfsQueue = Queue<Int>()

var visited = [Int](repeating: 0, count: 200001)
var waysToFind = [Int](repeating: 0, count: 200001)

visited[N] = 1
waysToFind[N] = 1
bfsQueue.enqueue(N)

if N == K {
    print(0)
    print(1)
} else {
    if 0 <= N && N <= 100000 && 0 <= K && K <= 100000 {
        while !bfsQueue.isEmpty {
            let currentNumber = bfsQueue.dequeue()!
            
            for i in 1...3 {
                var nextNumber = currentNumber
                if i == 1 {
                    nextNumber -= 1
                } else if i == 2 {
                    nextNumber += 1
                } else {
                    nextNumber *= 2
                }
                if nextNumber < 0 || nextNumber > 200000 { continue }
                if visited[nextNumber] == 0 { // 아직 방문하지 않았다는 뜻은 이제 처음으로 방문 할 것이란 뜻이고 이 말은 지금 visited[nextNumber]에 저장되는 값이 최단거리가 된다는 뜻이다.
                    visited[nextNumber] = visited[currentNumber] + 1
                    waysToFind[nextNumber] += waysToFind[currentNumber]
                    bfsQueue.enqueue(nextNumber)
                } else if visited[nextNumber] == visited[currentNumber] + 1 {  // if문을 안탔다는것은 이미 전에 방문했었다는 뜻. 다시 방문하는데 "다른 경로로 방문해도 최단거리라면" 찾을수 있는 방법의 수를 늘려준다.
                    waysToFind[nextNumber] += waysToFind[currentNumber]
                }
                
            }
        }
    }
    print(visited[K] - 1)
    print(waysToFind[K])
}
```
