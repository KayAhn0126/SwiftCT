//
//  main.swift
//  PronouncePassword
//
//  Created by Kay on 2023/01/05.
//

/*
 4659
 비밀번호 발음하기
 */
// 2nd week fast campus

import Foundation

while let password = readLine() {
    if password == "end" {
        break
    }
    if checkPassword(password) {
        print("<\(password)> is acceptable.")
    } else {
        print("<\(password)> is not acceptable.")
    }
}

func isVowel(_ letter: Character) -> Bool {
    return (letter == "a" || letter == "e" || letter == "i" || letter == "o" || letter == "u")
}

func checkPassword(_ password: String) -> Bool {
    var vowelCounter = 0
    var consonantCounter = 0
    var totalVowelCounter = 0
    var previousChar = ""
    var flag = true
    password.enumerated().forEach {
        if previousChar == String($0.element) {
            let checkString = previousChar + String($0.element)
            if !(checkString == "ee" || checkString == "oo") {
                flag = false
            }
        } else {
            previousChar = String($0.element)
        }
        if isVowel($0.element) {
            vowelCounter += 1
            consonantCounter = 0
            totalVowelCounter += 1
        } else {
            consonantCounter += 1
            vowelCounter = 0
        }
        if vowelCounter == 3 || consonantCounter == 3 {
            flag = false
        }
    }
    if totalVowelCounter == 0 {
        flag = false
    }
    return flag
}
