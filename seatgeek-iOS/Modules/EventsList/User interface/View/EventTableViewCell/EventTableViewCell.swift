//
//  EventTableViewCell.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

  // MARK: - Outlets

  @IBOutlet private(set) weak var eventImageView: UIImageView! {
    didSet {
      self.layoutIfNeeded()
      eventImageView.layer.cornerRadius = 10
      eventImageView.layer.masksToBounds = true
    }
  }
  @IBOutlet private(set) weak var favoriteImageView: UIImageView!
  @IBOutlet private(set) weak var titleLabel: UILabel!
  @IBOutlet private(set) weak var addressLabel: UILabel!
  @IBOutlet private(set) weak var dateLabel: UILabel!
  @IBOutlet private(set) weak var typeLabel: UILabel!
}
