//
//  main.swift
//  FindingNumber
//
//  Created by Kay on 2023/02/21.
//

/*
 1920
 수 찾기
 */

// 140만 + (이분탐색 10 * logn) 140만 = 280만

import Foundation

var firstArr = [Int]()
var secondArr = [Int]()

let N = Int(readLine()!)!

firstArr.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })

let M = Int(readLine()!)!

secondArr.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })

firstArr.sort()

var firstArrCount = firstArr.count - 1

func binarySearch(_ array: [Int], _ targetNum: Int) -> Bool {
    var start = 0
    var end = firstArrCount
    //(array.count - 1) 배열의 count는 O(N), 한번만 계산하고 사용할 수 있도록 밖으로 빼주자
    while start <= end {
        var mid = (start + end) / 2
        
        if array[mid] == targetNum { return true }
        if array[mid] > targetNum {
            end = mid - 1
        } else {
            start = mid + 1
        }
    }
    return false
}

secondArr.enumerated().forEach {
    if binarySearch(firstArr, $0.element) == true {
        print(1)
    } else {
        print(0)
    }
}
