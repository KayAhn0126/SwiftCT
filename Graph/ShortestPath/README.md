# 1753 최단경로
- 다익스트라

## 🍎 문제 접근
- 음의 가중치가 없는 그래프의 한 정점에서 모든 정점까지의 최단거리를 구하는 알고리즘을 사용해야 하므로 다익스트라 알고리즘을 사용.

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

// Heap에 들어가는 요소, 비교하기 위해서 Comparable 프로토콜을 채택.
// 다익스트라 알고리즘은 힌 정점에서 모든정점까지 도달하기 까지의 가장 작은 비용을 구하는 알고리즘이므로, 힙 중에서도 min heap을 사용한다.
// 이때 Heap의 요소로 사용되는 EdgeData 구조체를 Comparable하게 만들어 insert시, 구조체 내 cost 속성으로 비교해 가장 작은 비용을 가지고 있는 노드를 최상위로 올리게 한다.
struct EdgeData : Comparable{
    var node : Int
    var cost : Int
    
    static func < (lhs: EdgeData, rhs: EdgeData) -> Bool {
        lhs.cost < rhs.cost
    }
}


let inf = Int.max
let VE = readLine()!.split(separator: " ").map { Int(String($0))! }
let v = VE[0]
let e = VE[1]

let start = Int(readLine()!)! - 1

var graph = [[(Int,Int)]](repeating: [(Int,Int)]() , count: v) // 노드 - ()
for _ in 0..<e{
    let connectionInfo = readLine()!.split(separator: " ").map({ Int(String($0))!} )
    // node가 0번부터 시작하는 heap이라서 -1 전처리
    let from = connectionInfo[0] - 1
    let to = connectionInfo[1] - 1
    let cost = connectionInfo[2]
    graph[from].append((to, cost))
}

var costArr = [Int](repeating: inf, count: v)
costArr[start] = 0

var pq = Heap<EdgeData>()
pq.insert(EdgeData(node: start, cost: 0))

while(!pq.isEmpty){
    let now = pq.delete()!
    if costArr[now.node] < now.cost{
        continue
    }
    
    for connectedNodeInfo in graph[now.node] {   // 현재 노드와 연결되어 있는 노드의 정보 가져오기
        let nextNode = connectedNodeInfo.0       // 다음 노드
        let costToNextNode = connectedNodeInfo.1 // 현재 노드에서 다음 노드까지 가는데 드는 비용
        let tempCost = now.cost + costToNextNode // 현재 노드까지 오는 비용과 다음 노드에 도착했을때 비용 합산
        if tempCost < costArr[nextNode] {
            costArr[nextNode] = tempCost
            pq.insert(EdgeData(node: nextNode, cost: tempCost)) // 이때 pq에 insert 메서드를 통해 새로운 노드를 넣게되면 heap내에서 EdgeData끼리 비교한다. 이때 비교는 cost가 더 작은것을 비교한다.
            // 즉, 하나의 노드를 넣을때마다 cost가 가장 적은 노드가 최상위로 올라간다!
        }
    }
}

for i in costArr {
    if i == inf {
        print("INF")
    } else {
        print(i)
    }
}
```
