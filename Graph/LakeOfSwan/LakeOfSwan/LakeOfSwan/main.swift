//
//  main.swift
//  LakeOfSwan
//
//  Created by Kay on 2023/03/22.
//

/*
 3197
 백조의 호수
 */

/*
 
 . -> water
 X -> 빙판
 L -> 백조
 
 1. .의 위치를 모두 구한다.
 2. BFS큐를 만들고 다 넣어준다.
 3. 배열이 끝날때까지 돌려주고
 3-1. 돌리는 도중에 X를 만나면 X의 위치를 다른 Queue에 넣어준다. + .으로 만들어준다.
 3-2. 기존 큐가 끝나면 X의 위치가 들어있던 큐를 기존큐에 넣어준다.
 4. 3번이 한번씩 끝날때마다 날짜를 늘려주고, 백조끼리 만날 수 있는지 체크한다.
 
 
 */
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var waterLocation: [(Int, Int)] = []
var swanLocation: [(Int, Int)] = []

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == "." {
            waterLocation.append((i,j))
        } else if adjMatrix[i][j] == "L" {
            swanLocation.append((i,j))
        }
    }
}

var meetVisited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

//MARK: meetVisited 초기화 함수
func clearMeetVisited() {
    meetVisited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
}

// 백조끼리 만날수 있는지 확인하는 DFS 함수 adjMatrix는 그대로 이용하되 이 함수 전용 visted 배열이 필요하다.
// 이 함수는 체크 할 때, 인자로 하나의 백조(L)의 위치를 넣고 체크할 때는 다른 하나의 백조(L)의 위치가 1인지 체크해야한다.
// 1 -> "도달 할 수 있다"라는 말
func checkPossibleToMeet(_ y: Int, _ x: Int) {
    meetVisited[y][x] = result
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if meetVisited[ny][nx] == result { continue }
        if adjMatrix[ny][nx] == "X" { continue }
        checkPossibleToMeet(ny,nx)
    }
}

var bfsQueue: [(Int,Int)] = [], idx = 0
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

var tempQueue: [(Int,Int)] = []
var result = 0

// 물의 위치 넣어주기
waterLocation.enumerated().forEach {
    bfsQueue.append(($0.element.0, $0.element.1))
}

// 백조가 있는곳(물 위)도 물 !
swanLocation.enumerated().forEach {
    bfsQueue.append(($0.element.0, $0.element.1))
}

while true {
    while idx < bfsQueue.count {
        let currentYX = bfsQueue[idx]; idx += 1
        for i in 0..<4 {
            let ny = currentYX.0 + dy[i]
            let nx = currentYX.1 + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] > 0 { continue }
            visited[ny][nx] = 1
            if adjMatrix[ny][nx] == "X" {
                tempQueue.append((ny,nx))
                adjMatrix[ny][nx] = "."
            }
        }
    }
    bfsQueue = tempQueue
    idx = 0
    tempQueue = []
    result += 1
    checkPossibleToMeet(swanLocation[0].0, swanLocation[0].1)
    if meetVisited[swanLocation[1].0][swanLocation[1].1] > 0 {
        break
    }
    //clearMeetVisited()
}
print(result)
