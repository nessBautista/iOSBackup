//
//  RX_101.swift
//  iOSNotebook
//
//  Created by Néstor Hernández Bautista on 6/23/18.
//  Copyright © 2018 Néstor Hernández Bautista. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa
/*
 Rx has layer of complexity:
 1) Variables
 2) Subjects
 3) Observables
 
 
 VARIABLES:
 -The easiest way to implement Rx.
 -You can get/set at anytime
 -It is also known as a Hot observable: Which means, that events may already
 happened when you have started subscribing. Your subscription will have the
 last of this events, or the default value.
 -They never error out: This is basically because the onError and onComplete events
 can't ever be triggered on a Variable
 
 SUBJECTS:
 - They can trigger onError and onComplete events: Subscription will be stopped once this events
 have been activated.
 - Can observe and be observed: This means you can combine the output from one observable and
 make it another's input.
 - Hot Observable: You won't get all the events, but depending of the type of subject, you will receive
 a certain number of events.
 -Subject types: Behavior, Publish, Replay
 
 -Behavior type receives the last event of the default value if there are no events
 -Publish subject will only receive new events
 -Replay subjects will have a buffer of events, you can set the size of this buffer and
 this number of elements will be replayed to the subscriber
 
 Replay subject example:
 let replaySubject = ReplaySubject<String>.create(bufferSize: 3)
 
 Traits
 -These are one-off task that can be wrapped in a single observable.
 This Singles will receive only one onError or one onSuccess event.
 They wont receive onDispose or onComplete events
 
 -Completable will receive an onComplete or onError events.
 They wont receive onDispose or onNext events
 
 -Maybe will receive only one onNext or one onCompleted event, not both.
 Possibly an error event, but no dispose event.
 */

class RX_101: NSObject {
    var bag = DisposeBag()
}

//MARK: - Variables
extension RX_101 {
    static var  shared =  RX_101()
    
    //--------------DEPRECATED, please use BehaviorRelay
    func variables() {
        print("------Variables------")
        
        let someInfo = Variable("some value")
        print("someInfo.value: \(someInfo.value)")
        
        let valueContainer = someInfo.value
        print("Value container: \(valueContainer)")
        
        someInfo.value = "Something new"
        print("someInfo.value: \(someInfo.value)")
        
        //Lets create a subscription to this variable
        someInfo.asObservable().subscribe(onNext: { (newValue) in
            print("Value has changed: \(newValue)")
        }, onDisposed: {
            //Optional clean block
        }).disposed(by: self.bag)
        
        //NOTE: variables will never receive on complete and onError events.
    }
    
    func behaviourRelayExample() {
        //Observable
        let someInfo = BehaviorRelay<String>(value: "some value")
        print("1 someInfo.value: \(someInfo.value)")
        
        let plainString = someInfo.value
        print("2 plainString: \(plainString)")
        
        someInfo.accept("something new")
        print("3 someInfo.value: \(someInfo.value)")
        
        //Observer / Subscription
        someInfo.asObservable().subscribe(onNext: {newValue in
            
            print("value has changed: \(newValue)")
        }, onDisposed: {
            
        }).disposed(by: bag)
        
        //NOTE: BehaviorRelay will never recieve onError and onComplete events
        someInfo.accept("Changed again")
    }
}

//MARK: - SUBJECTS
extension RX_101 {
    func subjects() {
        let behaviorSubject = BehaviorSubject(value: 24)
        
        let disposable = behaviorSubject.subscribe(onNext: { (newValue) in
            print("behaviourSubject Subscription: \(newValue)")
        }, onError: { (error) in
            print("error: \(error.localizedDescription)")
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("disposed")
        })
        
        behaviorSubject.onNext(34)
        behaviorSubject.onNext(48)
        behaviorSubject.onNext(48)
        
        //1) Trigger an error
//        let customError = CustomError.forcedError
//        behaviorSubject.onError(customError)
//        behaviorSubject.onNext(109) // Will never show
        
        //2) Trigger an error
//        behaviorSubject.onCompleted()
//        behaviorSubject.onNext(10) // Will never show
        
        //3) Dispose event
//        disposable.dispose() //Manually dispose
        
        //4) can bind observables to subjects
        let numbers = Observable.from([1,2,3,4,5,6,7])
        numbers.subscribe(onNext: { (number) in
            print("Observable subscription: \(number)")
            
        }).disposed(by: self.bag)
        numbers.bind(to: behaviorSubject).disposed(by: self.bag)
    }
}

//MARK: Basic observables
extension RX_101 {
    func basicObservables(){
        //The observable
        let observable = Observable<String>.create({ observer in
            //The closure is called by every subscriber -by default
            print("~~Observable logic beig triggered")
            //Do work on a background thread
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 1) //artificial delay
                observer.onNext("some value 123")
                observer.onCompleted()
            }
            return Disposables.create {
                print("Cleanup")
                //do something
                //network clean
                //fileio release
            }
        })
        
        //Now lets subscribe to this observable
        
        //Subscription 1
        let observer1 = observable.subscribe(onNext: { (someString) in
            print("new value: \(someString)")
        })
        observer1.disposed(by: self.bag)
        
        //Subscription 2
        let observer2 = observable.subscribe(onNext: { (someString) in
            print("Another Subscriber:\(someString)")
        })
        observer2.disposed(by: self.bag)
        
    }
    
    func creatingObservables() {
        //let observable = Observable.just(23)
        //let observable = Observable.from([1,2,3,4,5]) //Imagine a list of IDs you want to perform some work on
        let observable = Observable<Int>.interval(0.3, scheduler: MainScheduler.instance)
        observable.subscribe(onNext: { (number) in
            print(number)
        }, onCompleted: {
            print("No more elements ever")
        }).disposed(by: self.bag)
    }
    
    func  repeatableObservable() {
        var counter = 0
        let repeatable = Observable<String>.repeatElement("Over and over again")
        repeatable.subscribe {
            counter = counter + 1  //Side effect, counter is outside the block, and this can cause problems
            print("\($0) - \(counter)")
        }
    }
}
