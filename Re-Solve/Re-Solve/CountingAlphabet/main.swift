import Foundation


extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let tempString = readLine()!

var arr = [Int](repeating: 0, count: 26)

for i in tempString {
    arr[Int(i.asciiValue!) - 97] += 1
}

arr.enumerated().forEach {
    print($0.element, terminator: " ")
}
