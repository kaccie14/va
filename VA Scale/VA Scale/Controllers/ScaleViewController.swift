//
//  ScaleViewController.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/12/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class ScaleViewController: UITableViewController {

	private let requiredOutputPath = IndexPath(row: 0, section: 1)
	private let optionalOutputPaths = [IndexPath(row: 0, section: 2),  IndexPath(row: 1, section: 2),  IndexPath(row: 2, section: 2)]
	private var sections: FormSections = []

	private var score: Int8 = 85 {
		didSet {
			guard score != oldValue else { return }
			sections[requiredOutputPath.section].items[0] = FormItem("snellenViewCell", title: "Snellen", detail: "20 feet", score: score)
			update(optionalOutputSectionWith: score)
			tableView.reloadRows(at: [requiredOutputPath], with: .none)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setup(sectionForInput: .etdrs, withScore: score)
		setup(sectionForRequired: "")
		setup(sectionForOptional: "")
	}

	// MARK: - Helper functions

	private func update(optionalOutputSectionWith score: Int8) {
		sections[2].items[0] = FormItem("snellenViewCell", title: "Snellen", detail: "10 feet", score: score)
		sections[2].items[1] = FormItem("snellenViewCell", title: "Snellen", detail: "3 feet", score: score)
		sections[2].items[2] = FormItem("snellenViewCell", title: "Snellen", detail: "6 feet", score: score)
		tableView.reloadRows(at: optionalOutputPaths, with: .none)
	}

	private func setup(sectionForInput scale: ScaleType, withScore: Int8) {
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

	private func setup(sectionForOptional output: String) {
		let formItems = [
			FormItem("snellenViewCell", title: "Snellen", detail: "10 feet"),
			FormItem("snellenViewCell", title: "Snellen", detail: "3 meters"),
			FormItem("snellenViewCell", title: "Snellen", detail: "6 meters")
		]

		sections.insert(FormSection(items: formItems), at: 2)
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
			}

			if let cell = cell as? SnellenOutputCell {
				switch indexPath.row {
				case 0:
					cell.scoreLabel.text = ScaleFormatter.scaleFormat(fromLetter: score, toScale: indexPath.section == 1 ? .snellen20 : .snellen10)
				case 1:
					cell.scoreLabel.text = ScaleFormatter.scaleFormat(fromLetter: score, toScale: .snellen3)
				case 2:
					cell.scoreLabel.text = ScaleFormatter.scaleFormat(fromLetter: score, toScale: .snellen6)
				default:
					cell.scoreLabel.text = "💩"
				}
			}
		}

		return cell
	}

	// MARK: - Table view delegate

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return section == 2 ? "User Optional Scales" : nil
	}
}
