import UIKit

// Strings are not arrays
let name = "Taylor"

// Sure we can iterate through them
for letter in name {
  print("Give me a \(letter)!")
}

// But we can't get a letter by index
// print(name[3]) // does not compile

// We access a letter by index like that
let letter = name[name.index(name.startIndex, offsetBy: 3)]

// We can also make an extension
extension String {
  subscript(i: Int) -> String {
    return String(self[index(startIndex, offsetBy: i)])
  }
}

// So now, that works
let letter2 = name[3]
