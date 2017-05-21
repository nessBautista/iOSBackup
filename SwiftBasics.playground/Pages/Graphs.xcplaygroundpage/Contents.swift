//: Graphs
//: Implementation of a graph using classes


import Foundation

public class Vertex
{
    var data: Int
    var next: Vertex?
    var weight:Int
    init(val: Int, weight:Int = 0)
    {
        self.data = val
        self.weight = weight
    }
    
    convenience init(val: Int)
    {
        self.init(val: val, weight: 0)
    }
}

public class Graph
{
    var conexions:[Vertex?] //Adjacency matrix
    let nVertex: Int        //The number of vertices graph can have
    var nEdges:Int = 0      //Number of edges(conexions in the graph)
    let isDirected: Bool    //Is the grah directed
    
    //Variables for traversal
    var discovered:[Bool]
    var processed:[Bool]
    var parent:[Int]
    init(numberOfVertex: Int = 100, directed:Bool = false)
    {
        self.nVertex = numberOfVertex
        self.isDirected = directed
        self.conexions = [Vertex?](repeating:nil, count: numberOfVertex)
        
        //For Traversal
        self.discovered = [Bool](repeating: false, count: numberOfVertex)
        self.processed = [Bool](repeating: false, count: numberOfVertex)
        self.parent = [Int](repeating: -1, count: numberOfVertex)
    }
    
    public func addConexion(x:Int, y:Int, isDirected:Bool = false)
    {
        //Create a new Node
        let node =  Vertex(val: y)
        
        //Insert into the adjacency matrix
        node.next = self.conexions[x]
        self.conexions[x] = node
        
        //If is directed, apply inverse connection
        if isDirected == false
        {
            self.addConexion(x: y, y: x, isDirected: true)
        }
        else
        {
            self.nEdges += 1 //Increase the conexions counter
        }
    }
    
    public func printGraph()
    {
        for i in 0..<self.conexions.count
        {
            var node = self.conexions[i]
            var conexion = "conexions[\(i)]: "
            
            while node != nil
            {
                conexion += "\(node?.data ?? -1) ->"
                node = node?.next
            }
            print(conexion)
        }
    }
    
    func initForTraversal()
    {
        for i in 0..<self.nVertex
        {
            self.processed[i] = false
            self.discovered[i] = false
        }
    }
    func bfs(start: Int)
    {
        //Re-start arrays
        self.initForTraversal()
        
        //Init fifo recursion
        var fifo = [start]
        self.discovered[start] = true
        while fifo.isEmpty == false
        {
            guard var vidx = fifo.first else {return}
            if fifo.isEmpty != false {fifo.removeFirst()}
            
            /*Process early Vertex*/
            self.processed[vidx] = true
            
            //Explore
            var node = self.conexions[vidx]
            while node != nil
            {
                guard let y = node?.data else {return}
                if self.processed[y] == false || self.isDirected == true
                {
                    /*process edge*/
                }
                if self.discovered[y] == false
                {
                    self.discovered[y] = true
                    self.parent[y] = vidx
                    fifo.append(y)
                }
                node = node?.next
            }
            /*process vertex late*/
        }
    }
}

//: Create a graph that will have 10 nodes from enumerated from 0 to 9
let graph =  Graph(numberOfVertex: 10)
graph.addConexion(x: 1, y: 4)
graph.addConexion(x: 1, y: 0)
graph.addConexion(x: 1, y: 3)
graph.addConexion(x: 4, y: 3)
graph.addConexion(x: 0, y: 3)

graph.printGraph()
graph.bfs(start: 0)
