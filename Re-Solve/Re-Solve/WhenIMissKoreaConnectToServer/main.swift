import Foundation

let num = Int(readLine()!)!

let lineArr = readLine()!.split(separator: "*")
let pre = lineArr[0]
let suf = lineArr[1]

for i in 0..<num {
    let temp = readLine()!
    if temp.hasPrefix(pre) && temp.hasSuffix(suf) && temp.count >= (pre.count + suf.count) {
        print("DA")
    } else {
        print("NE")
    }
}
