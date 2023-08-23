//
//  main.swift
//  AmusementPark
//
//  Created by Kay on 2023/08/23.
//

/*
 2594
 놀이공원
 */

/*
 문제를 풀기 쉽게 모든 시간에서 10을 빼주자
 시작시간에서 10을 빼주고, 종료시간에 10을 더해주자.
 정렬 후 라인스위핑으로 풀면 된다.
 */

/* 시간 계산 두가지 경우 생각하기
 1. 이미 종료가 된 경우,
 last와 현재 시작시간의 시간 차 계산
 2. 아직 종료가 안된 경우.
 last를 현재 종료 시간으로 갱신
 */

import Foundation

let N = Int(readLine()!)!

if N > 0 {
    func stringToTime(_ myString: String) -> Int {
        var result = 0
        let secondIndex = myString.index(myString.startIndex, offsetBy: 2)
        let hour = Int(String(myString[myString.startIndex..<secondIndex]))!
        let minute = Int(String(myString[secondIndex..<myString.endIndex]))!
        result += ((hour - 10) * 60) + minute
        return result
    }
    
    var timeTable = [(Int,Int)]()
    for _ in 0..<N {
        let temp = readLine()!.split(separator: " ").map { String($0) }
        timeTable.append((stringToTime(temp[0]) - 10, stringToTime(temp[1]) + 10))
    }
    timeTable = timeTable.sorted(by: {
        return $0.0 < $1.0
    })
    
    var result = [Int]()
    result.append(timeTable[0].0)
    var last = timeTable[0].1
    for i in 1..<timeTable.count {
        let current = timeTable[i]
        let currentStart = current.0
        let currentEnd = current.1
        if last > currentStart && last > currentEnd {
            continue
        } else if last >= currentStart { //
            last = currentEnd
        } else { // start가 확실히 더 큰 경우
            result.append(currentStart - last)
            last = currentEnd
        }
    }
    var finishTime = 12 * 60
    result.append(finishTime - last)
    if result.isEmpty {
        print(0)
    } else {
        print(result.max()!)
    }
} else {
    print(0)
}
