//
//  ScaleViewController.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/12/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

private var sections: FormSections = []

class ScaleViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		setup(sectionForInput: "")


	}

	// MARK: - Helper functions

	private func setup(sectionForInput input: String) {
		let formItems = [
			FormItem("inputTitleCell", title: "Input Scale", detail: "ETDRS (85)"),
			FormItem("letterScoreInputCell", score: 85)
		]

		sections.insert(FormSection(items: formItems), at: 0)
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
		}

		if let detail = item.detail, !detail.isEmpty {
			cell.detailTextLabel?.text = detail
		}

		return cell
	}

}

