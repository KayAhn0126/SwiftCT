//
//  main.swift
//  WeatherCaster
//
//  Created by Kay on 2023/02/03.
//

/*
 10709
 기상캐스터
 */

/*
 가로세로 최대 100
 구름이 있는 경우 영어 소문자 'c'
 구름이 없는 경우 '.'
 */

/*
 c라고 되어있는 부분은 모두 0이다
 첫번째 c를 만나기 전에는 모두 -1이다
 
 */

import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }

let H = userInput[0]
let W = userInput[1]

var weatherMap = [[Character]](repeating: [Character](), count: H)

func checkValid(_ h: Int, _ w: Int) -> Bool {
    if 1 <= h && h <= 100 && 1 <= w && w <= 100 {
        return true
    }
    return false
}


if checkValid(H,W) {
    for i in 0..<H {
        weatherMap[i].append(contentsOf: readLine()!)
    }

    for height in 0..<H {
        var resultString = ""
        var cFlag = false
        var cCounter = 0
        for width in 0..<W {
            if weatherMap[height][width] == "c" {
                resultString += "0 "
                cCounter = 0
                cFlag = true
            } else if cFlag == false && weatherMap[height][width] == "." {
                resultString += "-1 "
            } else if cFlag == true && weatherMap[height][width] == "." {
                cCounter += 1
                resultString += "\(cCounter) "
            }
        }
        resultString.removeLast()
        print(resultString)
    }
}
