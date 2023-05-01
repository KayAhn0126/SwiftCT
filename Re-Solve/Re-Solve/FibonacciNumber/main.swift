import Foundation

let number = Int(readLine()!)!
var dp = [Int](repeating: 0, count: 41)
var count = 0

dp[1] = 1
dp[2] = 1
for i in 3...number {
    count += 1
    dp[i] = dp[i-1] + dp[i-2]
}
print(dp[number])
print(count)
