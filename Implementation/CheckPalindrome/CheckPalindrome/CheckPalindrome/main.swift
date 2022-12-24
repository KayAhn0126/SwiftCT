//
//  main.swift
//  CheckPalindrome
//
//  Created by Kay on 2022/12/25.
//

/*
#10988
 팰린드롬인지 확인하기
 */

// 1st week fast-campus
import Foundation

var checkPalindromeString = readLine()!
if checkPalindromeString == String(checkPalindromeString.reversed()) {
    print(1)
} else {
    print(0)
}
