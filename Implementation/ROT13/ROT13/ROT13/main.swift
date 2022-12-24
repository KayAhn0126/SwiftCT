//
//  main.swift
//  ROT13
//
//  Created by Kay on 2022/12/25.
//

/*
#11655
 ROT13
 */

// 1st week fast-campus
import Foundation

var rot13String = readLine()!
var resultString = ""
rot13String.enumerated().forEach {
    let currentNumberInAscii = Int($0.element.asciiValue!)
    if 65 <= currentNumberInAscii && currentNumberInAscii <= 90 {
        if currentNumberInAscii + 13 > 90 {
            resultString += String(UnicodeScalar(currentNumberInAscii - 13)!)
        } else {
            resultString += String(UnicodeScalar(currentNumberInAscii + 13)!)
        }
    } else if 97 <= currentNumberInAscii && currentNumberInAscii <= 122 {
        if currentNumberInAscii + 13 > 122 {
            resultString += String(UnicodeScalar(currentNumberInAscii - 13)!)
        } else {
            resultString += String(UnicodeScalar(currentNumberInAscii + 13)!)
        }
    } else {
        resultString += String($0.element)
    }
}
print(resultString)
