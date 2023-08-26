# 4485 녹색 옷 입은 애가 젤다지?
- 2차원 배열에서의 다익스트라
## 🍎 지문 해석
- 링크가 맵의 0,0 위치에서 출발 했을때, N-1, N-1까지 가장 적은 비용으로 가는 경우를 출력하면 된다.

## 🍎 문제 접근
- 다익스트라 시간복잡도 Nlog(N)
- 2차원 배열 탐색시 다익스트라 알고리즘의 시간복잡도 -> N^2log(N^2)
    - 여기서 log(N^2)은 2log(N)과 같고 상수배를 무시하면 log(N)
    - 즉, 이 문제의 시간복잡도는 N^2log(N) -> N^2이라고 생각 해도 된다.
- 큐에서 빠져나온 값을 토대로 그래프 탐색을 하면서 진행하면 된다.

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
    static func == (lhs: EdgeNode, rhs: EdgeNode) -> Bool {
        return lhs.cost == rhs.cost
    }
    
    var location: (Int,Int)
    var cost: Int
    
    static func < (lhs: EdgeNode, rhs: EdgeNode) -> Bool {
        return lhs.cost < rhs.cost
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var result = [String]()
var index = 1
while true {
    let N = Int(readLine()!)!
    if N == 0 { break }
    var pq = Heap<EdgeNode>(comparer: <) // min heap 생성
    var visited = [[Int]](repeating: [Int](repeating: Int.max, count: N), count: N) // 최소 금액 저장소
    var costMap = [[Int]]()
    for _ in 0..<N {
        let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
        costMap.append(temp)
    }
    pq.insert(EdgeNode(location: (0,0), cost: costMap[0][0]))
    visited[0][0] = costMap[0][0]
    while !pq.isEmpty {
        let current = pq.delete()!
        let cY = current.location.0
        let cX = current.location.1
        let cC = current.cost // currentCost
        
        for i in 0..<4 {
            let ny = cY + dy[i]
            let nx = cX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
            let totalCostToNextNode = cC + costMap[ny][nx]
            if totalCostToNextNode >= visited[ny][nx] { continue }
            visited[ny][nx] = totalCostToNextNode
            pq.insert(EdgeNode(location: (ny,nx), cost: totalCostToNextNode))
        }
    }
    result.append("Problem \(index): \(visited[N-1][N-1])")
    index += 1
}
result.enumerated().forEach {
    print($0.element)
}
```

