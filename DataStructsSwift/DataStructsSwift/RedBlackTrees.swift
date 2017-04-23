//
//  RedBlackTrees.swift
//  DataStructsSwift
//
//  Created by Ness on 4/14/17.
//  Copyright © 2017 Ness. All rights reserved.
//

import UIKit

//MARK: COLOR ENUM
public enum RBTreeColor: Int
{
    case black = 0
    case red = 1
}

//MARK: NODE
public class RedBlackTreeNode<T:Comparable>
{
    public var value:T
    public var left:RedBlackTreeNode?
    public var right:RedBlackTreeNode?
    public weak var parent:RedBlackTreeNode?
    public var color:RBTreeColor
    
    public convenience init(value: T)
    {
        //Nodes are created with black color by default
        self.init(value: value, left:nil, right:nil, parent:nil, color: .black)
    }
    
    public init(value:T, left: RedBlackTreeNode?, right: RedBlackTreeNode?, parent:RedBlackTreeNode?, color: RBTreeColor)
    {
        self.value = value
        self.left = left
        self.right = right
        self.parent = nil
        self.color = .black
    }
    
}

//MARK: RED BLACK TREE
public class RedBlackTree<T:Comparable>
{
    //Keep the root
    public var root: RedBlackTreeNode<T>?
    
    //init with root value
    public init(root: T)
    {
        print("You have created a new RedBlack tree: root->\(root)")
        self.root = RedBlackTreeNode(value:root)
    }
    
    
    //MARK: ADD NODE
    public func addNode(value: T)
    {
        //Check the tree is not empty
        guard let r = root else {
            
            return
        }
        
        //Start by the root node
        self.addNodeHelper(node: r, value: value)
    }
    
    private func addNodeHelper(node: RedBlackTreeNode<T>, value: T)
    {
        //go left
        if value < node.value
        {
            if let left = node.left {
                
                self.addNodeHelper(node: left, value: value)
            }
            else
            {
                let newNode = RedBlackTreeNode(value:value)
                newNode.color = .red    //Remember to add red nodes to tree
                node.left = newNode
                newNode.parent = node
                self.fixup(node: newNode)
            }
        }//go right
        else if value > node.value
        {
            if let right = node.right {
                
                self.addNodeHelper(node: right, value: value)
            }
            else
            {
                let newNode = RedBlackTreeNode(value:value)
                newNode.color = .red       //Remember to add red nodes to tree
                node.right = newNode
                newNode.parent = node
                self.fixup(node: newNode)
            }
        }
        else
        {
            print("Duplicated")//can't add duplicated values
        }
    }
    
    private func fixup(node: RedBlackTreeNode<T>)
    {
        var z = node
        while z.parent?.color == .red
        {
            //is z's parent a left child
            if z.parent === z.parent?.parent?.left
            {
                //get right uncle
                let y = z.parent?.parent?.right
                //case 1: z's uncle is red
                if y?.color == .red
                {
                    z.parent?.color = .black
                    y?.color = .black
                    z.parent?.parent?.color = .red
                    if let zGrandParent = z.parent?.parent {
                        z = zGrandParent
                    }
                }
                else
                {   //case 2: z's uncle is black and z is right child
                    if z === z.parent?.right
                    {
                        if let zParent = z.parent {
                            
                            z = zParent
                            self.rotateLeft(node: z)
                        }
                    }
                    //Case 3: z's uncle is black and z is left child
                    z.parent?.color = .black
                    z.parent?.parent?.color = .red
                    if let zGrandParent = z.parent?.parent {
                        
                        self.rotateRight(node: zGrandParent)
                    }
                }
            }
            else
            {
                //get left uncle
                let y = z.parent?.parent?.left
                //case 1: z's uncle is red
                if y?.color == .red
                {
                    z.parent?.color = .black
                    y?.color = .black
                    z.parent?.parent?.color = .red
                    if let zGrandParent = z.parent?.parent {
                        z = zGrandParent
                    }
                }
                else
                {   //Case 2:
                    if z === z.parent?.left
                    {
                        if let zParent = z.parent {
                            z = zParent
                            self.rotateRight(node: z)
                        }
                    }
                    //Case 3:
                    z.parent?.color = .black
                    z.parent?.parent?.color = .red
                    if let zGrandParent =  z.parent?.parent {
                        
                        self.rotateLeft(node: zGrandParent)
                    }
                }                
            }
        }
        self.root?.color = .black
    }
    
