//
//  main.swift
//  One
//
//  Created by Kay on 2023/02/03.
//

import Foundation

while let num = readLine() {
    let myNum = Int(num)!
    if myNum == 1 {
        print(1)
    } else {
        var result = 1
        var goingUp = 1
        while goingUp != 0 {
            goingUp = ((goingUp * 10) + 1) % myNum
            result += 1
        }
        print(result)
    }
}



