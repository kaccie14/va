//
//  SettingsViewController.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/19/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		for row in 0..<tableView.numberOfRows(inSection: 0) {
			if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) {
				cell.accessoryType = .none
				cell.isSelected = false

				switch row {
				case 0:
					cell.accessoryType = Settings.display_snellen_3meters ? .checkmark : .none
					cell.isSelected = Settings.display_snellen_3meters
				case 1:
					cell.accessoryType = Settings.display_snellen_6meters ? .checkmark : .none
					cell.isSelected = Settings.display_snellen_6meters
				case 2:
					cell.accessoryType = Settings.display_snellen_10feet ? .checkmark : .none
					cell.isSelected = Settings.display_snellen_10feet
				default:
					break
				}
			}
		}
	}

	private func update(settingsAt row: Int, isEnabled: Bool) {
		switch row {
		case 0:
			Settings.display_snellen_3meters = isEnabled
		case 1:
			Settings.display_snellen_6meters = isEnabled
		case 2:
			Settings.display_snellen_10feet = isEnabled
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
		//guard let cell = tableView.cellForRow(at: indexPath) else { return }
		tableView.deselectRow(at: indexPath, animated: false)
		tableView.cellForRow(at: indexPath)?.accessoryType = .none
		update(settingsAt: indexPath.row, isEnabled: false)
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
