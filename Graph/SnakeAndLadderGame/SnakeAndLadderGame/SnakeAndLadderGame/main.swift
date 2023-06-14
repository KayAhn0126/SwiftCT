//
//  main.swift
//  SnakeAndLadderGame
//
//  Created by Kay on 2023/06/14.
//

/*
 16928
 뱀과 사다리 게임
 */

// 문제 접근.
// BFS로 풀면 된다. 하지만 중간중간 특정 상황에서 딕셔너리 체크와 더 작은 값인지 확인 후 업데이트 하는 로직이 필요하다.

// 입력 받기 + 딕셔너리에 사다리와 뱀 추가하기
// bfsQueue 큐, 최단거리를 구하기 위한 visited 배열 선언
// 현재 bfsQueue에 있는 요소를 하나 빼고 해당 숫자와 1~6까지 하나씩 가져온 수를 더한다.
// 더한 수를 nextNum이라고 한다. -> 100 초과면 무효처리

// nextNum이 만약 딕셔너리에 있다면 즉, 사다리나 뱀이여서 움직이는 경우이기 때문에 딕셔너리의 value 로 nextNum을 변경시켜준다.
// 처음 방문하는 경우에는 현재 방문한 값 + 1로 초기화 해주고 nextNum을 queue에 넣어준다.
// 아니라면 현재 최단거리가 이전 최단거리보다 작은지 확인 후 업데이트 시켜준다.

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
