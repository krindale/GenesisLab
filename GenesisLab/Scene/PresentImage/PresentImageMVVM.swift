//
//  PresentImageMVVM.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit
import RxSwift
import RxCocoa

final class PresentImageViewMVVM {
    
    var disposeBag = DisposeBag()
    var rxImage = BehaviorRelay<UIImage?>(value: nil)
    weak var presentImageView: PresentImageView?
    
    init(view: PresentImageView) {
        // Do any additional setup after loading the view.
        self.presentImageView = view
        
        if let presentImageView = self.presentImageView {
            self.rxImage
                .bind(to: presentImageView.imageView.rx.image)
                .disposed(by: self.disposeBag)
        }
    }
    
}
