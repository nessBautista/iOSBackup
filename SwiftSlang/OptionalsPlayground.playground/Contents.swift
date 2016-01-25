//: Playground - noun: a place where people can play

import UIKit


var str: String?

str = "Hola"
str
print(str)


var ab:String?
var ac:String?
var ad:Int?
var ae:String?

ab = "Hola"
ac = "Mundo"
ad = 3
ae = "veces"



if let ab = ab, let ac = ac, let ad = ad where ad != 2, let ae = ae{
    print(ab,ac,ad,ae)
}




guard let vab = ab where vab.characters.count > 0 else{
    print("variable is empty")
    throw NSError(domain: "Optional is Empty", code: 0, userInfo: nil)
}
print(vab)

var suma3 = {(numero:Int)-> Int in return numero + 3}

suma3(5)

var numero1 = 20
var numero2 = 40
var suma1n2 = {() -> Int in return numero1 + numero2 }

suma1n2()
numero1 += 10
suma1n2()


