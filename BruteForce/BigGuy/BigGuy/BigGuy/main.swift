//
//  main.swift
//  BigGuy
//
//  Created by Kay on 2023/02/27.
//

/*
 7568
 덩치
 */

import Foundation

let people = Int(readLine()!)!
var peopleArr: [(Int, Int)] = []
for i in 0..<people {
    let weightHeight = readLine()!.split(separator: " ").map { Int(String($0))! }
    let weight = weightHeight[0]
    let height = weightHeight[1]
    peopleArr.append((weight,height))
}

var result = [Int]()
for person in peopleArr {
    var tempResult = 1
    let currentWeight = person.0
    let currentHeight = person.1
    for people in peopleArr {
        let otherWeight = people.0
        let otherHeight = people.1
        if otherWeight > currentWeight && otherHeight > currentHeight {
            tempResult += 1
        }
    }
    result.append(tempResult)
}
result.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
