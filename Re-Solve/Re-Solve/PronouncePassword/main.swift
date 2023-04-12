import Foundation




func checkIfItsVowel(_ char: Character) -> Bool {
    if char == "a" || char == "e" || char == "i" || char == "o" || char == "u" {
        return true
    }
    return false
}

while true {
    let temp = readLine()!
    if temp == "end" {
        break
    }
    // 모음 자음 3개 연속
    var vowelStrikeCount = 0
    var consonantStrikeCount = 0
    var notOkFlag = false
    var previousChar: Character = " "
    var atLeastOneVowelFlag = false
    for i in temp {
        if i == previousChar {
            if i != "e" && i != "o" {
                notOkFlag = true
                break
            }
        }
        if checkIfItsVowel(i) == true {
            vowelStrikeCount += 1
            consonantStrikeCount = 0
            atLeastOneVowelFlag = true
        } else {
            consonantStrikeCount += 1
            vowelStrikeCount = 0
        }
        if vowelStrikeCount == 3 || consonantStrikeCount == 3 {
            notOkFlag = true
            break
        }
        previousChar = i
    }
    if notOkFlag == true  || atLeastOneVowelFlag == false {
        print("<\(temp)> is not acceptable.")
    } else {
        print("<\(temp)> is acceptable.")
    }
}