    //MARK: PRINT TREE
    public func traverseInOrder()
    {
        guard let r = self.root else {
            
            return
        }
        self.traverseInOrderHelper(node: r)
    }

    private  func traverseInOrderHelper(node: RedBlackTreeNode<T>?)
    {
        if node == nil
        {
            return
        }
        self.traverseInOrderHelper(node: node?.left)
        print(node?.value)
        self.traverseInOrderHelper(node: node?.right)
    }
    
    public func printRBTreeByLevels(nodes:[RedBlackTreeNode<T>])
    {
        var children:[RedBlackTreeNode<T>] = Array()
        for node in nodes
        {
            print("\(node.value) " + " \(node.color)")
            if let leftChild = node.left {
                children.append(leftChild)
            }
            if let rightChild = node.right {
                children.append(rightChild)
            }
        }
        if children.count > 0
        {
            print("************")
            printRBTreeByLevels(nodes: children)
        }
    }
    
    public func search(value: T) -> RedBlackTreeNode<T>?
    {
        guard let node = self.root else {
        
            return nil
        }
        
        return self.searchHelper(node:node, value:value)
    }
    
    public func searchHelper(node: RedBlackTreeNode<T>, value: T) -> RedBlackTreeNode<T>?
    {
        if value == node.value
        {
            return node
        }
        else if value < node.value
        {
            guard let leftNode = node.left else {
                
                return nil
            }
            return self.searchHelper(node: leftNode, value: value)
         
        }
        else if value > node.value
        {
            guard let rightNode = node.right else {
                
                return nil
            }
            return searchHelper(node: rightNode, value: value)
        }
        
        return nil        
    }
    
    //MARK: ROTATIONS
    /*
     On left rotation, the rotated node (x) will be moved to a lower position
     */
    public func rotateLeft(node:RedBlackTreeNode<T>)
    {
        //IF THE ROOT IS BEING ROTATED
        if node.parent == nil
        {
            let x = node
            let y = node.right
            
            x.right = y?.left
            y?.left?.parent = x
            
            if x.parent == nil
            {
                self.root = y
            }
            
            y?.left = x
            x.parent = y
            
        }
        else
        {
            //Set nodes: X is the rotating node
            //Y is taking X's place (upward)
            let x = node
            let y = node.right
            
            //connect y left subtree with x right subtree (optionals take care of validations)
            x.right = y?.left
            y?.left?.parent = x
            
            //update root
            if x.parent == nil
            {
                self.root = y
            }
            
            //Connect X's Parent with Y <->
            //Link x's parent with y
            y?.parent = x.parent
            if x === x.parent?.left
            {
                //x is the left child
                x.parent?.left = y
            }
            else
            {
                //x is the right child
                x.parent?.right = y
            }
            
            //Put x on y's left
            y?.left = x
            x.parent = y
        }
    }
    
    public func rotateRight(node:RedBlackTreeNode<T>)
    {
        //IF THE ROOT IS BEING ROTATED
        if node.parent == nil
        {
            let x = node
            let y = node.left
            
            x.left = y?.right
            y?.right?.parent = x
            
            if x.parent == nil
            {
                self.root = y
            }
            
            y?.right = x
            x.parent = y
            
        }
        else
        {
            //SET NODES
            let x = node
            let y = node.parent
            
            //Connect x's right subtree with y's left subtree
            y?.left = x.right
            x.right?.parent = y
            
            //Update root
            if y?.parent == nil
            {
                self.root = x
            }
            
            //Connect Y's Parent with X <->
            //Link y's parent with x
            x.parent = y?.parent
            if y === y?.parent?.left
            {
                //y is the left child
                y?.parent?.left = x
            }
            else
            {
                //y is the right child
                y?.parent?.right = x
            }
            
            //Put Y on X's right
            x.right = y
            y?.parent = x
        }
    }
}


