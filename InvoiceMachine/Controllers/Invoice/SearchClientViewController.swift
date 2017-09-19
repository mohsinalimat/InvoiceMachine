//
//  SearchClientViewController.swift
//  InvoiceMachine
//
//  Created by Huy Ta on 9/14/17.
//  Copyright © 2017 njen. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif
import Firebase

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}

class SearchClientViewController: ViewController {
    
    lazy var ref: DatabaseReference = Database.database().reference()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet var emptyView: UIView!
    let client1 = Client(id: "3232", name: "Test", email: "Huy@gmail.com", phone: "04dd", street: "32323", street2: "fdsfsd", postCode: "fdsf", city: "fds", state: "fdsf")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate struct Storyboard{
        static let InvoiceViewControllerSegueIdentifier = "InvoiceViewControllerSegue"
    }

    
    // lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .all
        configureTableDataSource()
        configureKeyboardDismissesOnScroll()
        configureNavigateOnRowClick()
    }
    
    func configureTableDataSource() {
        resultsTableView.register(UINib(nibName: "ClientSearchCell", bundle: nil), forCellReuseIdentifier: "ClientSearchCell")
        resultsTableView.hideEmptyCells()
        
        let results = searchBar.rx.text.orEmpty
            .asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query in
                return (self?.getSearchResults(query).startWith([]) // clears results on new search term
                    .asDriver(onErrorJustReturn: []))!
            }.map { result  in
                return result
        }
        results
            .drive(resultsTableView.rx.items(cellIdentifier: "ClientSearchCell", cellType: ClientSearchCell.self)) { (_, viewModel, cell) in
                cell.viewModel = viewModel
            }
            .disposed(by: disposeBag)
        
        results
            .map { $0.count != 0 }
            .drive(self.emptyView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    
    func getSearchResults(_ query: String) -> Observable<[Client]> {
        
        return (ref.child(FirebaseTableName.userClientTableName).child(getUid())).queryStarting(atValue: query)
            .queryOrdered(byChild: ClientTablePropertyName.name)
            .rx_observeSingleEvent(eventType: .value).flatMap({ (snapshot) -> Observable<[Client]> in
                return Observable.create { observer in
                    var clients = [Client]()
                    for snapChild in snapshot.children {
                        if let snapChild = snapChild as? DataSnapshot {
                            if let child = Client.init(snapshot: snapChild){
                                clients.append(child)
                            }
                        }
                    }
                    observer.onNext(clients)
                    observer.onCompleted()
                    return Disposables.create()
                }
            })
    }
    
    func configureKeyboardDismissesOnScroll() {
        let searchBar = self.searchBar
        
        resultsTableView.rx.contentOffset
            .asDriver()
            .drive(onNext: { _ in
                if searchBar?.isFirstResponder ?? false {
                    _ = searchBar?.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func configureNavigateOnRowClick() {
        
        resultsTableView.rx.modelSelected(Client.self)
            .asDriver()
            .drive(onNext: {[weak self] searchResult in
                self?.performSegue(withIdentifier: Storyboard.InvoiceViewControllerSegueIdentifier, sender: self)
            })
            .disposed(by: disposeBag)
    }
    
    
}
