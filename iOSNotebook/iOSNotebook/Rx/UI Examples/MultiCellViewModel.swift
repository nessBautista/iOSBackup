//
//  MultiCellViewModel.swift
//  iOSNotebook
//
//  Created by Néstor Hernández Bautista on 7/24/18.
//  Copyright © 2018 Néstor Hernández Bautista. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//FIRST: you will need to create a special data struct to hand on Rx so it can do its magic:
//Also, the incidentDashboard struct is kind of messy, there is a lot of different data types being
//displayed at one Screen (and different service convergin, like the confluence of rivers)
//This makes a perfect candidate for Rx
struct TableSection
{
    var header: String
    var sectionData: Any
    var items: [Any]
    var isCollapsed:Bool
    var sectionType:GlobaldDashboardSectionType
    
    init(header: String, items:[Any], sectionData: Any, sectionType: GlobaldDashboardSectionType = .generalInfo){
        self.header = header
        self.items = items
        self.isCollapsed = true
        self.sectionData = sectionData
        self.sectionType = sectionType
    }
}
extension TableSection: SectionModelType
{
    init(original: TableSection, items: [Any])
    {
        self = original
        self.items = items
        
    }
}

//You'll need for types of items, one for each section:
/*
 1) Header section
 2) The objectives
 3) The Casualties
 4) The progress
 */

enum GlobaldDashboardSectionType:Int {
    case none = 0
    case generalInfo
    case objectives
    case casualties
    case progress
    
}
struct GlobalDashboardGeneralInfoSection {
    var title = String()
    var location = "Complicated things here: Donec condimentum pulvinar felis."
    var casualties = 0
   
    init(title: String = String()) {
        self.title = title
        
    }
}

struct GlobalDashboardObjectiveSection {
    var title = String()
    var location = "@Somewhere"
    var casualties = 0
    
    init(title: String = String()) {
        self.title = title
        
    }
}
struct GlobalDashboardCasualtiesSection {
    var title = String()
    var location = "@Somewhere"
    var casualties = 0
    
    init(title: String = String()) {
        self.title = title
        
    }
}

struct GlobalDashboardProgressSection {
    var title = String()
    var location = "@Somewhere"
    var casualties = 0
    
    init(title: String = String()) {
        self.title = title
        
    }
}

class MultiCellViewModel: NSObject
{
    let disposeBag = DisposeBag()
    
    //A Variable will be able to trigger table refresh
    
    var data = BehaviorRelay<[TableSection]>(value: [TableSection]())
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    /*We only will have 4 section*/
    func initData()
    {
        var sections:[TableSection] = []
        for section in 0..<4
        {
            switch section
            {
            case 0:
                let section =  TableSection(header: "TIMELINE HEADER",  items: ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", String()], sectionData: GlobalDashboardGeneralInfoSection(title: "Incident short description"))
                sections.append(section)
            case 1:
                let section =  TableSection(header: "OBJECTIVES", items: ["Test1", "Test2"], sectionData: GlobalDashboardObjectiveSection())
                sections.append(section)
            case 2:
                let section =  TableSection(header: "CASUALTIES", items: ["Test1", "Test2"], sectionData: GlobalDashboardCasualtiesSection())
                sections.append(section)
            case 3:
                let section =  TableSection(header: "PROGRESS", items: ["Test1", "Test2"], sectionData: GlobalDashboardProgressSection())
                sections.append(section)
            default:
                break
            }
            
            
            
        }
        
        self.data.accept(sections)
    }
}
