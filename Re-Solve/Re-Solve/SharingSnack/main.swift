import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // number of cousin
let M = NM[1] // number of snack

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

func isBigEnough(_ num: Int) -> Bool {
    var temp = 0
    for element in arr {
        if element < num { continue }
        temp += (element / num)
        if temp >= N { return true }
    }
    return false
}

func binarySearch() -> Int {
    var result = 0
    var start = 1
    var end = 1000000000, mid = 0
    while start <= end {
        mid = (start + end) / 2
        if isBigEnough(mid) == true {
            result = mid
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    return result
}
print(binarySearch())
