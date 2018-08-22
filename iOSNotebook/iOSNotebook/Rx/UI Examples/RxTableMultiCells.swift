//
//  RxTableMultiCells.swift
//  iOSNotebook
//
//  Created by Néstor Hernández Bautista on 7/24/18.
//  Copyright © 2018 Néstor Hernández Bautista. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RxTableMultiCells: UITableViewController {

    
    let viewModel = MultiCellViewModel()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedSectionHeaderHeight = 25;
        self.tableView.estimatedRowHeight = 25
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        self.tableView.register(UINib(nibName: "PivotCell", bundle: nil), forCellReuseIdentifier: "PivotCell")
        self.tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderCell")
        self.tableView.register(UINib(nibName: "TimelineHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "TimelineHeaderTableViewCell")
        let dataSource = RxTableViewSectionedReloadDataSource<TableSection>(configureCell: { [weak self]
            (dataSource, table, indexPath, item) in
            
            let cell = UITableViewCell()
            if indexPath.section == 0
            {
                guard let data = item as? String else {
                    return UITableViewCell()
                }
                guard data.isEmpty == false else {
                    let pivotCell = table.dequeueReusableCell(withIdentifier: "PivotCell") as! PivotCell
                    pivotCell.addGestureRecognizer(ActionsTapGestureRecognizer(onTap: { [weak self] in
                        
                        self?.collapse(indexPath.section)
                        //self?.viewModel.data.value[indexPath.section].isCollapsed = false
                    }))
                    return pivotCell
                }
                let descriptionCell = table.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
                descriptionCell.lblDescription.text = data
                return descriptionCell
                
            }
            if indexPath.section == 1
            {
                cell.backgroundColor = .blue
            }
            if indexPath.section == 2
            {
                cell.backgroundColor = .green
            }
            if indexPath.section == 3
            {
                cell.backgroundColor = .purple
            }
            return cell
        })
        //The title for section
//        dataSource.titleForHeaderInSection = { dataSource, index in
//
//            return "Test"
//        }
        
        //Bind data to datasource
        self.viewModel.data.asDriver().drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: self.viewModel.disposeBag)
        //Set Delegates
        self.tableView.rx.setDelegate(self).disposed(by: self.viewModel.disposeBag)
        
        //Add First Data
        self.viewModel.initData()
    }


    fileprivate func collapse(_ section: Int)
    {
        var sections = self.viewModel.data.value
        sections[section].isCollapsed = !sections[section].isCollapsed
        var sectionData = (sections[section].sectionData as? GlobalDashboardGeneralInfoSection)
        sectionData?.location = sections[section].isCollapsed == true ? "Complicated things go here: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit":"naaa"
        sections[section].sectionData = sectionData
        self.viewModel.data.accept(sections)

    }

}

class ActionsTapGestureRecognizer: UITapGestureRecognizer
{
    var tapAction: ActionTap
    
    init(onTap:@escaping () -> ())
    {
        self.tapAction = ActionTap()
        self.tapAction.onTap = onTap
        super.init(target: self.tapAction, action: #selector(ActionTap.launchActionOnTap))
    }
}

class ActionTap : NSObject
{
    var onTap: (() -> ())?
    var onLongPress: ((_ state: UIGestureRecognizerState)->())?
    
    @objc func launchActionOnTap()
    {
        onTap?()
    }
    
    @objc func launchActionForLongTapGesture(_ sender:UILongPressGestureRecognizer)
    {
        if sender.state == .began || sender.state == .ended
        {
            onLongPress?(sender.state)
        }
    }
}


extension RxTableMultiCells
{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if section == 0
        {
            return self.getGeneralInfoSectionView(tableSection: self.viewModel.data.value[section])
        }
        return UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.viewModel.data.value[indexPath.section].isCollapsed == true
        {
            if let pivot = self.viewModel.data.value[indexPath.section].items[indexPath.row] as? String, pivot.isEmpty == false
            {
                return 0.0
            }
            
        }
        return UITableViewAutomaticDimension
    }
    
    fileprivate func getGeneralInfoSectionView(tableSection: TableSection)-> UIView
    {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TimelineHeaderTableViewCell") as! TimelineHeaderTableViewCell
        if let sectionData = tableSection.sectionData as? GlobalDashboardGeneralInfoSection {
            headerView.lblTitle.text = sectionData.title
            headerView.lblDescription.text = sectionData.location
            headerView.contentView.backgroundColor = .purple
        }
        
        return headerView
    }
}



