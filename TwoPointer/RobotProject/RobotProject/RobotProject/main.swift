//
//  main.swift
//  RobotProject
//
//  Created by Kay on 2023/07/06.
//

/*
 로봇 프로젝트
 3649
 */

/*
 문제 접근
 투포인터로 양쪽에서 접근해서 구멍의 너비를 맞춰지면 반환 아니면 "danger" 출력
 */

import Foundation

var answer = ""
while let temp = readLine() {
    let X = Int(temp)! * 10000000
    let count = Int(readLine()!)!
    var arr = [Int]()
    for _ in 0..<count {
        arr.append(Int(readLine()!)!)
    }

    arr.sort()

    var leftIdx = 0
    var rightIdx = count - 1
    var tempStr = "danger\n"
    
    while leftIdx < rightIdx {
        let tempNum = arr[leftIdx] + arr[rightIdx]
        if tempNum == X {
            tempStr = "yes \(arr[leftIdx]) \(arr[rightIdx])\n"
            break
        }
        if tempNum < X {
            leftIdx += 1
        } else if tempNum > X {
            rightIdx -= 1
        }
    }
    answer += tempStr
}
print(answer)
