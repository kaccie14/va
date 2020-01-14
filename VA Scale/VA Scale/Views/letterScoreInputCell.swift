//
//  etdrsLetterInputCell.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/14/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class letterScoreInputCell: UITableViewCell {

	var score: Int8 = 85 {
		didSet{
			textLabel?.text = "\(score)"
		}
	}

	private var stepper = UIStepper()

    override func awakeFromNib() {
        super.awakeFromNib()

		accessoryView = stepper
		stepper.addTarget(self, action: #selector(stepperTapped(_:)), for: .valueChanged)
		stepper.minimumValue = 20
		stepper.maximumValue = 100
		stepper.stepValue = 5
		stepper.value = Double(score)
    }

	@IBAction private func stepperTapped(_ sender: UIStepper) {
		score = Int8(stepper.value)
		//onValueChange?(self, diopters)
	}

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }

}
