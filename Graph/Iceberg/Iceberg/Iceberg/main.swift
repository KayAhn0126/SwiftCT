//
//  main.swift
//  Iceberg
//
//  Created by Kay on 2023/03/27.
//

/*
 2573
 빙산
 */

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var visited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)

func visitedClear() {
    for i in 0..<N {
        for j in 0..<M {
            visited[i][j] = false
        }
    }
}
func connectedComponentDFS(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == true { continue }
        if adjMatrix[ny][nx] == 0 { continue }
        visited[ny][nx] = true
        connectedComponentDFS(ny,nx)
    }
}

func getConnectedComponent() -> Int {
    var result = 0
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 0 || visited[i][j] == true { continue }
            connectedComponentDFS(i,j)
            result += 1
        }
    }
    visitedClear()
    return result
}


var bfsQueue = [Location](), idx = 0
var result = 0

//MARK: 초기 얼음위치 넣어주기
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 0 {
            bfsQueue.append(Location(y: i, x: j))
        }
    }
}

struct Location: Hashable {
    var y: Int
    var x: Int
}

while true {
    var nextIceList = Set<Location>()
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        for i in 0..<4 {
            let ny = currentLocation.y + dy[i]
            let nx = currentLocation.x + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            let nextLocationNumber = adjMatrix[ny][nx]
            if nextLocationNumber == 0 { continue }
            if nextLocationNumber >= 1 {
                nextIceList.insert(Location(y: currentLocation.y, x: currentLocation.x))
                adjMatrix[ny][nx] = nextLocationNumber - 1
                if nextLocationNumber - 1 == 0 {
                    nextIceList.insert(Location(y: ny, x: nx))
                }
            }
        }
    }
    bfsQueue = Array(nextIceList)
    idx = 0
    result += 1
    let connectedComponent = getConnectedComponent()
    if connectedComponent >= 2 {
        break
    } else if connectedComponent == 0 {
        result = 0
        break
    }
}
print(result)
