//
//  main.swift
//  PackageDelivery
//
//  Created by Kay on 2023/08/14.
//

/*
 5972
 택배 배송
 */

/* 지문 해석
    최소비용 - min heap
    헛간(정점) N (max 50000)
    길(간선) M - 양방향 (max 50000)
    소(비용) C (max 1000)
 
    문제 접근
    주어지는 간선을 양방향으로 연결해주고 우큐에 1,0을 넣어 시작하자
 */

import Foundation

public struct Heap<T> {
    var nodes: [T] = []
    let comparer: (T,T) -> Bool
    
    var isEmpty: Bool {
        return nodes.isEmpty
    }
    
    init(comparer: @escaping (T,T) -> Bool) {
        self.comparer = comparer
    }
    
    func peek() -> T? {
        return nodes.first
    }
    
    mutating func insert(_ element: T) {
        var index = nodes.count
        
        nodes.append(element)
        
        while index > 0, comparer(nodes[index], nodes[(index-1)/2]) {
            nodes.swapAt(index, (index-1)/2)
            index = (index-1)/2
        }
    }
    
    mutating func delete() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }
        
        if nodes.count == 1 {
            return nodes.removeFirst()
        }
        
        let result = nodes.first
        nodes.swapAt(0, nodes.count-1)
        _ = nodes.popLast()
        
        var index = 0
        
        while index < nodes.count {
            let left = index * 2 + 1
            let right = left + 1
            
            if right < nodes.count {
                if comparer(nodes[right], nodes[left]),
                   comparer(nodes[right], nodes[index]) {
                    nodes.swapAt(right, index)
                    index = right
                } else if comparer(nodes[left], nodes[index]){
                    nodes.swapAt(left, index)
                    index = left
                } else {
                    break
                }
            } else if left < nodes.count {
                if comparer(nodes[left], nodes[index]) {
                    nodes.swapAt(left, index)
                    index = left
                } else {
                    break
                }
            } else {
                break
            }
        }
        return result
    }
}

extension Heap where T: Comparable {
    init() {
        self.init(comparer: <) // min heap
        // self.init(comparer: >)  max heap
    }
}

struct EdgeNode: Comparable {
    var node: Int
    var cost: Int
    
    static func < (_ lhs: EdgeNode, _ rhs: EdgeNode) -> Bool {
        return lhs.cost < rhs.cost
    }
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var connectionInfo = [[(Int, Int)]](repeating: [(Int, Int)](), count: N + 1)

for _ in 0..<M {
    let info = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = info[0]
    let to = info[1]
    let cost = info[2]
    connectionInfo[from].append((to, cost))
    connectionInfo[to].append((from, cost))
}

var pq = Heap<EdgeNode>()
var costArr = [Int](repeating: Int.max, count: N + 1)

// 1부터 시작해서 N까지.
pq.insert(EdgeNode(node: 1, cost: 0))
costArr[1] = 0

while !pq.isEmpty {
    let current = pq.delete()!
    
    if costArr[current.node] < current.cost { continue }
    
    for info in connectionInfo[current.node] {
        let nextNode = info.0
        let costToNextNode = info.1
        let tempCost = current.cost + costToNextNode
        if tempCost < costArr[nextNode] {
            costArr[nextNode] = tempCost
            pq.insert(EdgeNode(node: nextNode, cost: tempCost))
        }
    }
}
print(costArr[N])
