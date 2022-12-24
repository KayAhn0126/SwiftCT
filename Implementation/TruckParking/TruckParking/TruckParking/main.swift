//
//  main.swift
//  TruckParking
//
//  Created by Kay on 2022/12/24.
//

/*
#2979
 트럭 주차
 */

// 1st week fast-campus
import Foundation

let numbers: [Int] = readLine()!.split(separator: " ").map { Int(String($0))! } // 요금 A, B, C

let costA = numbers[0]
let costB = numbers[1]
let costC = numbers[2]


var timeArr = [Int](repeating: 0, count: 101) // 0 ~ 101
var totalCharge = 0

for _ in 0...2 {
    let time: [Int] = readLine()!.split(separator: " ").map { Int(String($0))! }
    let checkInTime = time[0]
    let checkOutTime = time[1]
    for minute in checkInTime..<checkOutTime {
        timeArr[minute] += 1
    }
}

timeArr.enumerated().forEach {
    if $0.element == 1 {
        totalCharge += (timeArr[$0.offset] * costA)
    } else if $0.element == 2 {
        totalCharge += (timeArr[$0.offset] * costB)
    } else {
        totalCharge += (timeArr[$0.offset] * costC)
    }
}

print(totalCharge)




