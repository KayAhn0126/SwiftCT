import Foundation

func search(_ arr: inout [Int], _ num: Int) -> Int {
    var start = 0
    var end = arr.count-1
    var mid = 0
    while start <= end {
        mid = (start + end) / 2
        if arr[mid] == num {
            return 1
        }
        if arr[mid] < num {
            start = mid + 1
        } else if arr[mid] > num {
            end = mid - 1
        }
    }
    return 0
}

let N = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted()
let M = Int(readLine()!)!
var result = readLine()!.split(separator: " ").map { Int(String($0))! }
for i in result {
    print(search(&arr, i))
}
