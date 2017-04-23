//
//  TreeEx.swift
//  DataStructsSwift
//
//  Created by Ness on 4/16/17.
//  Copyright © 2017 Ness. All rights reserved.
//

import UIKit

class TreeEx<T:Comparable>: NSObject
{
    /*
     This function checks if the binary tree acomplish with the balance condition
     That is, that the difference betweent the left and right subtrees is at most 1
     */
    public func isBinaryTreeBalanced(tree:BinaryTree<T>) -> Bool
    {
        guard let root = tree.root else {
            print("empty tree")
            return false
        }
        
        return self.checkBalance(node: root).isBalance
    }
    
    private func checkBalance(node: BinaryTreeNode<T>?) -> (isBalance: Bool, height: Int)
    {
        //Base case
        if node == nil
        {
            return (true, -1)
        }
        
        let leftResult = self.checkBalance(node: node?.leftChild)
        if leftResult.isBalance == false
        {
            return (false, 0)
        }
        let rightResult = self.checkBalance(node: node?.rightChild)
        if rightResult.isBalance == false
        {
            return (false, 0)
        }
        
        let isBalanced = abs(leftResult.height - rightResult.height) <= 1
        let height = max(leftResult.height, rightResult.height) + 1
        
        return (isBalanced, height)
    }
    
    /*
     Check if a binary tree is simmetric
     
     */
    func isSymmetric(tree: BinaryTree<T>) -> Bool
    {
        guard let root = tree.root else {
            
            //Yes if doesn't exist, then it is symmetric
            return true
        }
        return self.checkSymmetric(subtree0: root.leftChild, subtree1: root.rightChild)
    }
    
    private func checkSymmetric(subtree0:BinaryTreeNode<T>?, subtree1:BinaryTreeNode<T>?) -> Bool
    {
        if subtree0 == nil  && subtree1 == nil
        {
            return true
        }
        else if subtree0 != nil && subtree1 != nil
        {
            return subtree0?.value == subtree1?.value &&
                   checkSymmetric(subtree0: subtree0?.leftChild, subtree1: subtree1?.rightChild) &&
                   checkSymmetric(subtree0: subtree0?.rightChild, subtree1: subtree1?.leftChild)
            
        }
        
        return false
    }
    
    /*
        Compute the lowest common ancestor in a binarty tree
     */
    func LCA(tree: BinaryTreeNode<T>?,
             n1: BinaryTreeNode<T>?,
             n2: BinaryTreeNode<T>?) -> BinaryTreeNode<T>?
    {
        //Check you have all data input to look for LCA
        guard let node1 = n1, let node2 = n2 else {
            
            return nil
        }
        return LCAHelper(tree:tree, n1:node1, n2:node2).ancestor
    }
    
    private func LCAHelper(tree: BinaryTreeNode<T>?,
                           n1: BinaryTreeNode<T>,
                           n2: BinaryTreeNode<T>) -> (numNodes:Int, ancestor:BinaryTreeNode<T>?)
    {
        if tree == nil
        {
            return (0, nil)
        }
        
        let leftResult = LCAHelper(tree: tree?.leftChild, n1: n1, n2: n2)
        if leftResult.numNodes == 2
        {
            return leftResult
        }
        
        let rightResult = LCAHelper(tree: tree?.rightChild, n1: n1, n2: n2)
        if rightResult.numNodes ==  2
        {
            return rightResult
        }
        
        let foundNode1 = tree === n1 ? 1 : 0
        let foundNode2 = tree === n2 ? 1 : 0
        let numOfNodesFound = leftResult.numNodes + rightResult.numNodes + foundNode1 + foundNode2
        
        return (numOfNodesFound, numOfNodesFound == 2 ? tree : nil)
    }
    
