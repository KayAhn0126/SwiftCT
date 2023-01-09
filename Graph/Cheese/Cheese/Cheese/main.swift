//
//  main.swift
//  Cheese
//
//  Created by Kay on 2023/01/09.
//

/*
 2636
 치즈
 */
// 2nd week fast campus

/*
 공기를 만나면 없어진다 -> 1이 0과 닿아있다면 없어진다.
 */
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

var meltingSpot = [(Int, Int)]()
var meltingVisited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)

var totalMeltingTime = 0
var cheesePiecesAnHourAgo = 0


for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


// MARK: - 가장 바깥에 있는 1(치즈)를 찾고 meltingSpot 배열에 넣기
func meltingDFS(_ y: Int, _ x: Int) {
    meltingVisited[y][x] = true
    if adjMatrix[y][x] == 1 {
        meltingSpot.append((y,x))
        return
    }
    
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M || meltingVisited[ny][nx] == true { continue }
        meltingDFS(ny, nx)
    }
}

// MARK: - 녹일 치즈 위치를 이용해 치즈 판 업데이트
func melting() {
    cheesePiecesAnHourAgo = 0
    meltingVisited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)
    meltingDFS(0,0)
    meltingSpot.enumerated().forEach {
        cheesePiecesAnHourAgo += 1
        adjMatrix[$0.element.0][$0.element.1] = 0
    }
    meltingSpot.removeAll()
}

// MARK: - 남아있는 치즈가 있는지 확인하는 함수
func isAdjMatrixHasSomething() -> Bool {
    var flag = false
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 1 {
                flag = true
            }
        }
    }
    return flag
}

while isAdjMatrixHasSomething() {
    melting()
    totalMeltingTime += 1
}

print(totalMeltingTime)
print(cheesePiecesAnHourAgo)

