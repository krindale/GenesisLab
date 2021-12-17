//
//  HeaderButtonView.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit
import RxSwift
import RxCocoa

final class HeaderButtonView: UIView {
    
    var mvvm: HeaderButtonMVVM?
    var disposeBag = DisposeBag()
    
    var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // Number of Line 을 나타내는 라벨
    var numberOfLineLbl: UILabel = {
        var numberOfLineLbl = UILabel()
        numberOfLineLbl.textColor = .black
        return numberOfLineLbl
    }()
    
    // + Button
    var plusButton: UIButton = {
        var plusButton = UIButton()
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.setTitle("+", for: .normal)
        return plusButton
    }()
    
    // - Button
    var minusButton: UIButton = {
        var minusButton = UIButton()
        minusButton.setTitleColor(.black, for: .normal)
        minusButton.setTitle("-", for: .normal)
        return minusButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set UI
        self.setUI()
        // Set Rx
        self.setRx()
    }
    
    // 화면 구성
    private func setUI() {
        self.addSubview(self.stackView)
        
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(self.numberOfLineLbl)
        self.stackView.addArrangedSubview(self.plusButton)
        self.stackView.addArrangedSubview(self.minusButton)
    }
    
    // Set Rx
    private func setRx() {
        // + Button Click - 갤러리의 Number of Line 가 하나 늘어난다.
        self.plusButton.rx.tap
            .map({ [weak self] _ -> CollectionCellSize in
                guard let mvvm = self?.mvvm else { return .threeInRow}
                return mvvm.rxNumberInRow.value.next()
            }).subscribe(onNext: { [weak self] nextNumberInRow in
                self?.mvvm?.rxNumberInRow.accept(nextNumberInRow)
            }).disposed(by: self.disposeBag)
        
        // - Button Click - 갤러리의 Number of Line 가 하나 줄어든다.
        self.minusButton.rx.tap
            .map({ [weak self] _ -> CollectionCellSize in
                guard let mvvm = self?.mvvm else { return .threeInRow}
                return mvvm.rxNumberInRow.value.before()
            }).subscribe(onNext: { [weak self] beforeNumberInRow in
                self?.mvvm?.rxNumberInRow.accept(beforeNumberInRow)
            }).disposed(by: self.disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
