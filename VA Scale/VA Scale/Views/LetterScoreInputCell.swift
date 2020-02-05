//
//  LetterScoreInputCell.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/14/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class LetterScoreInputCell: UITableViewCell {

	@IBOutlet var textField: UITextField!

	var onValueChange: ((LetterScoreInputCell, Int8) -> Void)? = nil
	var onValidityCheck: ((LetterScoreInputCell, Bool) -> Void)? = nil

	var inputValid: Bool = true {
		didSet {
			onValidityCheck?(self, inputValid)
			textField.layer.borderWidth = 1
			textField.layer.cornerRadius = 6
			textField.layer.borderColor = inputValid ? UIColor.lightGray.cgColor : UIColor.red.cgColor
		}
	}

	var score: Int8 = 85 {
		didSet{
			textField.text = String(format: "%02d", score)//"\(score)"
			stepper.value = Double(score)
			inputValid = score >= 20 && score <= 100
		}
	}

	private var stepper = UIStepper()

	@IBAction private func stepperTapped(_ sender: UIStepper) {
		score = Int8(stepper.value)
		onValueChange?(self, score)
	}

	override func awakeFromNib() {
		super.awakeFromNib()

		textField.inputAccessoryView = KeyboardToolbar({ self.textField.resignFirstResponder() })

		accessoryView = stepper
		stepper.addTarget(self, action: #selector(stepperTapped(_:)), for: .valueChanged)
		stepper.minimumValue = 20
		stepper.maximumValue = 100
		stepper.stepValue = 1
		stepper.value = Double(score)
	}
}

extension LetterScoreInputCell: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

		if let text = textField.text, let textRange = Range(range, in: text) {
			let updatedText = text.replacingCharacters(in: textRange, with: string)
			if updatedText.isEmpty {
				inputValid = false
				return true
			}
			guard let intValue = Int8(updatedText) else {
				inputValid = false
				return true
			}

			if intValue >= 20, intValue <= 100 {
				inputValid = true
				stepper.value = Double(intValue)
				onValueChange?(self, intValue)
			} else {
				inputValid = false
			}
			return true
		}
		inputValid = true
		return true
	}
}
