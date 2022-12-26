//
//  main.swift
//  PokemonLee
//
//  Created by Kay on 2022/12/26.
//

/*
 1620
 나는야 포켓몬 마스터 이다솜
 */
// 1st week fast-campus
import Foundation

let inputArr = readLine()!.split(separator: " ").map { Int($0)! }
let nameCount = inputArr[0]
let questionCount = inputArr[1]

var pokemonStringInt: [String : Int] = [:]
var pokemonIntString: [Int: String] = [:]

for i in 1...nameCount {
    let pokemonName = readLine()!
    pokemonStringInt["\(pokemonName)"] = i
    pokemonIntString[i] = "\(pokemonName)"
}

for _ in 1...questionCount {
    let question = readLine()!
    if let number = Int(question) {
        print(pokemonIntString[number]!)
    } else {
        print(pokemonStringInt["\(question)"]!)
    }
}
