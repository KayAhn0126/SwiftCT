//
//  main.swift
//  Mutalisk
//
//  Created by Kay on 2023/01/26.
//

/*
 12869
 뮤탈리스크
 */
// 3rd week fast campus

/*
 
 뮤탈 1마리
 SCV 1 ~ 3마리
 
 어떤 SCV가 첫 공격을 맞을지 모른다. 9,3,1로 순열 만들기
 
 1마리가 주어진다면 num 0 0
 2마리가 주어진다면 num num 0
 3마리가 주어진다면 num num num
 
 */

import Foundation

func pmwr<T>(_ arr: [T], _ num: Int) -> [[T]] { // pmwr -> permutation with recursive
    var result = [[T]]()
    if arr.count < num { return result }
    
    var visited = [Bool](repeating: false, count: num)
    func cycle(_ now: [T]) {
        if now.count == num {
            result.append(now)
            return
        }
        
        for i in 0..<arr.count {
            if visited[i] {
                continue
            } else {
                visited[i] = true
                cycle(now + [arr[i]])
                visited[i] = false
            }
        }
    }
    cycle([])
    return result
}

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


var given = [9,3,1]
var givenAfterPermutation = pmwr(given, 3)

let scvCount = Int(readLine()!)!
var scvArr = readLine()!.split(separator: " ").map { Int(String($0))! }

while scvArr.count != 3 {
    scvArr.append(0)
}

var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 61), count: 61), count: 61)

struct scvHp<T> {
    var first: T
    var second: T
    var third: T
}

var bfsQueue = Queue<scvHp<Int>>()

var originalHP = scvHp(first: scvArr[0], second: scvArr[1], third: scvArr[2])
visited[scvArr[0]][scvArr[1]][scvArr[2]] = 1
bfsQueue.enqueue(originalHP)

while !bfsQueue.isEmpty {
    let HP = bfsQueue.dequeue()
    let first = HP!.first
    let second = HP!.second
    let third = HP!.third
    if first == 0 && second == 0 && third == 0 {
        break
    }
    for i in 0..<givenAfterPermutation.count {
        let nFirst = max(0, first - givenAfterPermutation[i][0])
        let nSecond = max(0, second - givenAfterPermutation[i][1])
        let nThird = max(0, third - givenAfterPermutation[i][2])
        if visited[nFirst][nSecond][nThird] != 0 { continue }
        visited[nFirst][nSecond][nThird] = visited[first][second][third] + 1
        bfsQueue.enqueue(scvHp(first: nFirst, second: nSecond, third: nThird))
    }
}

print(visited[0][0][0] - 1)
