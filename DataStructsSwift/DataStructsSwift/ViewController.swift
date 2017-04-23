//
//  ViewController.swift
//  DataStructsSwift
//
//  Created by Ness on 4/13/17.
//  Copyright © 2017 Ness. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //self.testRedBlackTree()
        //self.testBinaryTree()
        
        self.checkExample()
        
    }
    
    func checkExample()
    {
        let binaryTree = BinaryTree(root: 10)
        binaryTree.add(value: 5)
        binaryTree.add(value: 15)
        binaryTree.add(value: 4)
        binaryTree.add(value: 8)
        binaryTree.add(value: 13)
        binaryTree.add(value: 20)
        binaryTree.add(value: 11)
        binaryTree.add(value: 25)
        
        let ex = TreeEx<Int>()
        
//        //Check balance
//        let isBalance = ex.isBinaryTreeBalanced(tree: binaryTree)
//        print(isBalance)
//        
//        //LCA
//        if let LCA = ex.LCA_parentPointers(n0: binaryTree.search(value:11), n1: binaryTree.search(value: 4)) {
//            print(LCA.value)
//        }
        
        //has sum
        let hasSum = ex.hasPathSum(tree: binaryTree, targetSum: 10)
        print(hasSum)
        
        let exterior = ex.exterior(tree: binaryTree)
        for node in exterior
        {
            print(node.value)
        }
        
    }
    
    func testRedBlackTree()
    {
        let tree = RedBlackTree(root: 11)
        tree.addNode(value: 2)
        tree.addNode(value: 14)
        tree.addNode(value: 1)
        tree.addNode(value: 7)
        tree.addNode(value: 15)
        tree.addNode(value: 5)
        tree.addNode(value: 8)
        tree.addNode(value: 6)
        tree.addNode(value: 20)
        tree.addNode(value: 3)
        tree.addNode(value: 4)
        tree.printRBTreeByLevels(nodes: [tree.root!])
        
//        //Create a red black tree
//        let tree = RedBlackTree(root: 10)
//        tree.addNode(value: 5)
//        tree.addNode(value: 20)
//        tree.addNode(value: 4)
//        tree.addNode(value: 8)
//        tree.addNode(value: 21)
//        tree.addNode(value: 6)
//        tree.addNode(value: 9)
//        
//        //tree.traverseInOrder()
//        tree.printRBTreeByLevels(nodes: [tree.root!])
//        
//        
//        if let target = tree.search(value: 5) {
//            
//            tree.rotateRight(node: target)
//            print("parent: \(target.parent?.value), left:\(target.left?.value), right:\(target.right?.value)")
//            print("Root:\(tree.root?.value)")
//        }
//        tree.printRBTreeByLevels(nodes: [tree.root!])
        
    }
    
    func testBinaryTree()
    {
        let bst = BinaryTree(root: 10)
        bst.add(value: 5)
        bst.add(value: 15)
        bst.add(value: 4)
        bst.add(value: 8)
        
        //Test search
        let target = bst.search(value: 5)
        target?.delete()
        //Text Max and Min
        //print(bst.getMaximum().value)
        //print(bst.getMinimum().value)
        bst.printRBTreeByLevels(nodes: [bst.root!])
        //print(bst.height())
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

