//
//  main.swift
//  SharingSnack
//
//  Created by Kay on 2023/03/25.
//

/*
 16401
 과자 나눠주기 다시 풀기
 */

import Foundation

let MN = readLine()!.split(separator: " ").map { Int(String($0))! }
let M = MN[0] // 사람 숫자
let N = MN[1] // 과자의 수

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }


//MARK: 배열을 돌면서 나눈수가 과자의 수와 일치하는지 체크
func checkIfPossible(_ num: Int) -> Bool {
    var result = 0
    for i in 0..<arr.count {
        result += arr[i] / num
        if result >= M {
            return true
        }
    }
    return false
}

//MARK: Binary Search
var start = 1 // checkIfPossible 함수에서 매개변수로 받아온 값을 나누니, 0으로 두면 런타임 에어 발생. 
var end = 1000000000
var mid = 0

var result = 0
while start <= end {
    mid = (start + end) / 2
    if checkIfPossible(mid) == true {
        result = mid
        start = mid + 1
    } else {
        end = mid - 1
    }
}
print(result)
