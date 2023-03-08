//
//  main.swift
//  Junan
//
//  Created by Kay on 2023/03/07.
//

/*
 14497
 주난의 난
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

let locations = readLine()!.split(separator: " ").map { Int(String($0))! }
let junanLocationY = locations[0] - 1
let junanLocationX = locations[1] - 1
let theftLocationY = locations[2] - 1
let theftLocationX = locations[3] - 1

var adjMatrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var zeroBfsQueue = [(Int,Int)](), zeroIndex = 0
visited[junanLocationY][junanLocationX] = 1
zeroBfsQueue.append((junanLocationY, junanLocationX))
var result = 0

while adjMatrix[theftLocationY][theftLocationX] != "0" {
    result += 1
    var oneBfsQueue = [(Int,Int)]()
    while zeroIndex < zeroBfsQueue.count {
        let currentLocation = zeroBfsQueue[zeroIndex]; zeroIndex += 1
        let currentLocationY = currentLocation.0
        let currentLocationX = currentLocation.1
        for i in 0..<4 {
            let ny = currentLocationY + dy[i]
            let nx = currentLocationX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] != 0 { continue }
            visited[ny][nx] = result
            if adjMatrix[ny][nx] != "0" {
                adjMatrix[ny][nx] = "0"
                oneBfsQueue.append((ny,nx))
            } else {
                zeroBfsQueue.append((ny,nx))
            }
        }
    }
    zeroBfsQueue = oneBfsQueue
    zeroIndex = 0
}
print(visited[theftLocationY][theftLocationX])
