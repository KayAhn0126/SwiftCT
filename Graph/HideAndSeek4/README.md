# 13913 숨바꼭질 4

## 🍎 문제 접근
- 먼저 무엇을 출력해야 하는지 보자.
    - 수빈이가 동생을 찾는 가장 빠른 시간 출력
    - 어떤 노드를 방문하면서 찾았는지 출력
- 가장 빠른 시간은 숨바꼭질 1번에서 한 것 처럼 BFS + 최단거리
- 어떤 노드를 방문했는지 확인하는 배열 prev 생성

## 🍎 prev 배열의 역할
```swift
prev[nextNumber] = currentNumber
```
- "다음 방문할 노드는 현재 노드에서 방문한 것이다." 라고 트래킹을 할 수 있도록 만든 코드.
- 나중에 출력 할 때는 마지막에서 거꾸로 출력하면 된다.
    - 현재 저장 상태
    - ex) 17 -> 18 -> 9 -> 8 -> 4 -> 2 -> 1
    - 정답으로 나와야 하는 순서
    - ex) 1 -> 2 -> 4 -> 8 -> 9 -> 18 -> 17

## 🍎 전체 코드
```swift
//
//  main.swift
//  HideAndSeek4
//
//  Created by Kay on 2023/02/23.
//

/*
 13913
 숨바꼭질 4
 */
// 3rd week fast campus

/*
 수빈이의 위치 0 ~ 100000
 동생의 위치 0 ~ 100000
 20만 짜리 배열 + BFS + Trace
 
 출력
    첫째줄에 수빈이가 동생을 찾는 가장 빠른 시간 -> BFS + 최단거리
    둘째줄에 어떻게 이동해야 하는지 공백으로 구분해 출력 -> Trace
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = NK[0] // 현재 수빈이의 위치
let K = NK[1] // 동생이 있는 위치

var visited = [Int](repeating: 0, count: 100001)
var prev = [Int](repeating: -1, count: 100001) // trace 배열

var bfsQueue = [Int](), idx = 0
bfsQueue.append(N)
visited[N] = 1

while idx < bfsQueue.count {
    let currentNumber = bfsQueue[idx]; idx += 1
    if currentNumber == K {
        break
    }
    for i in 1...3 {
        var nextNumber = currentNumber
        if i == 1 {
            nextNumber -= 1
        } else if i == 2 {
            nextNumber += 1
        } else {
            nextNumber *= 2
        }
        if nextNumber < 0 || nextNumber > 100000 { continue }
        if visited[nextNumber] > 0 { continue }
        visited[nextNumber] = visited[currentNumber] + 1
        prev[nextNumber] = currentNumber
        bfsQueue.append(nextNumber)
    }
}
var result: [Int] = [] // 결과를 출력할 배열

if N == K {
    print(0)
    print(N)
} else {
    var tempArr: [Int] = []
    tempArr.append(K)
    var prevLocation = prev[K]
    while prevLocation != -1 {
        tempArr.append(prevLocation)
        prevLocation = prev[prevLocation]
    }
    result.append(contentsOf: tempArr.reversed())
    print(visited[K] - 1)
    result.enumerated().forEach {
        print($0.element, terminator: " ")
    }
    print("")
}
```
