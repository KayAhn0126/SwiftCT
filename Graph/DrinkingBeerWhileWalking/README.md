# 9205 맥주 마시면서 걸어가기
- 맨해튼 거리

## 🍎 문제 접근
- 편의점을 위치를 기준으로 for 반복문으로 돌면서 현재 위치에서 다음 편의점 위치까지의 맨하탄 거리 1000m 이내인지 확인한다.

## 🍎 조심해야할 점
- x,y 위치가 바뀌어서 주어진다. -> 큐에 넣거나, 배열에 넣을때 y,x로 일관되게 넣었는지 꼼꼼하게 확인하기!

## 🍎 문제 풀이
```swift
import Foundation

var tc = Int(readLine()!)!

while tc != 0 {
    tc -= 1
    
    //페스티벌 까지 갈 수 있는지 확인하는 플래그 갈 수 있다면 true!
    var happyFlag = false
    let cvStoreCount = Int(readLine()!)!
    let homeLocation = readLine()!.split(separator: " ").map { Int(String($0))! }
    
    var bfsQueue: [(Int, Int)] = [], idx = 0
    bfsQueue.append((homeLocation[1], homeLocation[0]))
    
    var cvStoreLocation: [(Int, Int)] = []
    for _ in 0..<cvStoreCount {
        let location = readLine()!.split(separator: " ").map { Int(String($0))! }
        cvStoreLocation.append((location[1], location[0]))
    }
    
    //페스티벌 위치 입력 받기
    let destinationLocation = readLine()!.split(separator: " ").map { Int(String($0))! }
    
    var visited = [Bool](repeating: false, count: cvStoreCount + 1)
    
    //BFS 탐색
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        // 현재 위치에서 페스티벌까지 1000이하라면 갈 수 있다!
        if abs(currentLocation.0 - destinationLocation[1]) + abs(currentLocation.1 - destinationLocation[0]) <= 1000 {
            happyFlag = true
            break
        }
        
        // 위치마다 갈 수 있는지 체크 후 큐에 넣기
        for i in 0..<cvStoreLocation.count {
            if abs(cvStoreLocation[i].0 - currentLocation.0) + abs(cvStoreLocation[i].1 - currentLocation.1) <= 1000 {
                if visited[i] == true { continue }
                visited[i] = true
                bfsQueue.append((cvStoreLocation[i].0, cvStoreLocation[i].1))
            }
        }
    }
    if happyFlag == true {
        print("happy")
    } else {
        print("sad")
    }
}

```
