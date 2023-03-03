# 2644 촌수 계산

## 🍎 문제 접근
- 인접 리스트
- 조심해야할 점이 있는데, 3이 7와 관계가 있다면 7도 3에 대해 관계를 가지고 있다는것
    - **양방향 간선!**
- X부터 Y까지 얼만큼 걸리는지 출력하면 된다.

## 🍎 메인 로직
```swift
var bfsQueue = [Int](), idx = 0
bfsQueue.append(from)
visited[from] = 1

var result = -1 // 만약 to를 찾지 못하는 경우를 대비해 -1로 설정
// BFS
while idx < bfsQueue.count {
    let currentNumber = bfsQueue[idx]; idx += 1
    if currentNumber == to { // 현재 큐에서 나온것이 to와 같다면
        result = visited[currentNumber] - 1
        break
    }
    for number in adjList[currentNumber] {
        if visited[number] > 0 { continue }
        visited[number] = visited[currentNumber] + 1
        bfsQueue.append(number)
    }
}
print(result)
```
