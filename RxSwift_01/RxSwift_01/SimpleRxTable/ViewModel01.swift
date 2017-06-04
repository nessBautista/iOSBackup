//
//  ViewModel01.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 5/27/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxSwift

//MARK: MODEL simulation
struct Person
{
    static var count: Int = 1
    var name: String
    var age: Int
    var timer: Timer?
    var imgProfile: UIImage?
    var profileImgUrl = PublishSubject<String>()
    init(name: String, age: Int)
    {
        Person.count += 1
        self.name = name
        self.age = age
        self.timer = nil
        self.imgProfile = nil
        
    }
}

//MARK: VIEW MODEL
class ViewModel01: NSObject
{
    let disposeBag = DisposeBag()
    let dataSource = Variable<[Person]>([])
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    var onNewItemAdded:(()->())?
    override init()
    {
        //Connect with Model
        self.dataSource.value = [Person]()
    }
    
    
    func addNewPerson()
    {
        /*Add new data to the model*/
        var newPerson = Person(name: "Name\(Person.count)", age: 0)
        
        /*Data has changed in the model*/
        newPerson.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: { timer in
            
            for (idx, person) in self.dataSource.value.enumerated() where person.name == newPerson.name
            {
                //Triger
                self.dataSource.value[idx].age += 1
            }
        })
        
        //Triger
        self.dataSource.value.append(newPerson)
        self.onNewItemAdded?()
    }
}
