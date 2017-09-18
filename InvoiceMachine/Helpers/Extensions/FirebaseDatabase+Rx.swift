//
//  FirebaseDatabase+Rx.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/18/17.
//  Copyright © 2017 njen. All rights reserved.
//
import Firebase
import RxSwift

public extension DatabaseQuery {
    /**
     Listen for data changes at a particular location.
     This is the primary way to read data from the Firebase Database. The observers
     will be triggered for the initial data and again whenever the data changes.
     
     @param eventType The type of event to listen for.
     */
    func rx_observe(eventType: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create {[weak self] observer in
            let handle = self?.observe(eventType, with: { (snapshot) in
                observer.onNext(snapshot)
            })
            return Disposables.create {
                if let withHandle = handle {
                self?.removeObserver(withHandle: withHandle)
                }
            }
        }
    }

    
    /**
     This is equivalent to rx_observe(), except the observer is immediately canceled after the initial data is returned.
     
     @param eventType The type of event to listen for.
     */
    func rx_observeSingleEvent(eventType: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create { observer in
            self.observeSingleEvent(of: eventType, with: { (snapshot) in
                observer.onNext(snapshot)
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
}



public extension ObservableType where E : DataSnapshot {
    
    func rx_filterWhenNSNull() -> Observable<E> {
        return self.filter { (snapshot) -> Bool in
            return snapshot.value is NSNull
        }
    }
    
    func rx_filterWhenNotNSNull() -> Observable<E> {
        return self.filter { (snapshot) -> Bool in
            return !(snapshot.value is NSNull)
        }
    }
    
    func rx_children() -> Observable<DataSnapshot> {
        return self.flatMap({ (snapshot) -> Observable<DataSnapshot> in
            return Observable.create { observer in
                
                for snapChild in snapshot.children {
                    if let snapChild = snapChild as? DataSnapshot {
                        observer.onNext(snapChild)
                    }
                }
                observer.onCompleted()
                return Disposables.create()
            }
        })
    }
    
    func rx_childrenAsArray() -> Observable<[DataSnapshot]> {
        return self.flatMap({ (snapshot) -> Observable<[DataSnapshot]> in
            return Observable.create { observer in
                if let array = snapshot.children.allObjects as? [DataSnapshot] {
                    observer.onNext(array)
                }
                observer.onCompleted()
                
                return Disposables.create()
            }
        })
    }
    
}
