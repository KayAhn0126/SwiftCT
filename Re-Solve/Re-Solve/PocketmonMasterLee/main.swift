//
//  main.swift
//  PocketmonMasterLee
//
//  Created by Kay on 2023/02/02.
//

import Foundation

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
let total = userInput[0]
let ask = userInput[1]

var dictionaryStringInt: [String : Int] = [:]
var dictionaryIntString: [Int : String] = [:]

for order in 1...total {
    let name = readLine()!
    dictionaryStringInt[name] = order
    dictionaryIntString[order] = name
}

for _ in 0..<ask {
    let question = readLine()!
    if Int(question) == nil {
        print(dictionaryStringInt[question]!)
    } else {
        print(dictionaryIntString[Int(question)!]!)
    }
}

