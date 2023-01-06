//
//  main.swift
//  WeatherCaster
//
//  Created by Kay on 2023/01/06.
//

/*
 10709
 기상캐스터
 */
// 2nd week fast campus

// 요구사항
/*
1. c 플래그가 꺼져있으면 -1
2. c의 자리는 무조건 0
3. c 플래그가 올라가있는 상태에서 .을 만나면 카운터 증가
    다시 C를 만나면 카운트 1로 초기화
 */


extension String {
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else {
            return nil
        }
        let target = index(startIndex, offsetBy: idx)
        return String(self[target])
    }
}


import Foundation

let HW = readLine()!.split(separator: " ").map { Int(String($0))! }
let H = HW[0]
let W = HW[1]

var userInput = [[Character]](repeating: [Character](), count: H)

for i in 0..<H {
    userInput[i].append(contentsOf: readLine()!)
}

userInput.enumerated().forEach {
    calculateCloud($0.element)
}

func calculateCloud(_ temp: [Character]) {
    var newStringArr: String = ""
    var cFlag = false
    var moveCounter = 1
    for i in 0..<temp.count {
        if cFlag == false && temp[i] == "." {
            newStringArr += "-1 "
        } else if temp[i] == "c" {
            cFlag = true
            newStringArr += "0 "
            moveCounter = 1
        } else if cFlag == true && temp[i] == "." {
            newStringArr += "\(moveCounter) "
            moveCounter += 1
        }
    }
    print(newStringArr)
}

