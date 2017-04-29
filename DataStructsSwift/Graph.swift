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
    //Basics
    var edges: [GraphNode?]     //adjacency list
    var nVertices: Int          //Number of vertices
    var parent:[Int]            //Parent Array of each vertex
    var degree:[Int]            //Degree of connection
    var nEdges:Int = 0
    var isDirected: Bool = false
    //For Traversal
    var discovered:[Bool]
    var processed:[Bool]
    var time_exit:[Int]
    var time_entry:[Int]
    
    
    init(vertices: Int)
    {
        self.nVertices = vertices
        self.edges = [GraphNode?](repeating: nil, count: vertices)
        self.parent = [Int](repeating: -1, count: vertices)
        self.degree = [Int](repeating: 0, count: vertices)
        
        self.discovered = [Bool](repeating: false, count: vertices)
        self.processed = [Bool](repeating: false, count: vertices)
        self.time_entry = [Int](repeating: 0, count: vertices)
        self.time_exit = [Int](repeating: 0, count: vertices)
    }
    
    public func addEdge(x: Int, y: Int, isDirected:Bool)
    {
        //Create new node
        let newNode = GraphNode(y)
        newNode.next = self.edges[x]
        self.edges[x] = newNode
        
        //Increment degree in vertex
        self.degree[x] += 1
        
        if isDirected == false
        {
            addEdge(x: y, y: x, isDirected: true)
        }
        else
        {
            //Increment the graph number of edges
            self.nEdges += 1
        }
    }
    
    public func printGraph()
    {
        for (index,vertex) in self.edges.enumerated()
        {
            var node = vertex
            var strLevel = "Level\(index): "
            while(node != nil)
            {
                strLevel = strLevel + "->(\(node!.y))"
                node = node?.next
            }
            print(strLevel)
        }
    }
    
    //MARK: BFS TRAVERSAL
    public func BFS(start: Int)
    {
        //The tools
        var vidx = 0 //vertext index
        var node: GraphNode? = nil
        var fifo = [Int]()
        var y = 0
        
        //Start filling fifo
        fifo.append(start)
        self.discovered[start] = true
        
        //Continue while fifo is not empty
        while (fifo.isEmpty == false)
        {
            vidx = fifo.first!
            fifo.remove(at: 0)
            self.process_vertex_early(vidx)
            self.processed[vidx] = true
            //Start Traersal
            node = edges[vidx]
            while(node != nil)
            {
                y = node!.y
                if self.processed[y] == false || self.isDirected == true
                {
                    self.process_edges(vidx, y)
                }
                if self.discovered[y] == false
                {
                    self.discovered[y] = true
                    self.parent[y] = vidx
                    fifo.append(y)
                    self.process_edges(vidx, y)
                }
                node = node?.next
            }
            self.process_vertex_late(vidx)
        }
    }
    
    func findPath(start:Int, end:Int)
    {
        if start == end || end == -1
        {
            print(start)
        }
        else
        {
            findPath(start: start, end: self.parent[end])
            print(end)
        }
    }
    func process_vertex_early(_ vertex: Int)
    {
        
    }
    func process_vertex_late(_ vertex: Int)
    {
        
    }
    func process_edges(_ x: Int, _ y: Int)
    {
        
    }
}

class GraphNode
{
    var y: Int
    var next: GraphNode?
    
    init(_ y:Int )
    {
        self.y = y
    }
}
