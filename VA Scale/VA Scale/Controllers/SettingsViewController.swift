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
	private var decimal = true
	private var mar = true
	private var logmar = true

	override func viewDidLoad() {
		super.viewDidLoad()

		// Store original settings should use tap cancel button
		snellen_10feet = Settings.display_snellen_10feet
		snellen_3meters = Settings.display_snellen_3meters
		snellen_6meters = Settings.display_snellen_6meters
		decimal = Settings.display_decimal
		mar = Settings.display_mar
		logmar = Settings.display_logmar
	}

	override func viewWillAppear(_ animated: Bool) {
		var indexPath = IndexPath(row: 0, section: 0)
		var isSelected = false

		for row in 0..<tableView.numberOfRows(inSection: 0) {
			indexPath.row = row
			if let cell = tableView.cellForRow(at: indexPath) {
				switch row {
				case 0:
					cell.accessoryType = snellen_10feet ? .checkmark : .none
					isSelected = snellen_10feet
				case 1:
					cell.accessoryType = snellen_3meters ? .checkmark : .none
					isSelected = snellen_3meters
				case 2:
					cell.accessoryType = snellen_6meters ? .checkmark : .none
					isSelected = snellen_6meters
				case 3:
					cell.accessoryType = decimal ? .checkmark : .none
					isSelected = decimal
				case 4:
					cell.accessoryType = mar ? .checkmark : .none
					isSelected = mar
				case 5:
					cell.accessoryType = logmar ? .checkmark : .none
					isSelected = logmar
				default:
					return
				}

				if isSelected { // set initial selection state of each cell (optional va scale)
					tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
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
		case 3:
			Settings.display_decimal = isEnabled
		case 4:
			Settings.display_mar = isEnabled
		case 5:
			Settings.display_logmar = isEnabled
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

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let segueId = segue.identifier else { return }

		if segueId == "cancelSettings" {
			Settings.display_snellen_3meters = snellen_3meters
			Settings.display_snellen_6meters = snellen_6meters
			Settings.display_snellen_10feet = snellen_10feet
			Settings.display_decimal = decimal
			Settings.display_mar = mar
			Settings.display_logmar = logmar
		}
	}
}
