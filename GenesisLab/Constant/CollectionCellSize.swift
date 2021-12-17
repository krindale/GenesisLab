//
//  File.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit

enum CollectionCellSize: CGFloat, CaseIterable {
    case threeInRow = 3.0
    case fourInRow = 4.0
    case fiveInRow = 5.0
    
    func next() -> CollectionCellSize {
        return CollectionCellSize(rawValue: self.rawValue + 1.0) ?? .threeInRow
    }
    
    func before() -> CollectionCellSize {
        return CollectionCellSize(rawValue: self.rawValue - 1.0) ?? .fiveInRow
    }
    
    func getSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let defaultInSet = 20.0
        
        let cellWidth = screenWidth / self.rawValue
                            - (defaultInSet * (self.rawValue + 1) / self.rawValue)
        return CGSize(width: cellWidth,height: cellWidth)
    }
}
