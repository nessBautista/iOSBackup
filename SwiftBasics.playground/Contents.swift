//: Playground - noun: a place where people can play

import UIKit


/*          Value types (passed by copy)
    Enumerations
    Structs: Integers, floating points, booleans, characters, strings, arrays, dictionaries and tuples
 
            References Types (passed by reference)
    Classes
    Functions and closures
 */

class MyClass
{
    //Initializers, deinitializers, properties, methods, subscripts
}
class Vehicle
{
    //Type Propertie
    static var count = 0
    
    //properties
    var passengerCapacity = 4
    let zeroTo60: Float
    var color: UIColor
    
    //Initializers
    init(passengerCapacity:Int, zeroTo60: Float, color:UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
    {
        self.passengerCapacity = passengerCapacity
        self.zeroTo60 = zeroTo60
        self.color = color
        Vehicle.count += 1
    }
    
    convenience init(passengerCapacity: Int)
    {
        self.init(passengerCapacity: passengerCapacity, zeroTo60: 2.0)
    }
    
    convenience init(zeroTo60:Float)
    {
        self.init(passengerCapacity: 4, zeroTo60: zeroTo60)
    }
    convenience init()
    {
        self.init(passengerCapacity: 4, zeroTo60: 2.0)
    }
    
    //Deinitializers
    deinit
    {
        Vehicle.count -= 1
    }
    
    //Class type methods
    static func printCount()
    {
        print("Count: \(count)")
    }
    //Instance Methods
    func start()
    {
        fatalError("Override in subclass")
    }

}
class ElectricVehicle: Vehicle
{
    let rangePerCharge:Int
    init(rangePerCharge: Int)
    {
        self.rangePerCharge = rangePerCharge
        super.init(passengerCapacity: 4, zeroTo60: 2.0)
    }
    convenience init()
    {
        self.init(rangePerCharge: 500)
    }
    
    override func start()
    {
        print("silence")
    }
    
}

//Create Instances of electric Vehicle
let teslaModelS = ElectricVehicle()
var teslaModel3: ElectricVehicle? = ElectricVehicle()
ElectricVehicle.count
teslaModel3 = nil
ElectricVehicle.count


//Change how you can change the var color of a constant instance
teslaModelS.color
let myTesla = teslaModelS
myTesla.color = .red
teslaModelS.color
ElectricVehicle.printCount()
myTesla.start()



