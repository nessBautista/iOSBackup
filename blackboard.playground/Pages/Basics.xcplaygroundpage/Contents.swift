//: [Previous](@previous)

import UIKit

class ElectricVehicle
{
    static var count = 0
    var passengerCapacity: Int = 4
    let zeroTo60: Float
    var color: UIColor
    
    init(passengerCapacity:Int, zeroTo60:Float, color:UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    {
        self.passengerCapacity = passengerCapacity
        self.zeroTo60 = zeroTo60
        self.color = color
        ElectricVehicle.count += 1
    }
    
    convenience init(zeroTo60:Float)
    {
        self.init(passengerCapacity:4, zeroTo60:zeroTo60)
    }
    
    convenience init()
    {
        self.init(zeroTo60: 6.0)
    }
    deinit
    {
        ElectricVehicle.count -= 1
    }
}

let teslaModelS = ElectricVehicle(passengerCapacity: 4, zeroTo60: 2.5)
var teslaModel3: ElectricVehicle? = ElectricVehicle(passengerCapacity: 5, zeroTo60: 1.5)
teslaModel3 = nil

//See how deinitializer modifies counter
ElectricVehicle.count

//The color is changed by reference
let p100d = teslaModelS
teslaModelS.color
p100d.color = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
teslaModelS.color
//Realize how p100d properties can be change even if it's declared as a constant




//Strings

//Passed by copy
let quote = "In the end, we only regrest the chances we didn't take"
var newQuote = quote
newQuote = "In the end, it's not the years in your life that count. It's the life in your years"
print(quote)


//Access string individual characters.
quote.characters.count
let quoteArray = quote.characters.map({$0})
quote.uppercased()
//quote.lowercased()
print(quote.uppercased())


//Repeating
String(repeating: "😀", count: 5)

//Replacing occurences
let verse1 = "I like to eat, eat, eat, apples and bananas!"
let verse2 = verse1.replacingOccurrences(of: "eat", with: "ate")
            .replacingOccurrences(of: "ap", with: "ay-")
            .replacingOccurrences(of: "bananas", with: "ba-nay-nays")

print(verse1, verse2, separator:"\n")

//Range of operators
let rangeA  = 0..<10
rangeA.count

let rangeB = 0...10
rangeB.count

var fibonacciNumbers = [1, 3, 6,10, 15, 21]
let replacement = [1,2,3,5,8,13]
fibonacciNumbers.replaceSubrange(1..<5, with: replacement)
print(fibonacciNumbers)


