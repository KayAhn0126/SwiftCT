import Foundation

let num = Int(readLine()!)!

var arr: [Int] = [1,2,3]

for i in 0..<num {
    let fromto = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromto[0]
    let to = fromto[1]
    arr.enumerated().forEach {
        if $0.element == from {
            arr[$0.offset] = to
        } else if $0.element == to {
            arr[$0.offset] = from
        }
    }
}
print(arr[0])
