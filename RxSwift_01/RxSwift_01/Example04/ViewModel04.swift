//
//  ViewModel04.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/3/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

//Sample Class
class Buddy
{
    //Log info .....
    var name: String
    
    var profileImgUrl = PublishSubject<String>()
    
    //Attachments .....
    var image:UIImage?
    
    init(name: String)
    {
        self.name = name
        
        self.image = nil
    }
}

//Create a struct for section info
struct TableSection
{
    var header: String
    var items: [Item]
}

extension TableSection: SectionModelType
{
    //Table sections will contain items of type buddy
    typealias Item = Buddy
    
    init(original: TableSection, items: [Item])
    {
        self = original
        self.items = items
    }
}

class ViewModel04
{
    let disposeBag = DisposeBag()
    
    //Used once to bind the table
    let dataSource = RxTableViewSectionedReloadDataSource<TableSection>()
    
    //A Variable will be able to trigger table refresh  
    var data = Variable([TableSection]())
    
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    
    /*We only will have 1 section*/
    func initData()
    {
        let section =  TableSection(header: "Only Section", items: [Buddy]())
        self.data.value.append(section)
    }
    
    func addNewCell()
    {
        guard data.value.count != 0 else {return}
        data.value[0].items += self.createNewBuddy()
    }
    func createNewBuddy() -> [Buddy]
    {
        //Create instance
        let idx = self.data.value[0].items.count
        let buddy = Buddy(name: "NewBuddy")
        //React to url update
        buddy.profileImgUrl.observeOn(self.scheduler)
            .map({str -> UIImage in
                
                if let url = URL(string: (str)) {
                    if let data = try? Data(contentsOf: url) {
                        
                        if let img = UIImage(data: data) {
                            
                            return img
                        }
                    }
                }
                return UIImage()
            })
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                
                let buddy = self?.data.value[0].items[idx]
                buddy?.image = $0
                self?.data.value[0].items[idx] = buddy!
                },
                       onError: {error in},
                       onCompleted: nil,
                       onDisposed: nil)
            .addDisposableTo(self.disposeBag)
        
        return [buddy]
    }
}
