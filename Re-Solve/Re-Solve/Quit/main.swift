import Foundation

let number = Int(readLine()!)!
var result = 0

//MARK: 0 ~ number - 1 인덱스 기반
var tArr = [Int](repeating: 0, count: number + 1)
var pArr = [Int](repeating: 0, count: number + 1)

var dp = [Int](repeating: -1, count: 16)

for i in 1...number {
    let tp = readLine()!.split(separator: " ").map { Int(String($0))! }
    let day = tp[0]
    let pay = tp[1]
    tArr[i] = day
    pArr[i] = pay
}
func solve(_ day: Int) -> Int {
    if day > number + 1 { return -999999999 }
    if day == number + 1 { return 0 }
    dp[day] = max(solve(day + tArr[day]) + pArr[day], solve(day + 1))
    return dp[day]
}

print(solve(1))
