import Foundation

let N = Int(readLine()!)!
var adjMatrix = [[Int]]()
for _ in 0..<N {
    adjMatrix.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

var result = Int.max
for i in 0..<3 {
    var dp = [[Int]](repeating: [Int](repeating: 999999, count: 3), count: N)
    dp[0][i] = adjMatrix[0][i]
    
    for j in 1..<N {
        dp[j][0] = min(dp[j-1][1], dp[j-1][2]) + adjMatrix[j][0]
        dp[j][1] = min(dp[j-1][0], dp[j-1][2]) + adjMatrix[j][1]
        dp[j][2] = min(dp[j-1][0], dp[j-1][1]) + adjMatrix[j][2]
    }
    for l in 0..<3 {
        if i == l { continue }
        result = result > dp[N-1][l] ? dp[N-1][l] : result
    }
}
print(result)
