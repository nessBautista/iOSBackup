//
//  ViewModel03.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/3/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct User {
    let followersCount: Int
    let followingCount: Int
    let screenName: String
    var profileImage: UIImage?
    var imgUrl = PublishSubject<String>()
    
    init(followersCount:Int, followingCount:Int, screenName: String)
    {
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.screenName = screenName
        self.profileImage = nil
    }
    
}

class ViewModel03: NSObject {
    
    let disposeBag = DisposeBag()
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>()
    
    func getUsers() -> Observable<[SectionModel<String, User>]>
    {
        return Observable.create { (observer) -> Disposable in
            let users = [User(followersCount: 1005, followingCount: 495, screenName: "BalestraPatrick"),
                         User(followersCount: 380, followingCount: 5, screenName: "RxSwiftLang"),
                         User(followersCount: 36069, followingCount: 0, screenName: "SwiftLang")]
            
            
            print(users.count)
            for (i, user) in users.enumerated()
            {
                user.imgUrl.observeOn(self.scheduler)
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
                    .subscribe(onNext: { [weak self] img in
                        //print("Brought image at \(i)")
                        var items = self?.dataSource.sectionModels[0].items
                        items?[i].profileImage = img
                        
//                        self?.dataSource.value[i].name = "Done"
//                        self?.dataSource.value[i].imgProfile = $0
                        },
                               onError: {error in print(error)},
                               onCompleted: {print("completed \(i)")},
                               onDisposed: {print("disposed \(i)")})
                    .addDisposableTo(self.disposeBag)

            }
            let section = [SectionModel(model: "", items: users)]
            observer.onNext(section)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
//    func getUsersAsVariable() -> Variable<[SectionModel<String, User>]>
//    {
//        let users = [User(followersCount: 1005, followingCount: 495, screenName: "BalestraPatrick"),
//                     User(followersCount: 380, followingCount: 5, screenName: "RxSwiftLang"),
//                     User(followersCount: 36069, followingCount: 0, screenName: "SwiftLang")]
//        
//        let section = Variable([SectionModel(model: "", items: [users])])
//        
//        return section
//
//    }
}
