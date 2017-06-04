//
//  RxExample1.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 5/27/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxCocoa

/*
    This is a simple example where Rx takes ownership for loading a UITable.
    There are 2 reactive actions on this table:
 
        1) New data can be added via right bar button
        2) Data is changing every second
 
    Rx needs to reflect these changes.
 
    ViewModel01-> Represents the place where data is Added/Changed from the model
    RcExample1 -> is the classing View Controller. Emphasis on this controller is
                  exclusively managing UI.
    CellRx01 -> Just a custom cell with 2 labels
 */

class RxExample1: UIViewController
{
    @IBOutlet weak var table: UITableView!
    var viewModel = ViewModel01()
    
    //MARK: LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Load Configs
        self.UIConfig()
        self.RxTableConfig()
    }
    
    //MARK: ACTIONS
    func addnewPerson()
    {
        viewModel.addNewPerson()
    }
    
    //MARK: CONFIGS
    func UIConfig()
    {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addnewPerson))
        self.viewModel.onNewItemAdded = { [weak self] in
            
            if let count = (self?.viewModel.dataSource.value.count) {
                
                self?.table.scrollToRow(at: IndexPath(row: count - 1, section: 0) , at: .bottom, animated: true)
            }
        }
    }
    

    
    //MARK: RX TABLE CONFIG
    func RxTableConfig()
    {
        //Cell for row
        self.fillTableWithVariable()
        //DidSelect
        self.reactToSelection()
    }
    
    func fillTableWithVariable()
    {
        viewModel.dataSource.asObservable().bind(to: table.rx.items(cellIdentifier: "Cell")) {
            row, person, cell in
            
            if let cellToUse = cell as? CellRx01 {
                
                //THE LOAD CELL STUFF
                //print("row: \(row)")
                cellToUse.label1.text = person.name
                cellToUse.label2.text = "\(person.age)"
                cellToUse.selectionStyle = .none
                
            }
        }.addDisposableTo(viewModel.disposeBag)
    }
    
    
//    func fillTable()
//    {
//        let objArray: Observable<[Person]> =  Observable.just(self.personArray)
//        objArray.bind(to: self.table.rx.items(cellIdentifier: "Cell")) {
//            
//            _ , person, cell in
//            
//            if let cellToUse = cell as? CellRx01 {
//                
//                print("\(person.name) \(person.age)")
//                cellToUse.label1.text = person.name
//                cellToUse.label2.text = "\(person.age)"
//                cellToUse.selectionStyle = .none
//                
//            }
//        }.addDisposableTo(disposeBag)
//    }
    
    func reactToSelection()
    {
        self.table.rx.modelSelected(Person.self).subscribe(onNext: {
        
            //DID SELECT STUFF
            print($0.name)
        },
                                                           onError: {error in },
                                                           onCompleted: nil,
                                                           onDisposed: nil)
            .addDisposableTo(viewModel.disposeBag)
    }
    
    func changeSelectedItem()
    {
        self.table.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
        
            if let cell = self?.table.cellForRow(at: indexPath) as? CellRx01 {
                
                cell.label1.text = "Change Selected Cell"
            }
        },
                                             onError: {error in },
                                             onCompleted: nil,
                                             onDisposed: nil)
            .addDisposableTo(viewModel.disposeBag)
        
        /*
        self.table.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
            
            if let cellToUse = self?.table.cellForRow(at: indexPath) as? CellRx01 {
                
                cellToUse.label1.text = self?.personArray[indexPath.row].name ?? String()
                cellToUse.label2.text = "\(self?.personArray[indexPath.row].age ?? 0)"
            }
            },
                                               onError: {error in },
                                               onCompleted: nil,
                                               onDisposed: nil)
            .addDisposableTo(disposeBag)
        */
    }
}

extension RxExample1: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedPerson =  self.viewModel.dataSource.value[indexPath.row]
        print(selectedPerson.name)
    }
}
