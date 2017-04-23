//
//  BinaryTree.swift
//  DataStructsSwift
//
//  Created by Ness on 4/13/17.
//  Copyright © 2017 Ness. All rights reserved.
//

import UIKit

public class BinaryTree<T:Comparable>
{
    public var root:BinaryTreeNode<T>?
    
    public init(root: T)
    {        
        self.root = BinaryTreeNode(value:root)
    }
    
    //MARK: ADD
    public func add(value: T)
    {
        guard let root = self.root else {
            
            print("Tree is empty")
            return
        }
        
        self.addHelper(node: root, value: value)
    }
    
    private func addHelper(node: BinaryTreeNode<T>, value: T)
    {
        if value < node.value
        {
            if let left = node.leftChild {
                self.addHelper(node: left, value: value)
            }
            else
            {
                let newNode = BinaryTreeNode(value:value)
                newNode.parent = node
                node.leftChild = newNode
            }
        }
        else if value > node.value
        {
            if let right = node.rightChild {
                
                self.addHelper(node: right, value: value)
            }
            else
            {
                let newNode = BinaryTreeNode(value:value)
                newNode.parent = node
                node.rightChild = newNode
            }
        }
        else
        {
            print("Duplicated")
        }
    }
    
    //MARK: SEARCH
    public func search(value:T) -> BinaryTreeNode<T>?
    {
        //Just in case root is removed at some point
        guard let root = self.root else {
            
            return nil
        }
        return self.searchHelper(node: root, value: value)
    }
    private func searchHelper(node: BinaryTreeNode<T>, value: T) -> BinaryTreeNode<T>?
    {
        
        if value == node.value
        {
            return node
        }
        else if value < node.value
        {
            if let left = node.leftChild {
            
                return self.searchHelper(node: left, value: value)
            }
            else
            {
                return nil
            }
        }
        else
        {
            if let right = node.rightChild {
                
                return self.searchHelper(node: right, value: value)
            }
            else
            {
                return nil
            }
        }
    }
    
    //MARK: MINIMUMS AND MAXIMUMS
    public func getMaximum() -> BinaryTreeNode<T>
    {
        if let right = self.root?.rightChild {
            
            return self.getMaximumHelper(node: right)
        }
        else
        {
            return self.root!
        }
    }
    
    private func getMaximumHelper(node: BinaryTreeNode<T>) -> BinaryTreeNode<T>
    {
        if let right =  node.rightChild {
            
            return self.getMaximumHelper(node: right)
        }
        else
        {
            return node
        }
    }

    public func getMinimum() -> BinaryTreeNode<T>
    {
        if let left = self.root?.leftChild {
            
            return self.getMinimumHelper(node: left)
        }
        else
        {
            return self.root!
        }
    }
    
    private func getMinimumHelper(node: BinaryTreeNode<T>) -> BinaryTreeNode<T>
    {
        if let left =  node.leftChild {
            
            return self.getMinimumHelper(node: left)
        }
        else
        {
            return node
        }
    }

    
    public func getMaximumValue() -> T?
    {
        guard let root = self.root else {
            
            print("empty tree")
            return nil
        }
        
        var prev = root.parent
        var current: BinaryTreeNode<T>? = root
        while(current != nil)
        {
            prev = current
            current = current?.rightChild
        }
        
        return prev?.value
    }
    
