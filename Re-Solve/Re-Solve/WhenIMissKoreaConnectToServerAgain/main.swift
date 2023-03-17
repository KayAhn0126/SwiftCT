//
//  main.swift
//  WhenIMissKoreaConnectToServerAgain
//
//  Created by Kay on 2023/03/17.
//

/*
 9996
 한국이 그리울 땐 서버에 접속하지 다시풀기 2번째
 */

import Foundation

var number = Int(readLine()!)!
var prefixSuffix = readLine()!.split(separator: "*")
var prefix = prefixSuffix[0]
var suffix = prefixSuffix[1]


for i in 0..<number {
    let testString = readLine()!
    checkQualify(testString)
}

func checkQualify(_ testString: String) {
    if testString.hasPrefix(prefix) && testString.hasSuffix(suffix) && testString.count >= prefix.count + suffix.count {
        print("DA")
    } else {
        print("NE")
    }
}
