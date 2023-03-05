//
//  main.swift
//  StackSequence
//
//  Created by Kay on 2023/03/05.
//

/*
 1874
 스택 수열
 */

import Foundation

let stackCount = Int(readLine()!)!

var arr = [Int]() // 기준

for _ in 0..<stackCount {
    arr.append(Int(readLine()!)!)
}

var result = [Character]()
var stack = [Int]()

var numberCounter = 1
stack.append(numberCounter)
result.append("+")

while true {
    if stack.isEmpty == true && arr.isEmpty == true {
        break
    }
    if stack.isEmpty == false && stack.last! > arr[0] {
        break
    }
    if stack.isEmpty == true || (stack.isEmpty == false && stack.last! != arr[0]) {
        numberCounter += 1
        stack.append(numberCounter)
        result.append("+")
    } else {
        stack.popLast()!
        arr.removeFirst()
        result.append("-")
    }
}

if stack.count == 0 {
    result.enumerated().forEach {
        print($0.element)
    }
} else {
    print("NO")
}
