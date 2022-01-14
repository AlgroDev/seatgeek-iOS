//
//  ImageDownloader.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

import UIKit

protocol ImageDownloader {
  func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool)
}

extension ImageDownloader {
  func loadImage(imageView: UIImageView, url: URL?, placeholder: UIImage?, animated: Bool) {
    loadImage(imageView: imageView, url: url, placeholder: placeholder, animated: animated)
  }
}
