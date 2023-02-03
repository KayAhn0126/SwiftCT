//
//  main.swift
//  PronouncePassword
//
//  Created by Kay on 2023/02/03.
//

/*
 4659
 비밀번호 발음하기
 */

import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard (0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}
func checkVowel(_ char: Character) -> Bool {
    if char == "a" || char == "e" || char == "i" || char == "o" || char == "u" {
        return true
    }
    return false
}

func checkGoodPassword(_ element: String) {
    var vowelContinousCounter = 0
    var consonantContinousCounter = 0
    var totalVowelCounter = 0
    var previousLetter: Character = " "
    var flag = true
    for i in 0..<element.count {
        if String(previousLetter) == String(element[i]!) {
            var totalString = String(previousLetter) + String(element[i]!)
            if totalString != "ee" && totalString != "oo" {
                flag = false
            }
        }
        previousLetter = element[i]!
        if checkVowel(element[i]!) {
            vowelContinousCounter += 1
            if vowelContinousCounter == 3 {
                flag = false
            }
            consonantContinousCounter = 0
            totalVowelCounter += 1
        } else {
            consonantContinousCounter += 1
            if consonantContinousCounter == 3 {
                flag = false
            }
            vowelContinousCounter = 0
        }
    }
    if flag == true && totalVowelCounter >= 1 {
        print("<\(element)> is acceptable.")
    } else {
        print("<\(element)> is not acceptable.")
    }
}

while let test = readLine() {
    if test == "end" {
        break
    }
    checkGoodPassword(test)
}
