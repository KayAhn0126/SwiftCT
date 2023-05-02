import Foundation

let num = Int(readLine()!)!

var adjMatrix = [[Int]](repeating: [Int](), count: num)
for i in 0..<num {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


//메인포인트는 A를 제외한 나머지 값들을 max로 주어서 A 선택할 수 밖에 없게 만들고
// 마지막에 B와 C중 작은 값을 업데이트 한다. (A를 선택했으니 마지막에 A는 선택하지 못하게 한다.
let max = 987654321
var result = Int.max
for i in 0..<3 { // 선택
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: num)
    for j in 0..<3 {
        if i == j {
            dp[0][j] = adjMatrix[0][j]
            continue
        }
        dp[0][j] = max
    }
    for k in 1..<num {
        dp[k][0] = min(dp[k-1][1], dp[k-1][2]) + adjMatrix[k][0]
        dp[k][1] = min(dp[k-1][0], dp[k-1][2]) + adjMatrix[k][1]
        dp[k][2] = min(dp[k-1][0], dp[k-1][1]) + adjMatrix[k][2]
    }
    for l in 0..<3 {
        if i == l {
            continue
        }
        result = result > dp[num-1][l] ? dp[num-1][l] : result
    }
}
print(result)
