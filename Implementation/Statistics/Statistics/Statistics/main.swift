//
//  main.swift
//  Statistics
//
//  Created by Kay on 2023/03/23.
//

/*
 2108
 통계학
 */

// 정렬 50만 nLogn
import Foundation

let N = Int(readLine()!)!

var arr = [Int]()
var countingArr = [Int](repeating: 0, count: 8001)
var total = 0
var countMax = 0

for i in 0..<N {
    let num = Int(readLine()!)!
    arr.append(num)
    countingArr[num + 4000] += 1
    if countingArr[num+4000] > countMax {
        countMax = countingArr[num+4000]
    }
    total += num
}


var mostNum = 0
var doubleCount = 0

for i in 0..<countingArr.count {
    if countingArr[i] == countMax {
        doubleCount += 1
        mostNum = i - 4000
        if doubleCount == 2 {
            mostNum = i - 4000
            break
        }
    }
}

arr.sort()

print(Int(round(Double(total)/Double(N))))
print(arr[arr.count/2])
print(mostNum)
print(arr[arr.count-1] - arr[0])



