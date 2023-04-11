import Foundation

let target = Int(readLine()!)!

var base = 1
var layer = 1

if target == 1 {
    print(1)
} else {
    while base < target {
        base += (layer * 6)
        layer += 1
    }
    print(layer)
}
