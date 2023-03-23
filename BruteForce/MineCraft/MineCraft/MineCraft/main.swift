//
//  main.swift
//  MineCraft
//
//  Created by Kay on 2023/03/23.
//

/*
 18111
 마인크래프트
 */

/*
 처음 생각
 평균 구하기 TC -> 500 * 500 = 250000
 Simplify problem
 블록 제거 -> 비용 2
 블록 추가 -> 비용 1
 
 문제 발생!
 전체에서 브루트포스로 체크해봐야한다. -> 맵에서 최소값과 최대값의 범위가 엄청날 수 있다!
 */


/* 시간초과 코드
import Foundation

let NMB = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMB[0]
let M = NMB[1]
let B = NMB[2]

var arr = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    arr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var totalCost = 9999999999999
var result = 0

for k in 0...256 {
    var tempResult = 0
    if k >= 0 {
        var tempB = B
        var count = 0
        for i in 0..<N {
            for j in 0..<M {
                count = 0
                let currentNumber = arr[i][j]
                if k > arr[i][j] {
                    while k != currentNumber + count {
                        tempB -= 1
                        count += 1
                        tempResult += 1
                    }
                    
                    
                } else if k == currentNumber {
                    continue
                } else {
                    while k != currentNumber - count {
                        tempB += 1
                        count += 1
                        tempResult += 2
                    }
                }
            }
        }
        if tempB >= 0 {
            if totalCost > tempResult {
                totalCost = tempResult
                result = k
            }
        }
    }
}
print("\(totalCost) \(result)")
*/

import Foundation

let NMB = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMB[0]
let M = NMB[1]
let B = NMB[2]

var arr = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    arr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var totalCost = 9999999999999
var result = 0

for k in 0...256 {
    var tempResult = 0
    if k >= 0 {
        var tempB = B
        for i in 0..<N {
            for j in 0..<M {
                let currentNumber = arr[i][j]
                if k > arr[i][j] {
                    tempB = tempB - (k - currentNumber)
                    tempResult += (k - currentNumber)
                } else if k == currentNumber {
                    continue
                } else {
                    tempB = tempB + (currentNumber - k)
                    tempResult += (currentNumber - k) * 2
                }
            }
        }
        if tempB >= 0 {
            if totalCost >= tempResult {
                totalCost = tempResult
                result = k
            }
        }
    }
}
print("\(totalCost) \(result)")
