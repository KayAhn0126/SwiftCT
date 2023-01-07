//
//  main.swift
//  NBABasketBall
//
//  Created by Kay on 2023/01/06.
//

/*
 2852
 NBA 농구
 */
// 2nd week fast campus

import Foundation

var aCount = 0
var bCount = 0

var aSum = 0
var bSum = 0

var previousTime = ""

func timeToNumber(_ temp: String) -> Int {
    let startIndex = temp.startIndex
    let middleIndex = temp.index(startIndex, offsetBy: 2)
    let endIndex = temp.index(before: temp.endIndex)
    
    let minute = temp[temp.startIndex..<middleIndex]
    let second = temp[temp.index(after: middleIndex)...endIndex]
    let timeInInt = (Int(minute)! * 60) + Int(second)!
    return timeInInt
}

func numberToTime(_ temp: Int) -> String {
    var minute = String(temp / 60)
    var second = String(temp % 60)
    if minute.count == 1 {
        minute.insert("0", at: minute.startIndex)
    }
    if  second.count == 1 {
        second.insert("0", at: second.startIndex)
    }
    return "\(minute):\(second)"
}

func calculateTime(_ time1: String, _ addsub: String, _ time2: String) -> Int {
    let time1Num = timeToNumber(time1)
    let time2Num = timeToNumber(time2)
    if addsub == "add" { // add 일때
        return time1Num + time2Num
    } else { // sub 일때
        return time1Num - time2Num
    }
}

let N = Int(readLine()!)!

for _  in 0..<N {
    let teamAndTime = readLine()!.split(separator: " ").map { String($0) }
    let team = teamAndTime[0]
    let time = teamAndTime[1]
    
    if aCount > bCount {
        aSum += calculateTime(time, "sub", previousTime)
    } else if bCount > aCount {
        bSum += calculateTime(time, "sub", previousTime)
    }
    
    if team == "1" {
        aCount += 1
    } else {
        bCount += 1
    }
    
    previousTime = time
}

if aCount > bCount {
    aSum += calculateTime("48:00", "sub", previousTime)
} else if bCount > aCount {
    bSum += calculateTime("48:00", "sub", previousTime)
}
print(numberToTime(aSum))
print(numberToTime(bSum))
