//
//  main.swift
//  NBABasketBall
//
//  Created by Kay on 2023/02/03.
//

import Foundation

let goals = Int(readLine()!)!

var teamAScore = 0 // 1
var teamBScore = 0 // 2

var teamATime = 0
var teamBTime = 0

func changeToSec(_ element: String) -> Int {
    let arr = element.split(separator: ":").map { Int(String($0))! }
    let min = arr[0] * 60
    let sec = arr[1]
    return min + sec
}

func changeToMin(_ element: Int) -> String {
    let min = element / 60
    let sec = element % 60
    if min < 10 {
        if sec < 10 {
            return "0\(min):0\(sec)"
        } else {
            return "0\(min):\(sec)"
        }
    } else {
        if sec < 10 {
            return "\(min):0\(sec)"
        } else {
            return "\(min):\(sec)"
        }
    }
}

var previous = ""
for _ in 0..<goals {
    var teamAndTime = readLine()!.split(separator: " ")
    let team = Int(String(teamAndTime[0]))
    let time = String(teamAndTime[1])
    if teamAScore > teamBScore {
        teamATime += changeToSec(time) - changeToSec(previous)
    } else if teamBScore > teamAScore {
        teamBTime += changeToSec(time) - changeToSec(previous)
    }
    if team == 1 {
        teamAScore += 1
    } else {
        teamBScore += 1
    }
    previous = time
}
if teamAScore > teamBScore {
    teamATime += changeToSec("48:00") - changeToSec(previous)
} else if teamBScore > teamAScore {
    teamBTime += changeToSec("48:00") - changeToSec(previous)
}

print(changeToMin(teamATime))
print(changeToMin(teamBTime))
