//
//  LetterScoreInputCell.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/14/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class LetterScoreInputCell: UITableViewCell {

	// TODO: make right detail label a textfield where user can input via keypad

	var onValueChange: ((LetterScoreInputCell, Int8) -> Void)? = nil

	var score: Int8 = 85 {
		didSet{
			stepper.value = Double(score)
			detailTextLabel?.text = "\(score)"
		}
	}

	private var stepper = UIStepper()

    override func awakeFromNib() {
        super.awakeFromNib()

		accessoryView = stepper
		stepper.addTarget(self, action: #selector(stepperTapped(_:)), for: .valueChanged)
		stepper.minimumValue = 20
		stepper.maximumValue = 100
		stepper.stepValue = 1
		stepper.value = Double(score)
    }

	@IBAction private func stepperTapped(_ sender: UIStepper) {
		score = Int8(stepper.value)
		onValueChange?(self, score)
	}

}
