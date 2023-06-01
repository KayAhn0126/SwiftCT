//
//  main.swift
//  PersonAtWork
//
//  Created by Kay on 2023/06/01.
//

/*
 7785
 회사에 있는 사람
 */

import Foundation

let num = Int(readLine()!)!

var dictionary: [String: Int] = [:]

for _ in 0..<num {
    let input = readLine()!.split(separator: " ").map { String($0) }
    let name = input[0]
    let inOut = input[1]
    if inOut == "enter" && dictionary[name] == nil {
        dictionary[name] = 1
    } else if inOut == "leave" && dictionary[name] != nil {
        dictionary[name] = nil
    }
}
dictionary.keys.sorted(by: >).forEach {
    print($0)
}

