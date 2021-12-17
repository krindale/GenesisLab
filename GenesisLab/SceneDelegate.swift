//
//  SceneDelegate.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .white
        
        // Header Button View
        let headerButtonView = HeaderButtonView()
        headerButtonView.mvvm = HeaderButtonMVVM(view: headerButtonView)
        
        // Present Image View : 선택된 이미지
        let presentImageView = PresentImageView()
        presentImageView.mvvm = PresentImageViewMVVM(view: presentImageView)
        
        // 겔러리 이미지 뷰
        let photoCollectionView = PhotoCollectionView(frame: .zero,
                                                      collectionViewLayout: UICollectionViewFlowLayout())
        photoCollectionView.mvvm = PhotoCollectionMVVM(view: photoCollectionView)

        // 메인 화면
        let mainViewController = MainViewController(headerButtonView: headerButtonView,
                                                    presentImageView: presentImageView,
                                                    photoCollectionView: photoCollectionView)
        mainViewController.mainMVVM = MainMVVM(mainViewController: mainViewController,
                                               fetchImage: FetchGallaryImage())
        
        window?.rootViewController
                    = UINavigationController(rootViewController: mainViewController)
        window?.makeKeyAndVisible()
    }

}

