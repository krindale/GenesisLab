//
//  MainMVVM.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit
import RxSwift
import RxCocoa

final class MainMVVM {
    
    weak var mainViewController: MainViewController?
    
    var rxImages = BehaviorRelay<[UIImage]>(value: [])
    // 이미지들을 불러오기 위한 프로토콜
    private var fetchImage: FetchImageProtocol
    
    init(mainViewController: MainViewController, fetchImage: FetchImageProtocol) {
        self.mainViewController = mainViewController
        self.fetchImage = fetchImage
    }
    
    // Fetch Image From Gallary
    func fetchImages() {
        self.fetchImage
            .fetchImages { [weak self] images in
            guard let `self` = self else { return }
            self.rxImages.accept(images)
        }
    }
}
