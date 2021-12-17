//
//  FetchImageProtocol.swift
//  GenesisLab
//
//  Created by 이해상 on 2021/12/17.
//

import UIKit
import Photos

protocol FetchImageProtocol {
    func fetchImages(complete: @escaping (([UIImage]) -> Void))
}

struct FetchGallaryImage: FetchImageProtocol {

    func fetchImages(complete: @escaping (([UIImage]) -> Void)) {
        self.getPermissionIfNecessary { granted in
            guard granted else { return }
            let images = self.fetchGallaryImage()
            complete(images)
        }
    }
    
    private func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
      guard PHPhotoLibrary.authorizationStatus() != .authorized else {
        completionHandler(true)
        return
      }

      PHPhotoLibrary.requestAuthorization { status in
        completionHandler(status == .authorized ? true : false)
      }
    }
    
    
    private func fetchGallaryImage() -> [UIImage] {
        
        var phAssets: PHFetchResult<PHAsset>
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [ NSSortDescriptor( key: "creationDate", ascending: false)]
        // 2
        phAssets = PHAsset.fetchAssets(with: allPhotosOptions)
        
        var gallaryImages = [UIImage]()
        phAssets.enumerateObjects { asset, index, _ in
            if let image = self.getAssetThumbnail(asset: asset) {
                gallaryImages.append(image)
            }
        }
        
        return gallaryImages
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage? {
        var retimage: UIImage?
        
        PHImageManager
            .default()
            .requestImage(for: asset,
                             targetSize: PHImageManagerMaximumSize,
                             contentMode: .aspectFit,
                             options: nil) { image, info in
                retimage = image
            }
        return retimage
    }
}
