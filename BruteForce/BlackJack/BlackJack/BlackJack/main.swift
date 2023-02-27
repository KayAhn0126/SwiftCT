//
//  main.swift
//  BlackJack
//
//  Created by Kay on 2023/02/27.
//

/*
 2798
 블랙잭
 */
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // 주어지는 요소
let M = NM[1] // 목표값

let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var biggest = -987654321
for i in 0..<N-2 {
    for j in i+1..<N-1 {
        for k in j+1..<N {
            let currentSum = arr[i] + arr[j] + arr[k]
            if currentSum <= M {
                biggest = currentSum > biggest ? currentSum : biggest
            }
        }
    }
}
print(biggest)

