//: Sorting algorithms

import Foundation




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
}

let sort = Sort()
sort.array = [3,2,1]
sort.quickSort()
sort.array?.forEach({ (element) in
    print(element)
})
