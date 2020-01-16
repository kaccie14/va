//
//  SnellenOutputCell.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/14/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class SnellenOutputCell: UITableViewCell {

	var scoreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 20))

    override func awakeFromNib() {
        super.awakeFromNib()

		accessoryView = scoreLabel
		scoreLabel.textAlignment = .right
		scoreLabel.text = "Detail"
    }
}
