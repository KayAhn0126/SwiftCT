//
//  main.swift
//  HideAndSeek2
//
//  Created by Kay on 2023/01/27.
//

/*
 12851
 숨바꼭질 2
 */

/*
 문제를 보고 난 후.
 숨바꼭질과 지문이 똑같은데 다른점은 숨바꼭질에서는 가장 빠른 시간을 출력하는것만 했다라면, 이 문제는 방법의 수를 출력해야 한다.
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

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var bfsQueue = Queue<Int>()

var visited = [Int](repeating: 0, count: 200001)
var waysToFind = [Int](repeating: 0, count: 200001)

visited[N] = 1
waysToFind[N] = 1
bfsQueue.enqueue(N)

if N == K {
    print(0)
    print(1)
} else {
    if 0 <= N && N <= 100000 && 0 <= K && K <= 100000 {
        while !bfsQueue.isEmpty {
            let currentNumber = bfsQueue.dequeue()!
            
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
                if visited[nextNumber] == 0 {
                    visited[nextNumber] = visited[currentNumber] + 1
                    waysToFind[nextNumber] += waysToFind[currentNumber]
                    bfsQueue.enqueue(nextNumber)
                } else if visited[nextNumber] == visited[currentNumber] + 1 {
                    waysToFind[nextNumber] += waysToFind[currentNumber]
                }
                
            }
        }
    }
    print(visited[K] - 1)
    print(waysToFind[K])
}

