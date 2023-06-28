//
//  main.swift
//  SumOfTwoNumbers
//
//  Created by Kay on 2023/06/27.
//

/*
 3272
 두 수의 합
 */

import Foundation

let N = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted()
let X = Int(readLine()!)!

var count = 0
var left = 0
var right = arr.count - 1
// left <= right로 조건을 걸었는데 틀렸다고 나와서 다시 지문을 읽었다.
// n개의 서로 다른 양의 정수... -> 즉 서로 달라야한다.
while left < right && left < N {
    if arr[left] + arr[right] == X { count += 1; right -= 1 }
    else if arr[left] + arr[right] > X { right -= 1 }
    else if arr[left] + arr[right] < X { left += 1 }
}
print(count)
