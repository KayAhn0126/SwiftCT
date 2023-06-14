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

// 주사위의 범위인 1~6까지 한번씩 던져보고 거기에 맞는 로직 처리
// [Int] 타입의 visited 선언. 여기에 최소 값을 갱신할 예정
// 100이 넘어가면 무효처리
// 현재 값 + 1이 visited의 값보다 작으면 업데이트 시켜준다.
// visited[100]의 값

// 딕셔너리를 돌면서 값이 있다면 바로 벨류로 넘어가기

import Foundation

let ladderSnakeCount = readLine()!.split(separator: " ").map { Int(String($0))! }
let ladder = ladderSnakeCount[0]
let snake = ladderSnakeCount[1]

var dictionary: [Int: Int] = [:]
for i in 0..<ladder+snake {
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
