//
//  RxExample03.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/3/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

//Custom dataStruct
class CustomData
{
    var anInt: Int
    var aString: String
    var aCGPoint: CGPoint
    
    init(anInt: Int, aString: String, aCGPoint: CGPoint)
    {
        self.anInt = anInt
        self.aString = aString
        self.aCGPoint = aCGPoint
    }
}

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    } 
}

class RxExample03: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>()
    let disposeBag = DisposeBag()
    var sections = Variable([SectionOfCustomData]())
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CustomCell01", bundle: nil), forCellReuseIdentifier: "CustomCell01")
        self.tableView.register(UINib(nibName: "CustomCell02", bundle: nil), forCellReuseIdentifier: "CustomCell02")
        self.tableView.estimatedRowHeight = 60
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewCell))
        self.navigationItem.rightBarButtonItem = addButton
        
        dataSource.configureCell = { (dataSource, table, indexPath, item) in
            
            let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text =  "Item \(item.anInt): \(item.aString) - \(item.aCGPoint.x):\(item.aCGPoint.y)"
            return cell
        }
        dataSource.titleForHeaderInSection = { ds, index in
            
            return ds.sectionModels[index].header
        }
        
        self.sections = Variable([
            SectionOfCustomData(header: "First section", items: [CustomData(anInt: 0, aString: "zero", aCGPoint: CGPoint.zero), CustomData(anInt: 1, aString: "one", aCGPoint: CGPoint(x: 1, y: 1)) ]),
            SectionOfCustomData(header: "Second section", items: [CustomData(anInt: 2, aString: "two", aCGPoint: CGPoint(x: 2, y: 2)), CustomData(anInt: 3, aString: "three", aCGPoint: CGPoint(x: 3, y: 3)) ])
        ])
        
//        Observable.just(sections)
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
        sections.asDriver().drive(self.tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
        
    }

    func addNewCell()
    {
        print("add new")
        
        //HERE ADDS A NEW SECTION WITH ITEMS
        //self.sections.value += [SectionOfCustomData(header: "New Section", items: [CustomData(anInt: 123, aString: "new", aCGPoint: CGPoint.zero)])]
        
        //HERE ADDS A ONLY A NEW ITEM IN THE GIVEN SECTION
        self.sections.value[1].items += [CustomData(anInt: 123, aString: "new", aCGPoint: CGPoint.zero)]
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    
    }
}
