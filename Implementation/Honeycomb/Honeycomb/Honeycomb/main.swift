//
//  main.swift
//  Honeycomb
//
//  Created by Kay on 2023/01/01.
//

/*
 2292
 벌집
 */
import Foundation

var userInput = Int(readLine()!)!

var makeUpNumber = 1
var counter = 1

while userInput > makeUpNumber {
    makeUpNumber += 6 * counter
    counter += 1
}

print(counter)