    public func getMinimumValue() -> T?
    {
        guard let root = self.root else {
            
            print("empty tree")
            return nil
        }
        
        var prev = root.parent
        var current:BinaryTreeNode<T>? = root
        while current != nil
        {
            prev = current
            current = current?.leftChild
        }
        
        return prev?.value
    }
    //MARK: ROTATIONS
    /*
        Two cases for rotation, it depends if the node being rotated is the root or not
     */
    public func rotateLeft(node:BinaryTreeNode<T>)
    {
        //IF THE ROOT IS BEING ROTATED
        if node.parent == nil
        {
            let x = node
            let y = node.rightChild
            
            x.rightChild = y?.leftChild
            y?.leftChild?.parent = x
            
            if x.parent == nil
            {
                self.root = y
            }
            
            y?.leftChild = x
            x.parent = y
            
        }
        else
        {
            //Set nodes: X is the rotating node
            //Y is taking X's place (upward)
            let x = node
            let y = node.rightChild
            
            //connect y left subtree with x right subtree (optionals take care of validations)
            x.rightChild = y?.leftChild
            y?.leftChild?.parent = x
            
            //update root
            if x.parent == nil
            {
                self.root = y
            }
            
            //Connect X's Parent with Y <->
            //Link x's parent with y
            y?.parent = x.parent
            if x === x.parent?.leftChild
            {
                //x is the left child
                x.parent?.leftChild = y
            }
            else
            {
                //x is the right child
                x.parent?.rightChild = y
            }
            
            //Put x on y's left
            y?.leftChild = x
            x.parent = y
        }
    }
    
    public func rotateRight(node:BinaryTreeNode<T>)
    {
        //IF THE ROOT IS BEING ROTATED
        if node.parent == nil
        {
            let x = node
            let y = node.leftChild
            
            x.leftChild = y?.rightChild
            y?.rightChild?.parent = x
            
            if x.parent == nil
            {
                self.root = y
            }
            
            y?.rightChild = x
            x.parent = y
            
        }
        else
        {
            //SET NODES
            let x = node
            let y = node.parent
            
            //Connect x's right subtree with y's left subtree
            y?.leftChild = x.rightChild
            x.rightChild?.parent = y
            
            //Update root
            if y?.parent == nil
            {
                self.root = x
            }
            
            //Connect Y's Parent with X <->
            //Link y's parent with x
            x.parent = y?.parent
            if y === y?.parent?.leftChild
            {
                //y is the left child
                y?.parent?.leftChild = x
            }
            else
            {
                //y is the right child
                y?.parent?.rightChild = x
            }
            
            //Put Y on X's right
            x.rightChild = y
            y?.parent = x
        }
    }

    //MARK: DELETE
    public func delete(node: BinaryTreeNode<T>?)
    {
        guard let nodeToDelete = node else {
            
            return
        }
        
        //We will have 3 cases, node to delete has 2 children, only left, only right
        if let left = node?.leftChild {
            
            if let right =  node?.rightChild {
                
                
            }
            
            //CASE 2: Node has only left child
            guard let parent = node?.parent else {
                //If parent is nil
                node?.leftChild?.parent = node?.parent  //set leftchild's to nil
                return
            }
            
            //Connect parent to child
            //If nodeToDelete is the left child, connect to the left only child
            left.parent = parent
            if parent.leftChild === nodeToDelete
            {
                parent.leftChild = left
            }
            else
            {
                parent.rightChild = left
            }
        }
        else if let right = node?.rightChild
        {
            //CASE 3: Node has only right child
            guard let parent = node?.parent else {
                node?.rightChild?.parent = node?.parent
                return
            }
            //Connect parent to child
            //If nodeToDelete is the left child, connect to the right only child
            right.parent = parent
            if parent.leftChild === nodeToDelete
            {
                parent.leftChild = right
            }
            else
            {
                parent.rightChild = right
            }
        }
    }
    
    private func connectNode(parent:BinaryTreeNode<T>?, to child:BinaryTreeNode<T>?)
    {
        //first check that the parent is not nil
        guard let p = parent else {
            
            child?.parent = parent //set child's parent to nil
            return
        }
        
        //if the node is the lf
    }
    
    //MARK: HEIGHT AND DEPTH
    public func height() -> Int
    {
        guard let root = self.root else {
            
            return 0
        }
        
        return self.heightHelper(node: root)
    }
    
