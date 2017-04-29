//
//  Graph.swift
//  DataStructsSwift
//
//  Created by Nestor Javier Hernandez Bautista on 4/25/17.
//  Copyright © 2017 Ness. All rights reserved.
//

import UIKit

class Graph: NSObject
{
    let directed: Bool
    var edges:[Node?]
    var degree:[Int]
    var nEdges = 0
    //For traversal
    var discovered: [Bool]
    var processed: [Bool]
    
    init(nVertices: Int, directed: Bool)
    {
        self.directed = directed
        self.edges = [Node?](repeating: nil, count: nVertices)
        self.degree = [Int](repeating: 0, count: nVertices)
        
        self.discovered = [Bool](repeating: false, count: nVertices)
        self.processed = [Bool](repeating: false, count: nVertices)
    }
    
    func addEdge(x: Int, y: Int, directed:Bool)
    {
        let node = Node(value: y)
        
        node.next = self.edges[x]
        self.edges[x] = node
        
        self.degree[x] += 1
        
        if directed == false
        {
            self.addEdge(x: y, y: x, directed: true )
        }
        else
        {
            self.nEdges += 1
        }
    }
    
    func printGraph()
    {
        for (index, item) in self.edges.enumerated()
        {
            var node = item
            print("->\(index)")
            while(node != nil)
            {
                print(node?.y)
                node = node?.next
            }
            print("********")            
        }
    }
}

class Node
{
    var y: Int
    var next: Node?
    var weight: Int?
    
    init(value: Int)
    {
        self.y = value
    }
}
