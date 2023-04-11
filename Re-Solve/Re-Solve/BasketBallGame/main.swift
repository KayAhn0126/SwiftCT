import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let N = Int(readLine()!)!

var alphaArr = [Int](repeating: 0, count: 26)
for i in 0..<N {
    let name = readLine()!
    alphaArr[Int(name[0]!.asciiValue!) - 97] += 1
}

var result = ""
for i in 0..<alphaArr.count {
    if alphaArr[i] >= 5 {
        result += String(UnicodeScalar(i + 97)!)
    }
}
if result.count == 0 {
    print("PREDAJA")
} else {
    print(result)
}
