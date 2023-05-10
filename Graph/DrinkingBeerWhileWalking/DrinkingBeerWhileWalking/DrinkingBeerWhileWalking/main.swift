//
//  main.swift
//  DrinkingBeerWhileWalking
//
//  Created by Kay on 2023/03/30.
//

/*
 9205
 맥주 마시면서 걸어가기
 */

/*
 문제 정의
 집에서 출발하면서 편의점에 들르면서 목적지까지 도착할 수 있는지 묻는 문제
 
 집에서부터 BFS한다.
 무엇을 BFS? 편의점 위치들을 BFS!
 그러기 위해선 편의점 위치들을 배열로 받는다.
 |편의점 위치| + | 현재위치 | 했을때 1000이하여야 한다.
 이미 방문한 편의점이라면 제외시켜준다.
 큐가 끝났을때 visited[목적지] = 1 이라면 happy, 아니면 sad 출력
 
 두 좌표 사이의 거리는 | x좌표의 차이 | + | y좌표의 차이 |
 
 x,y 형식으로 주어진다.
 딱히 바꾸지는 않아도 문제는 풀 수 있지만, y,x로 고쳐 문제를 풀자!
 */

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
