//: Playground - noun: a place where people can play

import UIKit



func howManySwaps(array: [Int])-> Int
{
    var response = travel(array)
    var c = response.count > 0 ? 1 : 0
    
    while response.count != 0
    {
        response = travel(response)
        if response.count > 0
        {
            c += 1
        }
    }
    
    return c
}

func travel(_ array: [Int]) -> [Int]
{
    var swapArray = [Int]()
    for i in 0..<array.count
    {
        //safety check
        if i + 1 == array.count
        {
            break
        }
        
        //Fiding an item out of order
        let j = i + 1
        if(array[i] > array[j])
        {
           swapArray = swap(array, i, j)
            break
        }
    }
    
    return swapArray
}

func swap(_ array:[Int], _ a: Int, _ b:Int ) ->[Int]
{
    //Safe
    guard a < array.count, b < array.count else {
        
        return [Int]()
    }
    
    let tempA = array[a]
    let tempB = array[b]
    
    var response = array
    response[a] = tempB
    response[b] = tempA
    
    return response
}

let input = [2, 1, 3, 1 , 2]
let input2 = [1,4,1,3,1]

print(howManySwaps(array: input2))
/*
func printDictionary(_ dict: Dictionary<String,Int>)
{
    for word in dict
    {
        print(word)
    }
}


func convertStringToWordArray(str:String) -> [String]
{
    let array = str.components(separatedBy: " ")
    
    return array
}

func storeWordsIndDictionary(words:[String]) -> Dictionary<String,Int>
{
    var dictionary : Dictionary<String, Int> = [:]
    
    for word in words
    {
        if dictionary[word] == nil
        {
            dictionary[word] = 1
        }
        else
        {
            dictionary[word] = dictionary[word]! + 1
        }
    }
    return dictionary
}

func compare(_ dictionary:Dictionary<String,Int>, inDict:Dictionary<String,Int>)-> Bool
{
    for item in dictionary
    {
        if inDict[item.key] == nil
        {
            return false
        }
    }
    
    return true
}
let letter = "give one grand today june"
let magazine = "give me one grand today night"

var arrayLetter = convertStringToWordArray(str: letter)
var dictLetter = storeWordsIndDictionary(words: arrayLetter)

var arrayMagazine = convertStringToWordArray(str: magazine)
var dictMagazine = storeWordsIndDictionary(words: arrayMagazine)

printDictionary(dictLetter)
printDictionary(dictMagazine)

if compare(dictLetter, inDict: dictMagazine) == true
{
    print("YES")
}
else
{
    print("NO")
}
*/



