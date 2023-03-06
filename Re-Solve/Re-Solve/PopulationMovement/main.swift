//
//  main.swift
//  PopulationMovement
//
//  Created by Kay on 2023/03/06.
//

/*
 16234
 인구이동
 */

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NLR = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NLR[0]
let L = NLR[1]
let R = NLR[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
//visited는 반복할때마다.

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


var sumList: [(Int,Int)] = []
var result = 0
while true {
    var needMoreMoveFlag = false
    var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == 0 {
                var bfsQueue = [(Int,Int)](), idx = 0
                bfsQueue.append((i,j))
                visited[i][j] = 1
                sumList.append((i,j))
                var populationTotal = adjMatrix[i][j]
                while idx < bfsQueue.count {
                    let currentLocation = bfsQueue[idx]; idx += 1
                    let currentY = currentLocation.0
                    let currentX = currentLocation.1
                    for i in 0..<4 {
                        let ny = currentY + dy[i]
                        let nx = currentX + dx[i]
                        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
                        if visited[ny][nx] > 0 { continue }
                        if L <= abs(adjMatrix[currentY][currentX] - adjMatrix[ny][nx]) && abs(adjMatrix[currentY][currentX] - adjMatrix[ny][nx]) <= R {
                            sumList.append((ny,nx))
                            populationTotal += adjMatrix[ny][nx]
                            visited[ny][nx] = 1
                            bfsQueue.append((ny,nx))
                        }
                    }
                }
                let sumListCount = sumList.count
                if sumListCount > 1 {
                    sumList.enumerated().forEach {
                        adjMatrix[$0.element.0][$0.element.1] = populationTotal / sumListCount
                    }
                    needMoreMoveFlag = true
                }
                sumList.removeAll()
            }
        }
    }
    if needMoreMoveFlag == false {
        break
    }
    result += 1
}
print(result)
