# Priority Queue
- Priority Queue의 실질적인 자료구조인 Heap을 먼저 알아보자!

## 🍎 Heap이란?
- 자료구조이다.
- 우선순위 큐와 힙은 같은거 아닌가? -> 아니다!
    - Priority Queue = Abstract Data Type -> 실제로 구현을 설명하지 않고, 어떤 동작들이 있는지 '개념적인' 것.
    - 반면 Heap은 data structure다. 즉 구현까지 되어있는 "하나의 자료 구조"라는 것.
    - Priority Queue == Heap이라고 알려져 있는데 이는 사실이 아니다. 다만 Priority Queue를 구현하기 위한 자료구조로 Heap 자료구조가 가장 많이 사용 돼서 둘이 같은 개념이라고 생각하는것이다.
    - **힙의 키(min/max)를 우선순위로 사용한다면, 힙은 우선순위 큐의 구현체가 된다**

## 🍎 Heap의 특징
- 힙은 완전 이진 트리 자료구조로 표현되는데, 트리가 균형 잡혀 있을 수 밖에 없다는 특징 때문에 시간 복잡도 NlogN을 보장한다.
    - 완전 이진 트리란?
        - 루트노드부터 시작하여 왼쪽 자식 노드, 오른쪽 자식 노드 순서대로 데이터가 차례대로 삽입되는 트리
- **힙은 항상 루트 노드를 제거한다.**

## 🍎 최소 힙 / 최대 힙
- 최소 힙 -> 루트 노드가 가장 작은 값을 가진다.
- 최대 힙 -> 루트 노드가 가장 큰 값을 가진다.

### 📖 Heapify 알아두기
- 상향 (추가 시) -> 맨 마지막에 추가된다. 이후, 부모 노드로 거슬로 올라가며 부모보다 자신의 값이 더 작거나 큰 경우, 위치를 swap한다.
- 하향 (제거 시) -> 루트노드가 제거되고 그 자리를 트리의 마지막 노드로 채운다. 이후, 키(min / max)에 따라 내려가는데,
    - 만약 min heap일때, 자식 노드들이 모두 현재 노드보다 작다면 그 중 더 작은 노드와 swap한다.
    - 만약 max heap인 경우, 자식 노드들이 모두 현재 노드보다 크다면 그 중 더 큰 노드와 swap한다.
- 노드의 하향 후, 같은 depth에 있는 노드들의 순서는 중요하지 않다.

### 📖 절차 알아보기
- 최소 힙을 구현한다고 가정해보자. 추가, 제거 시, 아래와 같은 절차가 진행된다.
    - 추가
        - 새로운 데이터가 추가 되면 트리의 맨 마지막에 추가해준다.
        - 추가된 데이터는 자신의 부모노드와 비교하면서 자신이 더 작을 동안에는 계속 자리를 바꿔주면서 depth를 올라간다.
    - 제거
        - 마지막 노드와 루트 노드의 위치를 바꿔준다. -> 루트 노드(가장 작은 값)이 트리의 마지막에 위치하게 되고 이때 트리의 마지막을 제거한다.
        - 현재 루트노드로 온 값을 자식 노드들과 비교하면서 현재 노드가 더 크다면 둘중 더 값이 작은 노드와 위치를 바꾸면서 depth를 내려간다.

## 🍎 라이노님의 힙
```swift
import Foundation

// 주석은 최소힙을 기준으로 작성
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

      while index > 0, !comparer(nodes[index],nodes[(index-1)/2]) {
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

          if right < nodes.count { // 만약 자식 노드중 오른쪽 노드가 있다면,
              if comparer(nodes[left], nodes[right]),
                  !comparer(nodes[right], nodes[index]) { // 왼쪽이 오른쪽보다 크고, 오른쪽 노드가 현재 노드보다 작다면
                  nodes.swapAt(right, index) // 오른쪽 노드를 현재 노드와 바꿔준다.
                  index = right
              } else if !comparer(nodes[left], nodes[index]){ // 왼쪽노드가 현재 노드보다 작다면
                  nodes.swapAt(left, index)
                  index = left
              } else { // 위의 두 케이스 모두 아니라면 더 이상 할 일이 없으므로 while문 종료.
                  break
              }
          } else if left < nodes.count { // 자식 노드 중 왼쪽 노드만 있다면,
              if !comparer(nodes[left], nodes[index]) { // 왼쪽 노드가 현재 노드보다 작다면
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
        self.init(comparer: >) // min heap
        // self.init(comparer: <) // max heap
    }
}

// 힙 만들고 테스트!
var myHeap = Heap<Int>() // 기본적으로 min heap
myHeap.insert(3)
myHeap.insert(4)
myHeap.insert(5)
myHeap.insert(2)
myHeap.insert(9)
print(myHeap)
```
- [라이노님의 힙 구현](https://gist.github.com/JCSooHwanCho/a3f070c2160bb8c0047a5ddbb831f78e)

## 🍎 조금 개선해보자!
- [라이노님의 블로그](https://jcsoohwancho.github.io/2019-11-05-Heap%EC%9E%90%EB%A3%8C%EA%B5%AC%EC%A1%B0/)를 보면 위의 코드는 c++의 힙 자료구조를 기반으로 구현되었다. 그래서 그런지 인스턴스 생성시 인자로 필요한 부등호 때문에 min heap인지 max heap인지 헷갈린다.
    - 위의 코드에서는 > 가 min heap, < 가 max heap이다.
- < 를 min heap, > 를 max heap으로 바꿔보자!
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
```
