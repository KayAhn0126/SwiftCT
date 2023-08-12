# 1238 파티
- 다익스트라

## 🍎 지문 해석
- N개의 마을에 학생이 한명씩 살고 있다.
- 이 학생들이 X번 마을에 모여서 파티를 하기로 했다.
- 이 마을들 사이에는 총 M개의 단방향 도로들이 있고 이를 지나는데 T만큼 시간을 소비한다.
- 각각의 학생들은 파티에 참석 하기 위해 걸어가야 하고 끝나면 다시 그들의 마을로 돌아와야 한다.
- 학생들은 게을러서 최단 시간에 오고 가기를 원한다.
- 도로들은 단방향이기 때문에 오고 가는 길이 다를 수 있고, 그에 따른 비용도 다를 수 있다.
- 모든 학생들 중 오고 가는데 가장 많은 시간을 소비한 학생의 소요시간을 출력하면 된다.
- 최대 마을 or 학생 수는 1,000
- 최대 간선의 갯수는 10,000

## 🍎 문제 접근
- 문제의 예제를 통해 메인 로직을 알아보자.
- 4명의 학생 8개의 간선 정보 및 비용 2번 마을에서 파티.
- 먼저 두가지 케이스를 생각해야한다.
- 학생들이 X마을로 갈때 최단 시간으로 가는 경우
    - 1 -> 2
    - 2 -> 2
    - 3 -> 2
    - 4 -> 2
- 파티가 끝나고 학생들이 다시 그들의 마을로 갈때 최단 시간으로 가는 경우
    - 2 -> 1
    - 2 -> 2
    - 2 -> 3
    - 2 -> 4
- 다익스트라 알고리즘은 하나의 노드에서 다른 모든 노드까지의 최소 비용을 구하는 알고리즘이다.
- 즉,
    - 1번 마을에서 모든 마을까지의 최단 소요 시간.
    - 2번 마을에서 모든 마을까지의 최단 소요 시간.
    - 3번 마을에서 모든 마을까지의 최단 소요 시간.
    - ...
    - N번 마을에서 모든 마을까지의 최단 소요 시간.
- 최대 마을 수가 1,000명이고 마을에서 다른 마을로 갈 수 있는 경우는 999. 최악의 경우에도 1001 by 1001짜리 2차원 배열을 만들면 된다!
    - 굳이 1001 * 1001 크기의 배열 말고 N + 1 * N + 1 크기로 만들면 된다!
    - 즉, 이 2차원 배열은 학생들이 X마을까지 가는 경우, 파티가 끝나고 각자의 마을로 최단 시간으로 돌아오는 경우까지의 정보를 가진다.
    - costArr[어느 마을에서][어느 마을까지]의 형태를 가진다.

## 🍎 문제 풀이 및 전체 코드
### 📖 전체 코드를 보기전..
- 대략적인 순서
    - 연결 정보(from to cost)를 공백을 기준으로 받는다.
    - 1번 마을부터 시작해 N번 마을까지 자신의 마을을 기준으로 다른 모든 마을까지 최단시간을 구한다.
        - pq(min heap)을 만든다.
        - pq에 현재 마을(노드)번호와 자기 자신의 마을까지는 0만큼 걸리므로 0을 EdgeNode 구조체의 인스턴스 형태로 넣는다.
        - costArr[현재마을][현재마을]을 0으로 설정.
    - pq가 빌때까지 비용이 적은 노드를 계속 먼저 뽑아 이전의 값과 비교하면서 진행한다.
- 이 문제의 포인트 -> "**N명의 학생들 중 오고 가는데 가장 오래 걸리는 학생의 소요시간을 출력한다.**"를 코드로 보자!
```swift
var result = Int.min
for i in 1...N {
    // i(마을)에서 X(마을)까지의 최소비용 + X(마을)에서 i(마을)까지의 최소비용을 더한 후 그 중 가장 큰 값을 구한다.
    let temp = costArr[i][X] + costArr[X][i]
    if temp > result {
        result = temp
    }
}
print(result) 
```

### 📖 전체 코드
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
```
## 🍎 참고
- [Priority Queue 구현 출처](https://kayahn93.tistory.com/5)
