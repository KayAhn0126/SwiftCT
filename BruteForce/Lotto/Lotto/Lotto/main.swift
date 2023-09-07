//
//  main.swift
//  Lotto
//
//  Created by Kay on 2023/09/07.
//

/*
 6603
 로또
 */

/*
 - 주어진 숫자들에서 무조건 6개씩 뽑아야한다.
 - 중복 안됨
 - 0이 나오면 종료
 */

import Foundation

var flag = false
while let x = readLine() {
    if x == "0" { break }
    if flag {
        print("")
    }
    let arr = x.split(separator: " ").map { String($0) }
    let newArr = Array(arr[1..<arr.count])
    var visited = [Bool](repeating: false, count: newArr.count)
    
    func dfs(_ depth: Int, _ current: String, _ idx: Int) {
        if depth == 6 {
            var result = current
            result.removeLast()
            print(result)
            return
        }
        for i in idx..<newArr.count {
            if visited[i] { continue }
            visited[i] = true
            dfs(depth + 1, current + newArr[i] + " ", i)
            visited[i] = false
        }
    }
    dfs(0, "", 0)
    flag = true
}
