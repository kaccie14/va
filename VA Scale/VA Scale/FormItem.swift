//
//  FormItem.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/12/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import Foundation

struct FormItem {
	let reuseIdentifier: String
	let title: String
	let detail: String?
	let accessory: String?
	let score: Int8?

	init(_ reuseIdentifier: String, title: String) {
		self.reuseIdentifier = reuseIdentifier
		self.title = title
		self.detail = nil
		self.accessory = nil
		self.score = nil
	}

	init(_ reuseIdentifier: String, title: String, detail: String) {
		self.reuseIdentifier = reuseIdentifier
		self.title = title
		self.detail = detail
		self.accessory = nil
		self.score = nil
	}

	init(_ reuseIdentifier: String, title: String, score: Int8) {
		self.reuseIdentifier = reuseIdentifier
		self.title = title
		self.detail = "\(score)"
		self.accessory = nil
		self.score = score
	}
}
