//
//  RxExample04.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/3/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RxExample04: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ViewModel04()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CustomCell01", bundle: nil), forCellReuseIdentifier: "CustomCell01")
        self.tableView.register(UINib(nibName: "CustomCell02", bundle: nil), forCellReuseIdentifier: "CustomCell02")
        self.tableView.estimatedRowHeight = 60
        //self.tableView.sectionHeaderHeight = 0.0
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewCell))
        self.navigationItem.rightBarButtonItem = addButton
        
        //This is the cell for row
        self.viewModel.dataSource.configureCell = { (dataSource, table, indexPath, item) in
            
            if indexPath.row % 2 == 0
            {
                let cell = table.dequeueReusableCell(withIdentifier: "CustomCell01", for: indexPath) as! CustomCell01
                cell.loadCell(item)
                
                return cell
            }
            else
            {
                let cell = table.dequeueReusableCell(withIdentifier: "CustomCell02", for: indexPath) as! CustomCell02
                cell.loadCell(item)
                return cell
            }
            
        }
        
        //The title for section
        self.viewModel.dataSource.titleForHeaderInSection = { dataSource, index in
            
            return dataSource.sectionModels[index].header
        }
                
        //Bind data to datasource
        self.viewModel.data.asDriver().drive(self.tableView.rx.items(dataSource:self.viewModel.dataSource))
        .addDisposableTo(self.viewModel.disposeBag)
        
        //Did select
        self.tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            
            print("Index selected Rx: \(indexPath.row)")
            
            //Simulate Download button action
            let buddy = self?.viewModel.data.value[0].items[indexPath.row]
            buddy?.profileImgUrl.onNext("http://www.m4photo.co.uk/images/main-images/portfolio-landscapes.png")
            
            
            if let cell = self?.tableView.cellForRow(at: indexPath) as? CustomCell01 {
                cell.activityIndicator.startAnimating()
                
            }
            if let cell = self?.tableView.cellForRow(at: indexPath) as? CustomCell02 {
                cell.activityIndicator.startAnimating()
            }
            
            
            },
                                             onError: {error in },
                                             onCompleted: nil,
                                             onDisposed: nil)
            .addDisposableTo(self.viewModel.disposeBag)
        
        //Add First Data
        self.viewModel.initData()
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    func addNewCell()
    {
        self.viewModel.addNewCell()
        //Hide indicator
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            
            self.tableView.scrollToRow(at: IndexPath(row: self.viewModel.data.value[0].items.count - 1, section: 0), at: .bottom, animated: true)
        })
    }
}
