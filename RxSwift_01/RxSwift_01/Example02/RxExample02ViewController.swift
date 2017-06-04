//
//  RxExample02ViewController.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/1/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class RxExample02ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    let disposeBag = DisposeBag()
    let dataSource = Variable<[Person]>([])
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    override func viewDidLoad()
    {
        super.viewDidLoad()

        var people = [Person]()
        for i in 0..<20
        {
            let person =  Person(name:"As shown in this illustration, the SubscribeOn operator designates which thread the Observable will begin operating on, no matter at what point in the chain of operators that operator is called. ObserveOn, on the other hand, affects the thread that the Observable", age: i)
            
            
            person.profileImgUrl.observeOn(self.scheduler)
                .map({ (str) -> UIImage in
                    
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
                    print("Brought image at \(i)")
                    self?.dataSource.value[i].name = "Done"
                    self?.dataSource.value[i].imgProfile = $0
                    },
                           onError: {error in print(error)},
                           onCompleted: {print("completed \(i)")},
                           onDisposed: {print("disposed \(i)")})
                .addDisposableTo(self.disposeBag)
            
            people.append(person)
        }
        
        // Do any additional setup after loading the view.
        self.table.register(UINib(nibName: "ImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageCellTableViewCell")
        self.table.estimatedRowHeight = 60
        //self.table.delegate = self
        
        
        dataSource.asObservable().bind(to: table.rx.items(cellIdentifier: "ImageCellTableViewCell")) {
            row, person, cell in
            
            if let cellToUse = cell as? ImageCellTableViewCell {
                                
                cellToUse.loadCell(person)
            }
            }.addDisposableTo(disposeBag)
        
        dataSource.value = people
        
        
        self.table.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            
            print("Index selected Rx: \(indexPath.row)")

            
            let person = self?.dataSource.value[indexPath.row]
            self?.dataSource.value[indexPath.row].imgProfile = UIImage(named:"defaultperson")
            
            person?.profileImgUrl.onNext("http://www.m4photo.co.uk/images/main-images/portfolio-landscapes.png")
            },
                                             onError: {error in },
                                             onCompleted: nil,
                                             onDisposed: nil)
            .addDisposableTo(self.disposeBag)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension RxExample02ViewController: UITableViewDelegate
{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        let index = indexPath.row
//        
//        print("Index selected Delegate: \(index)")
//    }
}
