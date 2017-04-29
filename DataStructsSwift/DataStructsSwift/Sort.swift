//
//  Sort.swift
//  DataStructsSwift
//
//  Created by Nestor Javier Hernandez Bautista on 4/29/17.
//  Copyright © 2017 Ness. All rights reserved.
//

import UIKit

class Sort: NSObject
{
    var array: [Int]?
    
    //MARK: QUICK SORT
    public func quickSort()
    {
        guard let array = self.array else {
            
            return
        }
        self.quickSortHelper(0, array.count - 1)
    }
    
    private func quickSortHelper(_ left:Int, _ right: Int)
    {
        guard let array = self.array else {
            
            return
        }
        
        if left >= right
        {
            return
        }
        
        let pivotIdx : Int = (left + right) / 2
        let pivot = array[pivotIdx]
        
        //This is going to be the division point of the array
        let index = self.partition(left, right, pivot)
        
        //Perform recursion
        quickSortHelper(left, index - 1)
        quickSortHelper(index, right)
        
    }
    
    private func partition(_ l:Int, _ r: Int, _ pivot: Int) -> Int
    {
        var right = r
        var left = l
        guard let array = self.array else {
            
            return -1
        }
        
        while(left <= right)
        {
            while array[left] < pivot
            {
                left += 1
            }
            
            while array[right] > pivot
            {
                right -= 1
            }
            
            if left <= right
            {
                self.swap(array, left, right)
                left += 1
                right -= 1
            }
            
        }
        return left
    }
    
    func swap(_ array:[Int],_ a:Int, _ b: Int)
    {
        let tempA = array[a]
        let tempB = array[b]
        
        self.array?[a] = tempB
        self.array?[b] = tempA
    }
    
    //MARK: INSERTION SORT
    func insertionSort()
    {
        guard var array = self.array else {
            
            return
        }
        
        for j in 1...array.count - 1
        {
            let key = array[j]
            var i = j - 1
            while(i >= 0 && array[i] > key)
            {
                array[i + 1] = array[i]
                i -= 1
            }
            array[i + 1] = key            
        }
        self.array = array
    }
}
