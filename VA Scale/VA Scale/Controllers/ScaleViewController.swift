//
//  ScaleViewController.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/12/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class ScaleViewController: UITableViewController {

	private var optionalOutputs: [ScaleType] = []
	private var updateOptionalOutputs = false

	private var sections: FormSections = []

	private var score: Int8 = 85 {
		didSet { // update required and optional output cells with new score
			guard score != oldValue else { return }
			tableView.reloadSections([1, 2], with: .none)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setup(sectionForInput: .etdrs, with: score)
		setup(sectionForRequired: "")
		updateOptionalOutputProperties()
	}

	// MARK: - Helper functions

	private func updateOptionalOutputProperties() {
		if updateOptionalOutputs {
			optionalOutputs.removeAll()
			updateOptionalOutputs = false
			sections.remove(at: 2)
		}

		var formItems: [FormItem] = []

		if Settings.display_snellen_10feet {
			optionalOutputs.append(.snellen10)
			formItems.append(FormItem("snellenViewCell", title: "Snellen", detail: "10 feet"))
		}
		if Settings.display_snellen_3meters {
			optionalOutputs.append(.snellen3)
			formItems.append(FormItem("snellenViewCell", title: "Snellen", detail: "3 meters"))
		}
		if Settings.display_snellen_6meters {
			optionalOutputs.append(.snellen6)
			formItems.append(FormItem("snellenViewCell", title: "Snellen", detail: "6 meters"))
		}

		sections.insert(FormSection(items: formItems), at: 2)
	}

	private func setup(sectionForInput scale: ScaleType, with score: Int8) {
		let formItems = [
			FormItem("inputTitleCell", title: "Input Scale", detail: "ETDRS (85)"),
			FormItem("letterScoreInputCell", title: "Score", score: score)
		]

		sections.insert(FormSection(items: formItems), at: 0)
	}

	private func setup(sectionForRequired output: String) {
		let formItems = [
			FormItem("snellenViewCell", title: "Snellen", detail: "20 feet")
		]

		sections.insert(FormSection(items: formItems), at: 1)
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].items.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = sections[indexPath.section].items[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)

		if !item.title.isEmpty {
			cell.textLabel?.text = item.title
			
			if let detail = item.detail, !detail.isEmpty {
				cell.detailTextLabel?.text = detail
			}

			if let cell = cell as? LetterScoreInputCell {
				cell.score = score
				cell.onValueChange = { _, value in
					self.score = value
				}
			} else if let cell = cell as? SnellenOutputCell {
				cell.scoreLabel.text = ScaleFormatter.scaleFormat(fromLetter: score, toScale: indexPath.section == 1 ? .snellen20 : optionalOutputs[indexPath.row])
			}
		}

		return cell
	}

	// MARK: - Table view delegate

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return (section == 2 && sections[2].items.count != 0) ? "User Optional Scale(s)" : nil
	}

	// MARK: - Navigation

	@IBAction func unwindToScaleViewController(segue: UIStoryboardSegue) {
		if segue.identifier == "doneSettings" {
			updateOptionalOutputs = true
			updateOptionalOutputProperties()
			tableView.reloadData()
		}
	}
}
