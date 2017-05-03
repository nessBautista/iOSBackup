//: [Previous](@previous)

import Foundation

//Utilities

/* Obtain numbers from string*/
let input = " 98 ,99 , 97, 96 "
let values = input.components(separatedBy: ",").flatMap { Int($0.trimmingCharacters(in: .whitespaces)) }
let sum = values.reduce(0, +)
print(sum)  // 390
//values.forEach({print($0)})

/*Obtain char array from string*/
let in2 = "abcdef"
var arrayIn2 = in2.characters.map({$0})
arrayIn2.forEach({print($0)})

