//
//  main.swift
//  Truck
//
//  Created by Kay on 2023/10/24.
//

/*
 13335
 트럭
 */

/*
 지문 해석:
    N = 트럭의 갯수 (1 <= N <= 1000)
    W = 다리의 길이 (1 <= W < 100)
    트럭들의 무게의 합은 다리의 최대하중인 L보다 작거나 같아야한다. (10 <= L <= 1000)
 
 문제 접근:
    길이측면에서 다리에 트럭이 더 올릴 수 있다 -> 다음 트럭의 무게를 올려본다.
    다음 트럭이 올라가면 트럭 출발.
 */

import Foundation

let NWL = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NWL[0]
let W = NWL[1]
let L = NWL[2]

var truckArr = readLine()!.split(separator: " ").map { Int(String($0))! }

var queue = [Int](repeating: 0, count: W)

var time = 0
var currentWeight = 0

// 트럭도 다 보내고 큐에 아무것도 없으면 끝
// 0은 언제 넣지? -> 다리를 건널 트럭이 있고 길이나 무게 둘 중 하나라도 안된다면!

while !queue.isEmpty {
    queue.removeFirst()
    if !truckArr.isEmpty {
        if L >= (currentWeight + truckArr[0]) && W >= queue.count {
            queue.append(truckArr[0])
            currentWeight += truckArr[0]
            truckArr.removeFirst()
        } else {
            queue.append(0)
        }
    }
    if !queue.isEmpty && queue[0] != 0 {
        currentWeight -= queue[0]
    }
    time += 1
}
print(time)