    private func heightHelper(node: BinaryTreeNode<T>?) -> Int
    {
        if node?.rightChild == nil && node?.leftChild == nil
        {
            return 0
        }
        else
        {
            return 1 + max(self.heightHelper(node: node?.rightChild),self.heightHelper(node: node?.leftChild))
        }
    }
    
    public func depth(node:BinaryTreeNode<T>?) -> Int
    {
        guard var parent = node?.parent else {
            
            return 0
        }
        
        var depth = 0
        
        while (true)
        {
            depth = 1 + depth
            if let p = parent.parent {
                
                parent = p
            }
            else
            {
                break
            }
        }
        
        return depth
    }
    
    //MARK: PRINTING FUNCTIONS
    public func printRBTreeByLevels(nodes:[BinaryTreeNode<T>])
    {
        var children:[BinaryTreeNode<T>] = Array()
        for node in nodes
        {
            print("\(node.value) ")
            if let leftChild = node.leftChild {
                children.append(leftChild)
            }
            if let rightChild = node.rightChild {
                children.append(rightChild)
            }
        }
        if children.count > 0
        {
            print("************")
            printRBTreeByLevels(nodes: children)
        }
    }
    
    public func inOrder()
    {
        guard let root = self.root else {
            
            print("Tree empty")
            return
        }
        self.inOrderHelper(node: root)
    }
    
    private func inOrderHelper(node: BinaryTreeNode<T>?)
    {
        guard let n = node else {
            
            return
        }
        self.inOrderHelper(node: n.leftChild)
        print(n.value)
        self.inOrderHelper(node: n.rightChild)
    }

    public func preOrder()
    {
        guard let root = self.root else {
            
            print("Tree empty")
            return
        }
        self.preOrderHelper(node: root)
    }
    
    private func preOrderHelper(node: BinaryTreeNode<T>?)
    {
        guard let n = node else {
            
            return
        }
        print(n.value)
        self.preOrderHelper(node: n.leftChild)
        self.preOrderHelper(node: n.rightChild)
    }
    
    public func postOrder()
    {
        guard let root = self.root else {
            
            print("Tree empty")
            return
        }
        self.postOrderHelper(node: root)
    }
    
    private func postOrderHelper(node: BinaryTreeNode<T>?)
    {
        guard let n = node else {
            
            return
        }
        
        self.postOrderHelper(node: n.leftChild)
        self.postOrderHelper(node: n.rightChild)
        print(n.value)
    }
}



public class BinaryTreeNode<T:Comparable>
{
    public var value: T
    public var leftChild:BinaryTreeNode?
    public var rightChild:BinaryTreeNode?
    public weak var parent:BinaryTreeNode?
    
    public convenience init(value:T)
    {
        self.init(value: value, left: nil, right: nil, parent: nil)
    }
    
    public init(value:T, left:BinaryTreeNode?, right:BinaryTreeNode?, parent: BinaryTreeNode?)
    {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }
    
    public func insertNodeFromRoot(value: T)
    {
        //to maintain the binary search tree property we must ensure that we run the insertNode process from the root node
        if let _ = self.parent {
            
            print("You can only add new nodes from the root node of the tree")
            return
        }
        self.addNode(value: value)
    }
    
    public func addNode(value:T)
    {
        if value < self.value
        {
            if let left = self.leftChild {
                
                left.addNode(value: value)
            }
            else
            {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                self.leftChild = newNode
            }
        }
        else if value > self.value
        {
            if let right = self.rightChild {
                
                right.addNode(value: value)
            }
            else
            {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                self.rightChild = newNode
            }
            
        }
        else
        {
            print("dup")
        }
    }
    
    public class func traverseInOrder(node: BinaryTreeNode?)
    {
        guard let node = node else {
            
            return
        }
        BinaryTreeNode.traverseInOrder(node: node.leftChild)
        print(node.value)
        BinaryTreeNode.traverseInOrder(node: node.rightChild)        
    }
    
