//
//  MainViewController.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MainViewController: UIViewController {
    
    // 전체 화면을 이루 StackView
    private var containerStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var disposdBag = DisposeBag()
    
    // Header Button View : 버튼 포함
    private var headerButtonView: HeaderButtonView
    // Present Image View : 갤러리에서 선택시 업데이트 되는 큰 이미지
    private var presentImageView: PresentImageView
    // Photo Collection View : 갤러리의 모든 이미지들
    private var photoCollectionView: PhotoCollectionView
    
    var mainMVVM: MainMVVM?
    
    
    init(headerButtonView: HeaderButtonView,
         presentImageView: PresentImageView,
         photoCollectionView: PhotoCollectionView) {
        
        self.headerButtonView = headerButtonView
        self.presentImageView = presentImageView
        self.photoCollectionView = photoCollectionView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Setup UI
        self.setupUI()
        // Setup Rx
        self.setupRx()
        
        // Fetch Images
        self.mainMVVM?.fetchImages()
    }
    
    // Setup UI
    private func setupUI() {
        
        // Hide NavigationBar
        self.navigationController?.isNavigationBarHidden = true
        
        // Add Container StackView to View
        self.view.addSubview(self.containerStackView)
        self.containerStackView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // Add Header / Present ImageView / Gallary ImagesView
        self.containerStackView.addArrangedSubview(self.headerButtonView)
        self.containerStackView.addArrangedSubview(self.presentImageView)
        self.containerStackView.addArrangedSubview(self.photoCollectionView)
        
        // Set Size of Each Views
        self.headerButtonView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height * (1.0 / 10.0))
        }
        self.presentImageView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height * (4.0 / 10.0))
        }
    }
    
    // Setup Rx
    private func setupRx() {
        
        guard
            let headerButtonMVVM = self.headerButtonView.mvvm,
            let presentImageMVVM =  self.presentImageView.mvvm,
            let photoCollectMVVM = self.photoCollectionView.mvvm,
            let mainMVVM = self.mainMVVM else {
                return
            }
        
        // 겔러리 뷰 Row 개수 업데이트
        headerButtonMVVM
            .rxNumberInRow
            .bind(to: photoCollectMVVM.rxNumberInRow)
            .disposed(by: self.disposdBag)
        
        // Update Selected Image
        self.photoCollectionView.rx
            .itemSelected
            .map({ mainMVVM.rxImages.value[$0.row] })
            .bind(to: presentImageMVVM.rxImage)
            .disposed(by: self.disposdBag)
        
        // Update CollectionView Images
        mainMVVM.rxImages
            .do(onNext: { images in
                if presentImageMVVM.rxImage.value == nil,
                   let firstImage = mainMVVM.rxImages.value.first {
                    presentImageMVVM.rxImage.accept(firstImage)
                }
            })
            .bind(to: photoCollectMVVM.rxImages)
            .disposed(by: self.disposdBag)
    }
    
}