    func LCA_parentPointers(n0: BinaryTreeNode<T>?, n1: BinaryTreeNode<T>?) -> BinaryTreeNode<T>?
    {
        var node0:BinaryTreeNode<T>?  = n0
        var node1:BinaryTreeNode<T>?  = n1
        let depth0 = n0?.depth() ?? 0
        let depth1 = n1?.depth() ?? 0
        
        //lets ensure depth0 is depest 
        if depth1 > depth0
        {
            node0 = node1
            node1 = node0
        }
        
        //Ascend from deper node
        var depth_diff = abs(depth0 - depth1)
        while (depth_diff != 0)
        {
            node0 = node0?.parent
            depth_diff = depth_diff - 1
        }
        
        //Now ascend from both parents until we reach the LCA
        while(node0 !== node1)
        {
            node0 = node0?.parent
            node1 = node1?.parent
        }
        
        return node0
    }
    
    /*
        find a root to leaft path with specified sum
     */
    func hasPathSum(tree:BinaryTree<Int>, targetSum:Int) -> Bool
    {
        guard let root = tree.root else {
            
            return false
        }
        return hasPathSumHelper(n: root, partialSum: 0, targetSum: targetSum)
    }
    
    private func hasPathSumHelper(n:BinaryTreeNode<Int>?, partialSum:Int, targetSum:Int) -> Bool
    {
        guard let node = n else {
            
            return false
        }
        
        
        let partial_path_sum = partialSum + node.value
        
        if (node.leftChild == nil && node.rightChild == nil)
        {
            //We are in a leaf, you can evaluate now
            return partial_path_sum == targetSum
        }
        return hasPathSumHelper(n: node.leftChild, partialSum: partial_path_sum, targetSum: targetSum) ||
        hasPathSumHelper(n: node.rightChild, partialSum: partial_path_sum, targetSum: targetSum)
    }
    
    /*
     Compute the exterior of a binary tree
     
     */
    func exterior(tree: BinaryTree<T>)-> [BinaryTreeNode<T>]
    {
        guard let root = tree.root else {
            
            return [BinaryTreeNode<T>]()
        }
        
        
        
        var exterior = [root]
        var exterior1 = self.leftBoundaryAndLeaves(subtree: root.leftChild, isBoundary: true)
        var exterior2 = self.rightBoundaryAndLeaves(subtree: root.rightChild, isBoundary: true)
        exterior.append(contentsOf: exterior1)
        exterior.append(contentsOf: exterior2)
        
        return exterior
    }
    
    //Computes the nodes from the root to the leftmost leaf followed by all the leaves in subtree
    private func  leftBoundaryAndLeaves(subtree: BinaryTreeNode<T>?, isBoundary:Bool) -> [BinaryTreeNode<T>]
    {
        var result = [BinaryTreeNode<T>]()
        guard let node = subtree else {
            
            return result
        }
        
        if isBoundary == true || self.isLeaf(node: node) == true
        {
            result.append(node)
        }
        result.append(contentsOf: leftBoundaryAndLeaves(subtree: node.leftChild, isBoundary: isBoundary))
        result.append(contentsOf: leftBoundaryAndLeaves(subtree: node.rightChild, isBoundary: isBoundary && node.leftChild == nil))
        
        
        return result
    }
    
    //Computes the leaves in left-right order followed by the rightmost leaft
    //to the root path in subtree
    
    private func  rightBoundaryAndLeaves(subtree: BinaryTreeNode<T>?, isBoundary:Bool) -> [BinaryTreeNode<T>]
    {
        var result = [BinaryTreeNode<T>]()
        guard let node = subtree else {
            
            return result
        }
        
        result.append(contentsOf: rightBoundaryAndLeaves(subtree: node.leftChild,
                                                         isBoundary: isBoundary && subtree?.rightChild == nil))
        
        result.append(contentsOf: rightBoundaryAndLeaves(subtree: node.rightChild, isBoundary: isBoundary))
        
        if isBoundary == true || isLeaf(node: node) == true
        {
            result.append(node)
        }
        
        return result
    }
    
    private func isLeaf(node: BinaryTreeNode<T>) -> Bool
    {
        return node.leftChild == nil && node.rightChild == nil
    }
}
