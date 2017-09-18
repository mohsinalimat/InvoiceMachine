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

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}

class SearchClientViewController: ViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet var emptyView: UIView!
    let client = Client(id: "3232", name: "Test", email: "Huy@gmail.com", phone: "04dd", street: "32323", street2: "fdsfsd", postCode: "fdsf", city: "fds", state: "fdsf")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
                return (self?.getSearchResults(query).startWith(self?.getAllClient() ?? []) // clears results on new search term
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
    
    func getAllClient() -> [Client]{
        return [self.client]
    }
    
    func getSearchResults(_ query: String) -> Observable<[Client]> {
        
        let array: Variable<[Client]> = Variable([self.client])
        return array.asObservable()
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
            .drive(onNext: { searchResult in
                print(searchResult)
            })
            .disposed(by: disposeBag)
    }
    
}
