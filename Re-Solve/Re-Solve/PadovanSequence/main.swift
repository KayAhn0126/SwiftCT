import Foundation

var dp = [Int](repeating: 0, count: 101)
dp[1] = 1
dp[2] = 1
dp[3] = 1
dp[4] = 2
dp[5] = 2
dp[6] = 3
dp[7] = 4
dp[8] = 5
dp[9] = 7
dp[10] = 9

for i in 11...100 {
    dp[i] = dp[i-2] + dp[i-3]
}

let num = Int(readLine()!)!
for i in 0..<num {
    let temp = Int(readLine()!)!
    print(dp[temp])
}

