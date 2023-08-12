//
//  main.swift
//  Party
//
//  Created by Kay on 2023/08/12.
//

/*
 1238
 파티
 */

/*
 지문 해석 -
 N개의 마을에 각각 1명의 학생들이 살고 있다.
 이 N명의 학생이 X번 마을에 모여서 파티를 벌이기로 했는데 이 마을 사이에는 총 M개의 단방향 도로들이 있고, i번째 길을 지나는데 T의 시간을 소비한다.
 학생들은 파티에 참석하기 위해 걸어갔다가 다시 그들의 마을로 돌아와야 한다.
 학생들은 게을러서 최단 시간ㅌ에 오고 가기를 원한다.
 도로들은 단 방향이기 때문에 그들이 오고 가는 길이 다를지도 모른다.
 N명의 학생들 중 오고 가는데 가장 많은 시간을 소비하는 학생은 누구인지 구해라.
 
 문제 접근
 예제 처럼 4명의 학생이 2번 마을에 모인다고 해보자.
 1 -> 2
 2 -> 2
 3 -> 2
 4 -> 2
 
 이제 학생들이 돌아간다면,
 2 -> 1
 2 -> 2
 2 -> 3
 2 -> 4
 
 시간 복잡도 -> 학생이 1000명이고, 간선의 갯수가 10,000개라면 -> O(10000)
 공간복잡도 -> 2차원배열 행 1000개 열 1000
 
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

let NMX = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMX[0]
let M = NMX[1]
let X = NMX[2]
var costArr = [[Int]](repeating: [Int](repeating: Int.max, count: N + 1), count: N + 1)
var connectionInfo = [[(Int,Int)]](repeating: [(Int,Int)](), count: N + 1)
for _ in 0..<M {
    let fromToCost = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromToCost[0]
    let to = fromToCost[1]
    let cost = fromToCost[2]
    connectionInfo[from].append((to, cost))
}

for i in 1...N {
    var pq = Heap<EdgeNode>(comparer: <)
    pq.insert(EdgeNode(node: i, cost: 0))
    costArr[i][i] = 0
    
    while !pq.isEmpty {
        let now = pq.delete()!
        if costArr[i][now.node] < now.cost { continue }
        
        for info in connectionInfo[now.node] {
            let nextNode = info.0
            let costToNextNode = info.1
            let tempCost = now.cost + costToNextNode
            if tempCost < costArr[i][nextNode] {
                costArr[i][nextNode] = tempCost
                pq.insert(EdgeNode(node: nextNode, cost: tempCost))
            }
        }
    }
}
var result = Int.min
for i in 1...N {
    let temp = costArr[i][X] + costArr[X][i]
    if temp > result {
        result = temp
    }
}
print(result)
