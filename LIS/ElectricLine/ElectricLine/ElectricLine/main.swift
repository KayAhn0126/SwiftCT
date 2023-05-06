//
//  main.swift
//  ElectricLine
//
//  Created by Kay on 2023/05/06.
//

/*
 2565
 전깃줄
 */

//MARK: 서로 교차하지 않게 하기 위해 없애야 하는 전깃줄의 최소 개수를 구해야 한다.
//MARK: 그럼 최대 증가 수열의 갯수를 구하고 전체(현재 주어진 전깃줄 수)에서 빼는 방법으로 접근한다.

import Foundation

let num = Int(readLine()!)!

// 정렬이 필요한가? -> 처음엔 필요 없다고 생각했는데, from을 오름차순으로 놓으면 최대값이 도출된다.

var arr: [(Int,Int)] = []
var dp = [Int](repeating: 0, count: num)

for _ in 0..<num {
    let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromTo[0]
    let to = fromTo[1]
    arr.append((from, to))
}

arr = arr.sorted(by: {
    return $0.0 < $1.0
})

var result = Int.min
for i in 0..<num {
    var latest = 0
    for j in 0..<i {
        if arr[j].0 < arr[i].0 && arr[j].1 < arr[i].1 && latest < dp[j] {
            latest = dp[j]
        }
    }
    dp[i] = latest + 1
    result = dp[i] > result ? dp[i] : result
}
print(num - result)
