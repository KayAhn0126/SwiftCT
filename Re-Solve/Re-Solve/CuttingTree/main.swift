import Foundation

func check(_ arr: inout [Int], _ treeHeight: Int) -> Int {
    var temp = 0
    for i in arr {
        if i > treeHeight {
            temp += (i - treeHeight)
        }
    }
    return temp
}

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

var start = 0
var end = 2000000001
var mid = 0
var result = 0
while start <= end {
    mid = (start + end) / 2
    let temp = check(&arr, mid)
    // 만약 목재를 자르고 남은 잔챙이가 가져가려는 크기보다 작다면
    if M > temp {
        end = mid - 1
    } else if M <= temp {
        result = mid > result ? mid : result
        start = mid + 1
    }
}
print(result)
