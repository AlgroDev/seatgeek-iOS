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

  @IBOutlet private(set) weak var eventImageView: UIImageView!
  @IBOutlet private(set) weak var titleLabel: UILabel!
  @IBOutlet private(set) weak var addressLabel: UILabel!
  @IBOutlet private(set) weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
