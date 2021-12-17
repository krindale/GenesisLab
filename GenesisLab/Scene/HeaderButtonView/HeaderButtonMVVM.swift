//
//  HeaderButtonMVVM.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import Foundation
import RxSwift
import RxCocoa

final class HeaderButtonMVVM {

    var disposeBag = DisposeBag()
    var rxNumberInRow = BehaviorRelay<CollectionCellSize>(value: CollectionCellSize.threeInRow)
    
    weak var headerButtonView: HeaderButtonView?
    
    init(view: HeaderButtonView) {
        // Do any additional setup after loading the view.
        self.headerButtonView = view

    self.rxNumberInRow
        .subscribe(onNext: { [weak self] cellSize in
            self?.headerButtonView?.numberOfLineLbl.text = "Number of Line : \(Int(cellSize.rawValue))"
        }).disposed(by: self.disposeBag)
    }
    
}