    public class func traversePreOrder(node: BinaryTreeNode?)
    {
        guard let node = node else {
            
            return
        }
        print(node.value)
        BinaryTreeNode.traversePreOrder(node: node.leftChild)
        BinaryTreeNode.traversePreOrder(node: node.rightChild)
    }
    
    public class func traversePostOrder(node: BinaryTreeNode?)
    {
        guard let node = node else {
            
            return
        }
        
        BinaryTreeNode.traversePostOrder(node: node.leftChild)
        BinaryTreeNode.traversePostOrder(node: node.rightChild)
        print(node.value)
    }
    
    
    public func search(value: T) -> BinaryTreeNode?
    {
        if value == self.value
        {
            return self
        }
        else if value < self.value
        {
            guard let left = self.leftChild else {
                
                return nil
            }
            
            return left.search(value: value)
        }
        else
        {
            guard let right = self.rightChild else {
                
                return nil
            }
            
            return right.search(value: value)
        }
    }
    
    public func delete()
    {
        if let left = leftChild {
            
            if let _ = rightChild {
                
                //node has 2 children
                self.exchangeWithSuccessor()
                
            }
            else
            {
                //Node has only left child
                self.connectParentTo(child: left)
            }
        }
        else if let right = rightChild {
            
            //Node has only right child
            self.connectParentTo(child: right)
        }
        else
        {
            //Node has no childs
            self.connectParentTo(child: nil)
        }
        
        //Delete refrences
        self.parent = nil
        self.leftChild = nil
        self.rightChild = nil
        
    }
    
    private func exchangeWithSuccessor()
    {
        //making sure node has both childs
        guard let right = self.rightChild, let left = self.leftChild else {
        
            return
        }
        
        //GET THE SUCCESSOR
        //The successor is the node with the lowest value in the right subtree
        let successor = right.minimum()
        //Disconnect the successor (this won't have any childs because is the minimum value)
        successor.delete()
        
        //CONNECT CURRENT DELETING NODE LEFT AND RIGHT CHILDS TO THE SUCCESSOR
        //Connect the left child with its new parent
        successor.leftChild = left
        left.parent = successor
        
        if right !== successor
        {
            //if the successor was NOT inmediatly connected to the deleted node
            successor.rightChild = right
            right.parent = successor
        }
        else
        {
            //If the successor was the right child of the deleted node
            //Then the successor won't have any childs
            successor.rightChild = nil
        }
        
        //CONNECT THE PARENT
        self.connectParentTo(child: successor)
    }
    
    private func connectParentTo(child: BinaryTreeNode?)
    {
        guard let parent = self.parent else {
            //set child to nil
            child?.parent = self.parent
            return
        }
        
        if parent.leftChild === self
        {
            //If self is the left child of its parent
            parent.leftChild = child
            child?.parent = parent
        }
        else if parent.rightChild === self
        {
            //If self is the right child of its parent
            parent.rightChild = child
            child?.parent = parent
        }
    }
    
    public func minimumValue() -> T
    {
        if let left = leftChild {
            
            return left.minimumValue()
        }
        else
        {
            return value
        }
    }
    
    public func maximumValue() -> T
    {
        if let right = rightChild {
            
            return right.maximumValue()
        }
        else
        {
            return value
        }
    }
    public func minimum() -> BinaryTreeNode
    {
        if let left = leftChild {
            
            return left.minimum()
        }
        else
        {
            return self
        }
    }
    
    public func maximum() -> BinaryTreeNode
    {
        if let right = rightChild {
            
            return right.maximum()
        }
        else
        {
            return self
        }
    }
    
    public func height()-> Int
    {
        if leftChild == nil && rightChild == nil
        {
            return 0
        }
        
        return 1 + max(leftChild?.height() ?? 0, rightChild?.height() ?? 0)
    }
    
    public func depth() -> Int
    {
        guard var node = parent else {
            
            return 0
        }
        var depth = 1
        
        while let parent = node.parent {
            depth = depth + 1
            node = parent
        }
        
        return depth
    }
}


