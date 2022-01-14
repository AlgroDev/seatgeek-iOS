//
//  DesignSystemImageDownloader.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit
import Kingfisher

public final class DesignSystemImageDownloader {}

// MARK: - ImageDownloader

extension DesignSystemImageDownloader: ImageDownloader {
  public func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool) {
    imageView.kf.setImage(with: url, placeholder: placeholder, options: animated ? [.transition(ImageTransition.fade(1)),
                                                                                    .processor(DownsamplingImageProcessor(size: imageView.frame.size)),
                                                                                    .scaleFactor(UIScreen.main.scale),
                                                                                    .cacheOriginalImage
                                                                                   ] : nil)
  }
}
