# 1504 특정한 최단 경로
- 우선순위 큐를 사용한 다익스트라

## 🍎 지문 해석
- 방향성이 없는 그래프 -> 양방향 그래프
- 1번정점에서 N번정점으로 최단거리로 이동하려는데 주어지는 두 정점을 반드시 통과해야한다.

## 🍎 문제 접근
- 다익스트라 알고리즘의 특징을 잘 생각해야하는 문제다.
- 다익스트라 알고리즘은 가중치에 음수가 없는 그래프 내 한 정점에서 다른 모든 정점까지의 최단거리를 알아내는 알고리즘이다.
- 문제에서 원하는것을 알아보자.
    - 문제에서 주어지는 두개의 정점을 V1, V2라고 하자.
    - 1번부터 V1, V2, 노드를 꼭 방문하면서 N까지 오는 최단거리이다. 이때 V1을 먼저 방문하던 V2를 먼저 방문하던 상관없다.
    - 다만 가장 짧은 거리를 출력하기만 하면된다.
- 조금 더 자세히 알아보자.
- 세준이가 1번 정점에서 N번까지 V1 정점과 V2 정점을 꼭 지나서 N 정점까지 가야하는 경우는 아래의 경우와 같다.
```bash
1 -> V1 -> V2 -> N
    1번 정점에서 출발해서 V1 정점까지의 최단 거리
    V1 정점에서 출발해서 V2 정점까지의 최단 거리
    V2 정점에서 출발해서 N 정점까지의 최단 거리
    (각 정점 사이에 다른 정점이 있을 수 있다)

        OR
        
1 -> V2 -> V1 -> N
    1번 정점에서 출발해서 V2 정점까지의 최단 거리
    V2 정점에서 출발해서 V1 정점까지의 최단 거리
    V1 정점에서 출발해서 N 정점까지의 최단 거리
    (각 정점 사이에 다른 정점이 있을 수 있다)
```
- 간선의 정보를 connectionInfo에 양방향 간선으로 집어 넣고 1번, V1, V2 정점 기준 각각 최단거리를 구하고 그 중 필요한 정보만 사용하면 된다.
- 예를 들면 1 -> V1 -> V2 -> N을 구한다고 했을때,
    - 1번을 기준으로 다른 모든 정점까지의 거리를 구하고, 그 중 1에서 V1까지 얼마나 걸리는지 사용하면 된다.
    - V1 정점을 기준으로 다른 모든 정점까지의 거리를 구하고, 그 중 V1에서 V2까지 얼마나 걸리는지 사용하면 된다.
    - V2 정점을 기준으로 다른 모든 정점까지의 거리를 구하고, 그 중 V2에서 N까지 얼마나 걸리는지 사용하면 된다.

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
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // 정점
let M = NM[1] // 간선 (Bidirectional)

var connectionInfo = [[(Int,Int)]](repeating: [(Int,Int)](), count: N + 1)

for _ in 0..<M {
    let info = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = info[0]
    let to = info[1]
    let cost = info[2]
    connectionInfo[from].append((to, cost))
    connectionInfo[to].append((from, cost))
}

let v1v2 = readLine()!.split(separator: " ").map { Int(String($0))! }
let V1 = v1v2[0]
let V2 = v1v2[1]

let INF = 999999999
func getShortestPath(_ startNode: Int) -> [Int] {
    var visited = [Int](repeating: INF, count: N + 1)
    var pq = Heap<EdgeNode>()
    pq.insert(EdgeNode(node: startNode, cost: 0))
    visited[startNode] = 0
    
    while !pq.isEmpty {
        let current = pq.delete()!
        if visited[current.node] < current.cost { continue }
        
        for info in connectionInfo[current.node] {
            let nextNode = info.0
            let costToNextNode = info.1
            let tempCost = current.cost + costToNextNode
            
            if visited[nextNode] > tempCost {
                visited[nextNode] = tempCost
                pq.insert(EdgeNode(node: nextNode, cost: tempCost))
            }
        }
    }
    return visited
}

let spFromStartToN = getShortestPath(1) // 1부터 N까지의 모든 정점으로 가는 최단거리
let spFromV1ToN = getShortestPath(V1)   // V1부터 N까지의 모든 정점으로 가는 최단거리
let spFromV2ToN = getShortestPath(V2)   // V2부터 N까지의 모든 정점으로 가는 최단거리


// 1 -> V1 -> V2 -> N의 값
let resultOf1V1V2N = spFromStartToN[V1] + spFromV1ToN[V2] + spFromV2ToN[N]
// 1 -> V2 -> V1 -> N의 값
let resultOf1V2V1N = spFromStartToN[V2] + spFromV2ToN[V1] + spFromV1ToN[N]

// 위의 두개의 상수중 더 작은 값을 result에 넣어준다.
var result = min(resultOf1V1V2N, resultOf1V2V1N)
// 두 상수 중 하나라도 제대로 연결이 안되어있다면 다익스트라 알고리즘 특성상 "연결되어있지 않아 갈 수 없다는 의미"로 기존 배열에 설정해두었던 값이 바뀌지 않는데 이 경우 -1을 출력하면 된다.
if resultOf1V1V2N >= INF {
    print(-1)
} else {
    print(result)
}
```
