import UIKit
import Foundation

struct CountedSet<Element: Hashable> {
    private(set) var elements: [Element : Int] = [:]
    
    mutating func insert(_ element: Element) {
        if let _ = elements[element] {
            elements[element]! += 1
        } else {
            elements[element]! = 1
        }
    }
    
    mutating func remove(_ element: Element) -> Int {
        guard let count = elements[element] else { return 0 }
        
        if count > 0 {
             elements[element]! -= 1
        } else {
            elements.removeValue(forKey: element)
        }
        return elements[element] ?? 0
    }
    
    subscript(_ member: Element) -> Int {
        return elements[member] ?? 0
    }
}

extension CountedSet: ExpressibleByArrayLiteral {
    init(arrayLiteral elementsArray: Element...) {
           for element in elementsArray {
               elements[element] = (elements[element] ?? 0) + 1
           }
       }
}



enum Arrow { case iron, wooden, elven, dwarvish, magic, silver }
var aCountedSet = CountedSet<Arrow>()
aCountedSet[.iron] // 0
var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]
myCountedSet[.iron] // 4
myCountedSet.remove(.iron) // 3
myCountedSet.remove(.dwarvish) // 0
myCountedSet.remove(.magic) // 0
