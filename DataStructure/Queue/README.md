# Queue

## 🍎 알고리즘에서 사용할 큐 (입출력 10만개 이상)
- 백준의 [효율적인 해킹](https://www.acmicpc.net/problem/1325) 문제를 푸는데 시간초과가 나서 무엇이 문제인지 물어보기 위해 swift algorithm 방에 올렸다.
- 돌아온 답변은 문제 풀기에 사용한 큐 자료구조가 느리다는 것과, 이차원 배열을 여러번 참조하면 느려진다는 것이다.
- 내가 사용했던 큐 자료구조를 보자.
```swift
import Foundation

struct Queue<T> {
    var enQueue: [T] = []
    var deQueue: [T] = []
    
    var count: Int {
        return enQueue.count + deQueue.count
    }
    
    var isEmpty: Bool {
        return enQueue.isEmpty && deQueue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enQueue.append(element)
    }
    
    mutating func dequeue() -> T {
        if deQueue.isEmpty {
            deQueue = enQueue.reversed()
            enQueue.removeAll()
        }
        return deQueue.popLast()!
    }
}
```
- dequeue 메서드의 removeAll()이 O(n)이라 요소가 10만개이고 dequeueList 배열에 아무것도 없다면 O(10만)이 되는것이다.
- 이에 답변을 준 사람은 배열 하나에 인덱스 하나로 관리하라는 것을 추천 해주었다.
- 아래는 답변해주신 분이 사용한 큐 및 사용법
```swift
func bfs(_ node: Int) -> Int {
    var bfsQueue = [Int](), idx = 0
    var visited = [Int](repeating: 0, count: N + 1)
    var count = 1
    visited[node] = count
    bfsQueue.append(node)
    while idx < bfsQueue.count {
        let number = bfsQueue[idx]; idx += 1
        for nxt in adjList[number] {
            if visited[nxt] != 0 { continue }
            count += 1
            visited[nxt] = 1
            bfsQueue.append(nxt)
        }
    }
    return count
}
```
- 구조체도 없고 뭐 아무것도 없다. 배열 하나만 필요하고 enqueue할때는 append()함수를 dequeue할때는 index를 하나 옮긴뒤 접근(O(1) 소요)

## 🍎 일반 배열을 큐로 사용시 장점
- 큐의 앞의 요소를 뺀다 -> 인덱스로 접근
    - O(1)
    - let number = bfsQueue[idx]; idx += 1
- 큐의 마지막 요소 뺀다 -> popLast()! 
    - O(1)

## 🍎 상황에 따른 큐 구현 정리
### 📖 프로그램 구현
```swift
import Foundation

struct Queue<T> {
    var enQueue: [T] = []
    var deQueue: [T] = []
    
    var count: Int {
        return enQueue.count + deQueue.count
    }
    
    var isEmpty: Bool {
        return enQueue.isEmpty && deQueue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enQueue.append(element)
    }
    
    mutating func dequeue() -> T {
        if deQueue.isEmpty {
            deQueue = enQueue.reversed()
            enQueue.removeAll()
        }
        return deQueue.popLast()!
    }
}
```
### 📖 알고리즘 문제 구현
```swift
var bfsQueue = [Int](), idx = 0    
while idx < bfsQueue.count {
    let number = bfsQueue[idx]; idx += 1
}
```
