//
//  main.swift
//  Fire
//
//  Created by Kay on 2023/01/19.
//

/*
 4179
 불!
 */
// 3rd week fast campus

import Foundation

struct Queue<T> {
    var enqueueList: [T] = []
    var dequeueList: [T] = []
    
    var count: Int {
        return enqueueList.count + dequeueList.count
    }
    
    var isEmpty: Bool {
        return enqueueList.isEmpty && dequeueList.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enqueueList.append(element)
    }
    
    mutating func dequeue() -> T? {
        if dequeueList.isEmpty {
            dequeueList = enqueueList.reversed()
            enqueueList.removeAll()
        }
        return dequeueList.popLast()
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = userInput[0]
let C = userInput[1]

let INF = 987654321

var adjMatrix = [[Character]](repeating: [Character](), count: R)
var fireVisited = [[Int]](repeating: [Int](repeating: INF, count: C), count: R)
var jihoonVisited = [[Int]](repeating: [Int](repeating: 0, count: C), count: R)

for i in 0..<R {
    adjMatrix[i].append(contentsOf: readLine()!)
}


var fireLocationQueue = Queue<(Int,Int)>()
var jihoonLocationQueue = Queue<(Int,Int)>()

for i in 0..<R {
    for j in 0..<C {
        if adjMatrix[i][j] == "F" {
            fireVisited[i][j] = 1
            fireLocationQueue.enqueue((i,j))
        } else if adjMatrix[i][j] == "J" {
            jihoonVisited[i][j] = 1
            jihoonLocationQueue.enqueue((i,j))
        }
    }
}

func checkInRange(_ ny: Int, _ nx: Int) -> Bool {
    if ny < 0 || nx < 0 || ny >= R || nx >= C { return true }
    return false
}

func escapeCheck(_ ny: Int, _ nx: Int) -> Bool {
    if ny == 0 || nx == 0 || ny == R-1 || nx == C-1 { return true }
    return false
}

// MARK: - 불 확산
while !fireLocationQueue.isEmpty {
    let location = fireLocationQueue.dequeue()!
    let locY = location.0
    let locX = location.1
    for i in 0..<4 {
        let ny = locY + dy[i]
        let nx = locX + dx[i]
        if checkInRange(ny, nx) { continue }
        if fireVisited[ny][nx] != INF || adjMatrix[ny][nx] == "#" { continue }
        fireVisited[ny][nx] = fireVisited[locY][locX] + 1
        fireLocationQueue.enqueue((ny,nx))
    }
}

// MARK: - 지훈이가 다닐수 있는 경로(최단거리) 구하면서 불이 퍼지는 속도보다 작은지 확인하기
var result = 0
while !jihoonLocationQueue.isEmpty {
    let location = jihoonLocationQueue.dequeue()!
    let locY = location.0
    let locX = location.1
    if escapeCheck(locY, locX) {
        result = jihoonVisited[locY][locX]
        break
    }
    for i in 0..<4 {
        let ny = locY + dy[i]
        let nx = locX + dx[i]
        if checkInRange(ny, nx) { continue }
        if jihoonVisited[ny][nx] != 0 || adjMatrix[ny][nx] == "#" { continue }
        if jihoonVisited[locY][locX] + 1 >= fireVisited[ny][nx] { continue }
        jihoonVisited[ny][nx] = jihoonVisited[locY][locX] + 1
        jihoonLocationQueue.enqueue((ny,nx))
    }
}

if result == 0 {
    print("IMPOSSIBLE")
} else {
    print(result)
}
