//
//  main.swift
//  HideAndSeek
//
//  Created by Kay on 2023/01/26.
//

/*
 
 1697
 숨바꼭질
 */

/*
 수빈이의 위치가 X일때 1초 후 이동 가능한 거리
 X - 1, X + 1, X * 2
 
 visited 배열의 크기를 어떻게 잡아야 할까?
 수빈이의 현재 위치가 만약 100,000이라면 2 * X를 했을때 200,000이 될 수 있다. 그러므로 visited 배열의 크기는 200,000 + 1이 되어야 한다.
 BFS + 최단거리
 */

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


var visited = [Int](repeating: 0, count: 200001)

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0] // 수빈이의 위치
let K = NK[1] // 동생의 위치

if 0 <= N && N <= 100000 && 0 <= K && K <= 100000 {
    var bfsQueue = Queue<Int>()
    visited[N] = 1
    bfsQueue.enqueue(N)

    while !bfsQueue.isEmpty {
        let currentNumber = bfsQueue.dequeue()!
        if currentNumber == K {
            break
        }
        for i in 1...3 {
            var nextNumber = currentNumber
            if i == 1 {
                nextNumber -= 1
            } else if i == 2 {
                nextNumber += 1
            } else {
                nextNumber *= 2
            }
            if nextNumber < 0 || nextNumber > 200000 { continue }
            if visited[nextNumber] != 0 { continue }
            visited[nextNumber] = visited[currentNumber] + 1
            bfsQueue.enqueue(nextNumber)
        }
    }
    print(visited[K]-1)
}
