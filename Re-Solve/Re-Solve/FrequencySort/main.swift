//
//  main.swift
//  FrequencySort
//
//  Created by Kay on 2023/02/03.
//

import Foundation

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = userInput[0]
let C = userInput[1]

let numbersArr = readLine()!.split(separator: " ").map { Int(String($0))! }

var info: [Int:(Int, Int)] = [:] // [숫자 : (처음나온 인덱스, 빈도)]
for i in 0..<N {
    if info[numbersArr[i]] == nil {
        info[numbersArr[i]] = (i,1)
    } else {
        let indexAndFrequency = info[numbersArr[i]]!
        let index = indexAndFrequency.0
        let frequency = indexAndFrequency.1 + 1
        info[numbersArr[i]] = (index, frequency)
    }
}

//print(info)

var result = ""
info.sorted(by: {
    if $0.value.1 == $1.value.1 {
        return $0.value.0 < $1.value.0
    }
    return $0.value.1 > $1.value.1
}).forEach {
    for _ in 0..<$0.value.1 {
        result += String($0.key) + " "
    }
}
print(result)
