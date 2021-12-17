//
//  PhotoCollectionView.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit

final class PhotoCollectionView: UICollectionView {
    
    var mvvm: PhotoCollectionMVVM?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
        self.register(ThumbnailCell.self, forCellWithReuseIdentifier: ThumbnailCell.identifier)
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
