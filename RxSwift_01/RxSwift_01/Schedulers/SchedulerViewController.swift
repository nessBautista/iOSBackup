//
//  SchedulerViewController.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/2/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import RxSwift
class SchedulerViewController: UIViewController
{

    let disposeBag = DisposeBag()
    let imageURLSubject = PublishSubject<String>()
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imageURLSubject
            .observeOn(scheduler)
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
            .subscribe(onNext: {
                self.imgView.image = $0                
            },
                       onError: {error in },
                       onCompleted: nil,
                       onDisposed: nil)
        .addDisposableTo(disposeBag)
        
        imageURLSubject.onNext("http://www.m4photo.co.uk/images/main-images/portfolio-landscapes.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
