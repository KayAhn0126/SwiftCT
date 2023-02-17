//
//  main.swift
//  Laboratory2
//
//  Created by Kay on 2023/02/17.
//

/*
 17141
 연구소2
 */
import Foundation

// BFS + 최단거리 + 조합(nCr) + 브루트포스

// 1. BFS는 큐부터 구현
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
// 2. 조합

func combination<T>(_ arr: [T], _ number: Int) -> [[T]] {
    var result: [[T]] = []
    if arr.count < number { return result }
    
    func cycle(_ now: [T], _ index: Int) {
        if now.count == number {
            result.append(now)
            return
        }
        for i in index..<arr.count {
            cycle(now + [arr[i]], i + 1)
        }
    }
    cycle([], 0)
    return result
}


