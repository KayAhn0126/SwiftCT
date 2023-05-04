import Foundation

// 입력 10만개
// 10만개 정렬 nlogn =

/*
 1000 = 10
 2000 = 11
 5000 = 12
 10000 = 13
 2만 = 14
 5만 = 15
 10만 = 16
 16만logn = 16만 * 16
 정렬하는데 200만 정도
 */

let n = Int(readLine()!)!
//MARK: 입력을 받자마자 정렬한다.
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted()

let M = Int(readLine()!)!
var findArr = readLine()!.split(separator: " ").map { Int(String($0))! }



func find(_ arr: inout [Int], _ number: Int) -> Int {
    var start = 0
    var end = arr.count - 1
    var mid = 0
    while start <= end {
        mid = (start + end) / 2
        if arr[mid] == number { return 1 }
        if number < arr[mid] {
            end = mid - 1
        } else if number > arr[mid] {
            start = mid + 1
        }
    }
    return 0
}

findArr.enumerated().forEach {
    print(find(&arr, $0.element))
}
