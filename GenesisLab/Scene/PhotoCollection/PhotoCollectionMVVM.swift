//
//  PhotoCollectionMVVM.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit
import RxSwift
import RxCocoa


final class PhotoCollectionMVVM: NSObject {
    
    var disposeBag = DisposeBag()
    var rxImages = BehaviorRelay<[UIImage]>(value: [])
    var rxNumberInRow = BehaviorRelay<CollectionCellSize>(value: CollectionCellSize.threeInRow)
    weak var photoCollectionView: PhotoCollectionView?
    
    init(view: PhotoCollectionView) {
        // Do any additional setup after loading the view.

        self.photoCollectionView = view
        super.init()
        self.setRx()
        
        self.photoCollectionView?.delegate = self
        self.photoCollectionView?.dataSource = self
        
        
    }
    
    private func setRx() {
        self.rxImages
            .subscribe(onNext: { [weak self] _ in
                self?.photoCollectionView?.reloadData()
            }).disposed(by: self.disposeBag)
        
        self.rxNumberInRow
            .subscribe(onNext: { [weak self] _ in
                self?.photoCollectionView?.reloadData()
            }).disposed(by: self.disposeBag)
    }
    
}

extension PhotoCollectionMVVM: UICollectionViewDataSource {

    // UICollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.rxImages.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier,
                                                            for: indexPath) as? ThumbnailCell else {
            return collectionView
                .dequeueReusableCell(withReuseIdentifier: "Cell",
                                     for: indexPath)
        }
        
        cell.bind(image: rxImages.value[indexPath.row])
        
        return cell
    }
    
}

extension PhotoCollectionMVVM: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.rxNumberInRow.value.getSize()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0, left: 20.0,
                            bottom: 20.0, right: 20.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
