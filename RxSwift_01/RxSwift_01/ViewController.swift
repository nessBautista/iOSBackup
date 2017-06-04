//
//  ViewController.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 5/24/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        //self.basics()
        //self.mapExamples()
        //self.filterExamples()
        //self.combineExamples()
        self.sideEffectsExample()
    }
    
    func sideEffectsExample()
    {
        exampleOf("doOnNext") {
            let disposeBag = DisposeBag()
            let farenheitTemps = [-40, 0, 32, 70, 212]
            let source = Observable.from(farenheitTemps)
            source.do(onNext: { $0 * $0},
                      onError: {error in},
                      onCompleted: nil,
                      onSubscribe: nil, onSubscribed: nil, onDispose: nil)
                .do(onNext: {  print("\($0)ºF = ", terminator: "")},
                    onError: {error in},
                    onCompleted: nil,
                    onSubscribe: nil, onSubscribed: nil, onDispose: nil)
                .map {
                    Double($0 - 32) * 5 / 9.0
                }
                .subscribe(onNext: {print(String(format: "%.1fºC", $0))},
                           onError: {error in },
                           onCompleted: nil,
                           onDisposed: nil)
                .addDisposableTo(disposeBag)
        }
    }
    func combineExamples()
    {
        exampleOf("StartWith") {
            
            let disposeBag =  DisposeBag()
            
            Observable.of("1","2","3")
                .startWith("A")
                .startWith("B")
                .startWith("C", "D")
                .subscribe(onNext: {print($0)},
                           onError: {error in },
                           onCompleted: nil,
                           onDisposed: nil)
                .addDisposableTo(disposeBag)
        }
        
        
        exampleOf("Merge") {
            let disposeBag =  DisposeBag()
            
            let subject1 = PublishSubject<String>()
            let subject2 = PublishSubject<String>()
            
            Observable.of(subject1, subject2)
                .merge()
                .subscribe(onNext: {print($0)},
                           onError: {error in },
                           onCompleted: nil,
                           onDisposed: nil)
            .addDisposableTo(disposeBag)
            
            subject1.onNext("A")
            subject1.onNext("B")
            
            subject2.onNext("1")
            subject2.onNext("2")
            
            subject1.onNext("C")
            subject2.onNext("3")
            
        }
        
        exampleOf("Zip") {
            let disposeBag = DisposeBag()
            let stringSubject =  PublishSubject<String>()
            let intSubject =  PublishSubject<Int>()
            Observable.zip(stringSubject, intSubject){ stringElement, intElement in
                "\(stringElement) \(intElement)"
                
            }
                .subscribe(onNext: {print($0)},
                           onError: {error in },
                           onCompleted: nil,
                           onDisposed: nil)
            .addDisposableTo(disposeBag)
            
            stringSubject.onNext("A")
            stringSubject.onNext("B")
            
            intSubject.onNext(1)
            intSubject.onNext(2)
            
            intSubject.onNext(3)
            stringSubject.onNext("C")
        }
    }
    
    func filterExamples()
    {
        exampleOf("filter") {
            let disposeBag =  DisposeBag()
            //Generate numbers from 1 to 100
            let numbers =  Observable.generate(initialState: 1, condition: {$0 < 101}, iterate: {$0 + 1})
            numbers.filter { number in
                guard number > 1 else {return false}
                var isPrime = true
                
                (2..<number).forEach({
                    if number % $0 == 0
                    {
                        isPrime = false
                    }
                })
                return isPrime
            }
            .toArray()
                .subscribe(onNext: {print($0)},
                           onError: {error in },
                           onCompleted: nil,
                           onDisposed: nil)
            
        }
        
        exampleOf("DistinctUntilChanged") {
            let disposeBag = DisposeBag()
            let searchString = Variable("")
            searchString.asObservable()
                .map({$0.lowercased()})
                .distinctUntilChanged()
                .subscribe(onNext: {print($0)},
                           onError: {error in},
                           onCompleted: nil,
                           onDisposed: nil)
                .addDisposableTo(disposeBag)
            
            searchString.value = "APPLE"
            searchString.value = "APPLE"
            searchString.value = "banana"
            searchString.value = "APPLE"
        }
        
        exampleOf("takeWhile") {
            let disposeBag = DisposeBag()
            let numbers = [1,2,3,4,3,2,1]
            let source = Observable.from(numbers)
            
            source.takeWhile{ $0 < 4}
                .subscribe(onNext: {print($0)},
                           onError: {error in },
                           onCompleted: nil,
                           onDisposed: nil)
                .addDisposableTo(disposeBag)
        }
    }
    
    func mapExamples()
    {
        exampleOf("map"){
            Observable.of(1,2,3)
                .map{$0 * $0}
                .subscribe(onNext: {print($0)},
                           onError: {error in },
                           onCompleted: nil,
                           onDisposed: nil)
                .dispose()
        }
        
        exampleOf("FlatMap") {
            // Dispose bag
            let disposeBag = DisposeBag()
            
            //Example Struct
            struct Player {
                let score: Variable<Int>
            }
            let scott = Player(score: Variable(80))
            let lori = Player(score: Variable(90))
            
            //This is the variable which we will be subscribe to, it's kind of a placeholder
            var player = Variable(scott)
            player.asObservable()
                .flatMap{$0.score.asObservable()}
                .subscribe(onNext: {print($0)},
                           onError: {error in},
                           onCompleted: nil,
                           onDisposed: nil)
                .addDisposableTo(disposeBag)
            
            //Change the subscribed variable value
            player.value.score.value = 85
            //Change the current player value directly
            scott.score.value = 88
            //Assign a new value to the placeholder, this also be emitted
            player.value = lori
            
            //Check how flatmap is still listening the changes at the past value
            scott.score.value = 95
        }
        
        exampleOf("FlatMapLatest") {
            
            // Dispose bag
            let disposeBag = DisposeBag()
            
            //Example Struct
            struct Player {
                let score: Variable<Int>
            }
            let scott = Player(score: Variable(80))
            let lori = Player(score: Variable(90))
            
            //This is the variable which we will be subscribe to, it's kind of a placeholder
            var player = Variable(scott)
            player.asObservable()
                .flatMapLatest{$0.score.asObservable()}
                .subscribe(onNext: {print($0)},
                           onError: {error in},
                           onCompleted: nil,
                           onDisposed: nil)
                .addDisposableTo(disposeBag)
            
            //Change the subscribed variable value
            player.value.score.value = 85
            //Change the current player value directly
            scott.score.value = 88
            //Assign a new value to the placeholder, this also be emitted
            player.value = lori
            
            //Check how flatmaplatest won't listen the changes at the past value, only at the current value inside our placeholder
            scott.score.value = 95
            lori.score.value = 100
            player.value.score.value = 105
        }
    }
    func basics()
    {
        //MARK: Observable sequences
        exampleOf("just"){
            let observable = Observable.just("Que Pasa AKI")
            observable.subscribe({ (event : Event<String>) in
                print(event)
            })
        }
        
        exampleOf("of") {
            let observable = Observable.of(1,2,3)
            observable.subscribe({ print($0) })
        }
        
        //Converting an array of elements to an observable sequence
        exampleOf("toObservable"){
            
            let numbers = [1,2,3,4,5]
            let source = Observable.from(numbers)
            
            let disposeBag = DisposeBag()
            let subscription: Disposable = source.subscribe(onNext: { (event) in
                print(event)
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
            })
            
            subscription.addDisposableTo(disposeBag)
        }
        
        //MARK: Working with subjects
        /*
         Publish: publish subjects emits only new items to its subscriber , in other words, elements added to a publish subject before a subscription is creted will not be emitted.
         */
        
        exampleOf("PublishSubject") {
            
            let subject = PublishSubject<String>()
            subject.subscribe({
                print($0)
            })
            
            enum MyError: Error
            {
                case Test
            }
            subject.onNext("Hello")
            //subject.onCompleted()
            //subject.onError(MyError.Test)
            subject.onNext("World")
            
            let newSubscription = subject.subscribe(onNext: {print("New subscription:",$0)
                
                
            },
                                                    onError: { (Error) in
                                                        
            },
                                                    onCompleted: {
                                                        
            },
                                                    onDisposed: {
                                                        
            })
            subject.onNext("what's up")
            //newSubscription.dispose()
            subject.onNext("Still There?")
        }
        
        exampleOf("BehaviorObject") {
            let subject = BehaviorSubject(value: "a")
            
            let firstSubscription = subject.subscribe(onNext: {print(#line, $0)},
                                                      onError: {error in},
                                                      onCompleted: {},
                                                      onDisposed: {})
            subject.onNext("b")
            
            let secondSubscription = subject.subscribe(onNext: {print(#line, $0)},
                                                       onError: {error in},
                                                       onCompleted: {},
                                                       onDisposed: {})
            
        }
        
        exampleOf("ReplaySubject"){
            
            let subject = ReplaySubject<Int>.create(bufferSize: 3)
            subject.onNext(1)
            subject.onNext(2)
            subject.onNext(3)
            subject.onNext(4)
            
            subject.subscribe(onNext: {print($0)},
                              onError: {error in },
                              onCompleted: {},
                              onDisposed: {})
            
        }
        
        exampleOf("Variable"){
            let disposeBag = DisposeBag()
            let variable =  Variable("A")
            variable.asObservable().subscribe(onNext: {print($0)},
                                              onError: {Error in },
                                              onCompleted: {},
                                              onDisposed: {}).addDisposableTo(disposeBag)
            variable.value = "B"
        }
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func exampleOf(_ description: String, action: (Void) -> Void)
    {
        print("\n--- Example of: ", description, "---")
        action()
    }


}

