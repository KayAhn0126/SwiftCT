//
//  main.swift
//  CuttingTree
//
//  Created by Kay on 2023/03/01.
//

/*
 2805
 나무 자르기
 */

/*
 내가 무엇이 필요한가? -> 조건을 만족하는 특정한 수
 나무는 최대 100만개가 주어질 수 있다 -> 배열을 정렬 하면 안된다.
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

func checkIsPossible(_ settingNumber: Int) -> Bool {
    var tempTotal = 0
    for element in arr {
        if element >= settingNumber {
            tempTotal += element - settingNumber
        }
        if tempTotal >= M {
            return true
        }
    }
    return false
}

func binarySearchForSettingNumber() -> Int {
    var result = 0
    var start = 0, end = 2000000000, mid = 0
    while start <= end {
        mid = (start + end) / 2
        if checkIsPossible(mid) == true {
            result = mid
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    return result
}

print(binarySearchForSettingNumber())
