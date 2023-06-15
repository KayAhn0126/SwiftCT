# 16928 뱀과 사다리 게임

## 🍎 문제 접근
- 100에 가장 빨리 도달하게끔 주사위를 굴리는 문제다.
- 사다리나 뱀을 마주치면 해당 위치로 올라가거나 떨어진다.
- BFS + 세부 로직으로 풀기!

## 🍎 문제 풀이 - 전체적인 로직
- 주사위의 범위인 1~6까지 한번씩 던져보고 거기에 맞는 로직 처리
- [Int] 타입의 visited 선언. 여기에 최소 값을 갱신할 예정
- 100이 넘어가면 무효처리
- 현재 값 + 1이 visited의 값보다 작으면 업데이트 시켜준다.
- visited[100]의 값

## 🍎 전체 코드
```swift
import Foundation

let ladderSnakeCount = readLine()!.split(separator: " ").map { Int(String($0))! }
let ladder = ladderSnakeCount[0]
let snake = ladderSnakeCount[1]

var dictionary: [Int: Int] = [:]
for _ in 0..<ladder+snake {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
    dictionary[temp[0]] = temp[1]
}

var bfsQueue = [Int](), idx = 0
var visited = [Int](repeating: 0, count: 101)
bfsQueue.append(1)
visited[1] = 1

while idx < bfsQueue.count {
    let currentNum = bfsQueue[idx]; idx += 1
    if currentNum == 100 {
        print(visited[100] - 1)
        break
    }
    for diceNum in 1...6 {
        var nextNum = currentNum + diceNum
        if dictionary[nextNum] != nil {
            nextNum = dictionary[nextNum]!
        }
        if nextNum > 100 { continue }
        if visited[nextNum] == 0 {
            visited[nextNum] = visited[currentNum] + 1
            bfsQueue.append(nextNum)
        } else {
            if visited[nextNum] > visited[currentNum] + 1 {
                visited[nextNum] = visited[currentNum] + 1
            }
        }
    }
}
```
