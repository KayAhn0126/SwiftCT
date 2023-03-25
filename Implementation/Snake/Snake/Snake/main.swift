//
//  main.swift
//  Snake
//
//  Created by Kay on 2023/03/20.
//

/*
 3190
 뱀
 */

/*
 ny,nx로 머리가 먼저 가고,
 만약 사과가 있으면 사과는 없어지고 꼬리는 없어지지 않는다.
 사과가 없다면 꼬리는 없어진다.
 
 사과의 위치와 뱀의 이동경로가 주어질 때, 이 게임이 몇초에 끝나는지 계산.
 
 사과의 위치는 배열로 저장.
 턴은 딕셔너리로 저장.
 dy, dx + (왼쪽) -> + 3 % 4  (오른쪽) -> + 1 % 4
 */

import Foundation

struct Queue<T> {
    var enQueue: [T] = []
    var deQueue: [T] = []
    
    var count: Int {
        return enQueue.count + deQueue.count
    }
    
    var isEmpty: Bool {
        return enQueue.isEmpty && deQueue.isEmpty
    }
    
    var last: T? {
        if enQueue.isEmpty {
            return deQueue.first
        }
        return enQueue.last
    }
    mutating func enqueue(_ element: T) {
        enQueue.append(element)
    }
    
    mutating func dequeue() -> T {
        if deQueue.isEmpty {
            deQueue = enQueue.reversed()
            enQueue.removeAll()
        }
        return deQueue.popLast()!
    }
}


let N = Int(readLine()!)!

let appleCount = Int(readLine()!)!
var appleMatrix = [[Int]](repeating: [Int](repeating: 0, count: N+1), count: N+1)
for _ in 0..<appleCount {
    let location = readLine()!.split(separator: " ").map { Int(String($0))! }
    appleMatrix[location[0]][location[1]] = 1
}

let turnCount = Int(readLine()!)!
var turnStorage: [Int: Character] = [:]
for _ in 0..<turnCount {
    let order = readLine()!.split(separator: " ").map { String($0) }
    turnStorage[Int(order[0])!] = Character(order[1])
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var time = 0
var currentSnakeMap = [[Int]](repeating: [Int](repeating:0, count: N+1), count: N+1)
var snakeQueue = Queue<(Int,Int)>()
var currentDirection = 1
currentSnakeMap[1][1] = -1
snakeQueue.enqueue((1,1))

// 현재 뱀이 있는 위치는 -1

while true {
    time += 1
    
    let currentHead = snakeQueue.last!
    let ny = currentHead.0 + dy[currentDirection]
    let nx = currentHead.1 + dx[currentDirection]

    if ny < 1 || nx < 1 || ny > N || nx > N || currentSnakeMap[ny][nx] == -1 {
        break
    }
    currentSnakeMap[ny][nx] = -1
    snakeQueue.enqueue((ny,nx))
    
    if appleMatrix[ny][nx] == 1 {
        appleMatrix[ny][nx] = 0
    } else {
        let tailLocation = snakeQueue.dequeue()
        currentSnakeMap[tailLocation.0][tailLocation.1] = 0
    }
    
    if turnStorage[time] != nil {
        let secondDirectionDictionary = turnStorage[time]
        if secondDirectionDictionary! == "D" {
            currentDirection = (currentDirection + 1) % 4
        } else {
            currentDirection = (currentDirection + 3) % 4
        }
    }
}
print(time)
