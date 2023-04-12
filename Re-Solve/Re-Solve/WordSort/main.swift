import Foundation

let num = Int(readLine()!)!

var arr = [String]()
for _ in 0..<num {
    arr.append(readLine()!)
}

arr = Array(Set<String>(arr))
arr.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0.count < $1.count
}).forEach {
    print($0)
}
