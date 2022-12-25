//
//  SolveWithRegex.swift
//  WhenIMissKoreaConnectToServer
//
//  Created by Kay on 2022/12/25.
//

import Foundation

func checkPattern(_ testArray: [String], startString: String, endString: String) {
    let pattern = "^\(startString)[a-z]*\(endString)$"

    testArray.enumerated().forEach {
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: $0.element.count)
        if regex?.matches(in: $0.element, range: range) != Optional([]) {
            print("DA")
        } else {
            print("NE")
        }
    }
}
