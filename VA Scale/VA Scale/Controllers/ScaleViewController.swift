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
	private var sections: FormSections = []

	private var score: Int8 = 85 {
		didSet {
			guard score != oldValue else { return }
			sections[requiredOutputPath.section].items[0] = FormItem("snellenViewCell", title: "Snellen", detail: "20 feet", score: score)
			tableView.reloadRows(at: [requiredOutputPath], with: .none)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setup(sectionForInput: .etdrs, withScore: score)
		setup(sectionForDisplaying: "")
	}

	// MARK: - Helper functions

	private func setup(sectionForInput scale: ScaleType, withScore: Int8) {
		let formItems = [
			FormItem("inputTitleCell", title: "Input Scale", detail: "ETDRS (85)"),
			FormItem("letterScoreInputCell", title: "Score", score: score)
		]

		sections.insert(FormSection(items: formItems), at: 0)
	}

	private func setup(sectionForDisplaying output: String) {
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
			}

			if let cell = cell as? SnellenOutputCell {
				cell.scoreLabel.text = ScaleFormatter.scaleFormat(fromLetter: score, toScale: .snellen20)
			}
		}

		return cell
	}

}
