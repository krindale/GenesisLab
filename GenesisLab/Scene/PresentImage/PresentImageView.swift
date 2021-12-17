//
//  PresentImageView.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit
import SnapKit

final class PresentImageView: UIView {
    
    var mvvm: PresentImageViewMVVM?

    // 갤러리 사진이 선택 되었을 경우 나타낼 이미지
    var imageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
