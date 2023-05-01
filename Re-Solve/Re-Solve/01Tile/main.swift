import Foundation

let num = Int(readLine()!)!

var dp = [Int](repeating: 0, count: 1000001)

dp[1] = 1
dp[2] = 2
dp[3] = 3
dp[4] = 5

for i in 5...1000000 {
    dp[i] = (dp[i-1] + dp[i-2]) % 15746
}
print(dp[num])
