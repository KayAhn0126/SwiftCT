import Foundation

var num = Int(readLine()!)!
var dp = [Int](repeating: 0, count: num + 1)

if num == 1 {
    print(0)
} else if num == 2 || num == 3 {
    print(1)
} else {
    dp[1] = 0
    dp[2] = 1
    dp[3] = 1

    for i in 4...num {
        dp[i] = dp[i-1] + 1
        if i % 2 == 0 {
            dp[i] = min(dp[i], dp[i/2] + 1)
        }
        if i % 3 == 0 {
            dp[i] = min(dp[i], dp[i/3] + 1)
        }
    }
    print(dp[num])
}

