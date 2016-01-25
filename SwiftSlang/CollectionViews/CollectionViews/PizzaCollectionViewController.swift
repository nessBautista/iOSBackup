//
//  PizzaCollectionViewController.swift
//  CollectionViews
//
//  Created by Ness on 12/22/15.
//  Copyright © 2015 Ness. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PizzaCollectionViewController: UICollectionViewController {

    var maxSections = 3
    var maxRows = 10
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func colorForIndexPath(indexPath:NSIndexPath) -> UIColor{
        let myRow = CGFloat(indexPath.row)
        let mySection =  CGFloat(indexPath.section)
        let hue = mySection / CGFloat(maxSections)
        let sat  = 1.0 - (myRow * 0.75 / CGFloat(maxRows))
        return UIColor(hue: hue, saturation: sat, brightness: 1.0, alpha: 1.0)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return maxSections
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return maxRows
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        print("section: \(indexPath.section)  index:\(indexPath.row)")
        if indexPath.section == 0 && indexPath.item == 0
        {
            cell.backgroundColor = UIColor.grayColor()
        }
        else if indexPath.section == 0
        {
            cell.backgroundColor = UIColor.orangeColor()
        }
        if indexPath.section == 1
        {
            cell.backgroundColor = UIColor.greenColor()
        }
        if indexPath.section == 2
        {
            cell.backgroundColor = UIColor.blueColor()
        }

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
