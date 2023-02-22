//
//  main.swift
//  Cheese
//
//  Created by Kay on 2023/02/22.
//

/*
 2636
 치즈
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var meltingList: [(Int,Int)] = []
var cheeseCount = 0
var totalTime = 0

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

//MARK: 치즈 녹이기
// -> adjMatrix에서 1이고 visited 하지 않았다면 치즈를 녹일 배열에 해당 치즈의 위치를 넣는다.
func findingLocationToMeltDFS(_ y: Int, _ x: Int) {
    visited[y][x] = 1
    if adjMatrix[y][x] == 1 {
        meltingList.append((y,x))
        return
    }
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == 1 { continue }
        findingLocationToMeltDFS(ny, nx)
    }
}

func visitedClear() {
    for i in 0..<N {
        for j in 0..<M {
            visited[i][j] = 0
        }
    }
}
//MARK: 실제로 치즈 녹이기
func melting() {
    meltingList.enumerated().forEach {
        adjMatrix[$0.element.0][$0.element.1] = 0
    }
    meltingList.removeAll()
}

//MARK: 치즈 갯수 구하기
func getNumberOfCheese() -> Int {
    var count = 0
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 1 {
                count += 1
            }
        }
    }
    return count
}

while getNumberOfCheese() != 0 {
    visitedClear()
    cheeseCount = getNumberOfCheese()
    findingLocationToMeltDFS(0,0)
    melting()
    totalTime += 1
    
}
print(totalTime)
print(cheeseCount)
