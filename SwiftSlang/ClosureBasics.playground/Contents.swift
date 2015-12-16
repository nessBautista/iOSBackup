//: Playground - noun: a place where people can play

import UIKit


//http://fuckingclosuresyntax.com
//http://fuckingswiftblocksyntax.com

func jediTrainer()->((String, Int)-> String){
    func train(name:String, times:Int)->(String){
        return "\(name)  has been trained in the force \(times) times"
    }
    return train
}

let train = jediTrainer()
train("Obi Wan", 3)

//Passing and returning functions


/*          CLOSURES
Closure expressions are a way to write inline closures in a brief, focused syntax. Closure expressions provide several syntax optimizations for writing closures in a shortened form without loss of clarity or intent. The closure expression examples below illustrate these optimizations by refining a single example of the sort(_:) method over several iterations, each of which expresses the same functionality in a more succinct way.

    The sort method: The sort method...

*/



let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)


/*
Basic closure syntax
*/

reversed  = names.sort({(s1:String, s2:String)->Bool in
    return s1 > s2
})


/*
Inferring type from context
*/

reversed = names.sort({s1,s2 in return s1 > s2})

/*
            Trailing Closures
Trailing closures are most useful when the closure is sufficiently long that is not possible to write it inline on a single line. For example, the map(_:) function method takes as a single argument a closure expression, which is called once for each item in the array, and it returns an alternative mapped value (possible of some other type) for that item
*/

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]
