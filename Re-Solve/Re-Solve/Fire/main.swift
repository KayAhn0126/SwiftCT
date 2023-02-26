//
//  main.swift
//  Fire
//
//  Created by Kay on 2023/02/26.
//

/*
 4179
 불
 */

/*
 불이 여러곳에서 동시에 퍼질 수 있다.
 지훈이는 현재 1명이다.
 탈출 조건은 지훈이가 불보다 빠르게 가장자리에 있으면 된다.
 
 불을 지피고 최단거리 구한다.
 지훈이가 현재위치에서 부터 이동하면서 불보다 빠르게 가장자리에 도달하는지 체크.
 */
import Foundation

let RC = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = RC[0]
let C = RC[1]

var adjMatrix = [[Character]](repeating: [Character](), count: R)

for i in 0..<R {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var fireLocationList: [(Int,Int)] = []
var jihoonLocation: (Int,Int) = (0,0)

for i in 0..<R {
    for j in 0..<C {
        if adjMatrix[i][j] == "F" {
            fireLocationList.append((i,j))
        } else if adjMatrix[i][j] == "J" {
            jihoonLocation = (i,j)
        }
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]
let INF = 987654321
var fireVisited = [[Int]](repeating: [Int](repeating: INF, count: C), count: R)
var jihoonVisited = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)

var bfsQueue: [(Int,Int)] = [], idx = 0

fireLocationList.enumerated().forEach {
    let locationY = $0.element.0
    let locationX = $0.element.1
    fireVisited[locationY][locationX] = 1
    bfsQueue.append((locationY, locationX))
}

while idx < bfsQueue.count {
    let currentLocation = bfsQueue[idx]; idx += 1
    let currentY = currentLocation.0
    let currentX = currentLocation.1
    for i in 0..<4 {
        let ny = currentY + dy[i]
        let nx = currentX + dx[i]
        if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
        if fireVisited[ny][nx] != INF { continue }
        if adjMatrix[ny][nx] == "#" { continue }
        fireVisited[ny][nx] = fireVisited[currentY][currentX] + 1
        bfsQueue.append((ny,nx))
    }
}

// 가장자리인지 체크하는 함수
func checkEdge(_ y: Int, _ x: Int) -> Bool {
    if y == 0 || x == 0 || y == R - 1 ||  x == C - 1 {
        return true
    }
    return false
}

// 불 다 지폈으니 지훈이가 탈출 할 수 있는지 체크

var result = -1
func solution() {
    while idx < bfsQueue.count {
        let currentLocationYX = bfsQueue[idx]; idx += 1
        let currentY = currentLocationYX.0
        let currentX = currentLocationYX.1
        if checkEdge(currentY, currentX) == true {
            result = jihoonVisited[currentY][currentX]
            return
        }
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
            if adjMatrix[ny][nx] == "#" { continue }
            if jihoonVisited[currentY][currentX] + 1 >= fireVisited[ny][nx] { continue }
            if jihoonVisited[ny][nx] > 0 { continue }
            
            jihoonVisited[ny][nx] = jihoonVisited[currentY][currentX] + 1
            bfsQueue.append((ny,nx))
        }
    }
    result = -1
}

// 재사용을 위한 초기화
bfsQueue.removeAll()
idx = 0

// BFS 탐색을 위한 지훈이의 위치 넣어주기
jihoonVisited[jihoonLocation.0][jihoonLocation.1] = 1
bfsQueue.append((jihoonLocation.0, jihoonLocation.1))

// 지훈이가 빠져 나갈 수 있는지 체크하는 함수 실행
solution()

// 결과 출력
if result == -1 {
    print("IMPOSSIBLE")
} else {
    print(result)
}

// 오답!
/*
 
 불이 하나도 없는 경우를 대비 해야한다. -> fireVisited의 기본값을 0에서 987654321로 하고
 fireVisited에서 BFS를 돌때,
 if fireVisited[ny][nx] != INF { continue }로 처리해주어 이미 방문한 곳은 방문하지 않도록 해주었다.
 
 */
