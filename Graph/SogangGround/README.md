# 14938 서강그라운드
- 다익스트라
- 최대값 찾기

## 🍎 지문 해석
- 예은이가 서강그라운드라는 게임을 하는데 여러 지역중 하나의 지역에 떨어진다. 그 지역으로부터 수색범위 M 이내의 모든 지역의 아이템 습득이 가능하다고 할 때, 예은이가 얻을 수 있는 아이템의 최대 개수를 찾아라!

## 🍎 문제 접근
- 1번 정점부터 N번 정점까지 순회하면서 기준이 되는 정점으로부터 다른 모든 정점까지의 최단거리를 다익스트라 알고리즘을 통해 얻고, 수색 범위 M안에 아이템을 얼마나 많이 가질수 있는지 확인 후 Result 변수를 갱신하면 된다.

## 🍎 문제 풀이 및 전체 코드
```swift
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
    
    init(_ node: Int, _ cost: Int) {
        self.node = node
        self.cost = cost
    }
}

let NMR = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMR[0] // 지역의 개수
let M = NMR[1] // 수색 범위
let R = NMR[2] // 길의 개수

let items = readLine()!.split(separator: " ").map { Int(String($0))! }
var connectionInfo = [[(Int,Int)]](repeating: [(Int,Int)](), count: N + 1)
for _ in 0..<R {
    let ftc = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = ftc[0]
    let to = ftc[1]
    let cost = ftc[2]
    connectionInfo[from].append((to,cost))
    connectionInfo[to].append((from,cost))
}


var result = Int.min
for i in 1...N {
    var costArr = [Int](repeating: Int.max, count: N + 1)
    var pq = Heap<EdgeNode>()
    pq.insert(EdgeNode(i,0))
    costArr[i] = 0
    
    while !pq.isEmpty {
        let current = pq.delete()!
        if costArr[current.node] < current.cost { continue }
        
        for info in connectionInfo[current.node] {
            let nextNode = info.0
            let costToNextNode = info.1
            let tempCost = current.cost + costToNextNode
            if tempCost < costArr[nextNode] {
                costArr[nextNode] = tempCost
                pq.insert(EdgeNode(nextNode, tempCost))
            }
        }
    }
    var tempResult = 0
    for j in 1..<costArr.count {
        if costArr[j] <= M {
            tempResult += items[j-1]
        }
    }
    result = result > tempResult ? result : tempResult
}
print(result)
```
