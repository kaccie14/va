//
//  SettingsViewController.swift
//  Original values of optional VA Scales in Settings are first copied upon loading the view controller. If user taps "Cancel", these values are copied back to Settings to undo all user changes.
//
//  Created by Kaccie Y Li on 1/19/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

	private var snellen_3meters = true
	private var snellen_6meters = true
	private var snellen_10feet = true

	override func viewDidLoad() {
		super.viewDidLoad()

		snellen_10feet = Settings.display_snellen_10feet
		snellen_3meters = Settings.display_snellen_3meters
		snellen_6meters = Settings.display_snellen_6meters
	}

	override func viewWillAppear(_ animated: Bool) {
		for row in 0..<tableView.numberOfRows(inSection: 0) {
			if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) {
				cell.accessoryType = .none
				cell.isSelected = false

				switch row {
				case 0:
					cell.accessoryType = Settings.display_snellen_10feet ? .checkmark : .none
					cell.isSelected = Settings.display_snellen_10feet
				case 1:
					cell.accessoryType = Settings.display_snellen_3meters ? .checkmark : .none
					cell.isSelected = Settings.display_snellen_3meters
				case 2:
					cell.accessoryType = Settings.display_snellen_6meters ? .checkmark : .none
					cell.isSelected = Settings.display_snellen_6meters
				default:
					break
				}
			}
		}
	}

	private func update(settingsAt row: Int, isEnabled: Bool) {
		switch row {
		case 0:
			Settings.display_snellen_10feet = isEnabled
		case 1:
			Settings.display_snellen_3meters = isEnabled
		case 2:
			Settings.display_snellen_6meters = isEnabled
		default:
			break
		}
	}

	// MARK: - Table view delegate

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
		tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		update(settingsAt: indexPath.row, isEnabled: true)
	}

	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		tableView.cellForRow(at: indexPath)?.accessoryType = .none
		update(settingsAt: indexPath.row, isEnabled: false)
	}

	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let segueId = segue.identifier else { return }

		if segueId == "cancelSettings" {
			Settings.display_snellen_3meters = snellen_3meters
			Settings.display_snellen_6meters = snellen_6meters
			Settings.display_snellen_10feet = snellen_10feet
		}
	}
}
