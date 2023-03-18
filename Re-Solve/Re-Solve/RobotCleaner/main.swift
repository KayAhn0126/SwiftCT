//
//  main.swift
//  RobotCleaner
//
//  Created by Kay on 2023/03/18.
//

/*
 14503
 로봇 청소기
 */

/*
 왼쪽으로 방향전환 -> (current + 3) % 4
 뒤로 방향 전환 -> (current + 2) % 4
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

let currentLocation = readLine()!.split(separator: " ").map { Int(String($0))! }
var currentY = currentLocation[0]
var currentX = currentLocation[1]
var currentD = currentLocation[2] // Direction

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

// 0 청소 안된 칸
// 1은 벽
// 2는 청소한 칸

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]
var turnCount = 0
var result = 0

while true {
    if adjMatrix[currentY][currentX] == 0 {
        adjMatrix[currentY][currentX] = 2
        result += 1
    }
    turnCount = 0
    for i in 0..<4 {
        let nextDirection = (currentD + 3 - i) % 4
        let nextY = currentY + dy[nextDirection]
        let nextX = currentX + dx[nextDirection]
        if nextY < 0 || nextX < 0 || nextY >= N || nextX >= M { continue }
        if adjMatrix[nextY][nextX] == 0 {
            turnCount += 1
            currentY = nextY
            currentX = nextX
            currentD = nextDirection
            break
        }
    }
    if turnCount == 0 {
        let backDirection = (currentD + 2) % 4
        let backY = currentY + dy[backDirection]
        let backX = currentX + dx[backDirection]
        if backY < 0 || backX < 0 || backY >= N || backX >= M || adjMatrix[backY][backX] == 1 {
            print(result)
            break
        }
        currentY = backY
        currentX = backX
    }
}
