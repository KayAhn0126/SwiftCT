//
//  main.swift
//  StartLink
//
//  Created by Kay on 2023/03/07.
//

/*
 5014
 스타트링크
 */

/*
 F -> 총 층수
 S -> 강호가 지금 현재 있는 층
 G -> 스타트링크가 있는 곳의 층
 U -> U층을 가는 버튼
 D -> D층을 가는 버튼
 
 인접리스트 BFS + 최단거리
 도달할 수 있다면 최단거리 출력, 아니면 "use the stairs" 출력
 */

import Foundation

let FSGUD = readLine()!.split(separator: " ").map { Int(String($0))! }
let F = FSGUD[0]
let S = FSGUD[1]
let G = FSGUD[2]
let U = FSGUD[3]
let D = FSGUD[4]

var visited = [Int](repeating: 0, count: F + 1)
var bfsQueue = [Int](), idx = 0

visited[S] = 1
bfsQueue.append(S)
let UD = [U,D]
/*
 U버튼을 눌렀을 때 올라가는 층과
 D버튼을 눌렀을 때 내려가는 층을 배열화 해서 밑에서 편하게 사용할 수 있다.
 */
var flag = false // 답이 구해졌는지 확인하는 플래그
while idx < bfsQueue.count {
    let currentFloor = bfsQueue[idx]; idx += 1
    if currentFloor == G {
        flag = true
        break
    }
    // 다음에 어디로 갈지 엘레베이터 버튼을 누르는데..
    for i in 0..<UD.count {
        var nextFloor = 0
        if i == 0 { // 만약 Up 버튼을 누르면 현재 층 + U만큼의 층
            nextFloor = currentFloor + U
        } else { // 만약 Down 버튼을 누르면 현재 층 - D만큼의 층
            nextFloor = currentFloor - D
        }
        // 만약 1층보다 작거나 F층보다 높으면.. (불가능)
        if nextFloor < 1 || nextFloor > F { continue }
        // 이미 방문 했었던 층이라면.. (가능하지만 Skip)
        if visited[nextFloor] > 0 { continue }
        visited[nextFloor] = visited[currentFloor] + 1
        bfsQueue.append(nextFloor)
    }
}
if flag == true {
    print(visited[G] - 1)
} else {
    print("use the stairs")
}
