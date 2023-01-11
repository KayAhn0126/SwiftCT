//
//  SolveWithString.swift
//  WhenIMissKoreaConnectToServer
//
//  Created by Kay on 2022/12/25.
//

import Foundation

func checkPatternWithNumber(_ testArray: [String], startString: String, endString: String) {
    
    testArray.enumerated().forEach {
        if $0.element.hasPrefix(startString) && $0.element.hasSuffix(endString) {
            if $0.element.count >= startString.count + endString.count { // 예를 들어 패턴이 AB*BD일때 ABD가 DA로 판별나는것을 방지
                print("DA")
            } else {
                print("NE")
            }
        } else {
            print("NE")
        }
    }
}
