//
//  ThumbnailCellCollectionViewCell.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit

final class ThumbnailCell: UICollectionViewCell {
    
    static let identifier: String = "ThumbnailCell"

    // Thumbail Photo ImageView
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Init Cell UI
    private func setUI() {
        // Add Subviews
        self.contentView.addSubview(self.imageView)

        // ImageView Constrains
        self.imageView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(self.imageView.snp.height)
        }
    }
    
    // Bind Model
    func bind(image: UIImage) {
        self.imageView.image = image
    }
}
