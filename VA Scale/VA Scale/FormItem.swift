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
	let score: Int8?

	init(_ reuseIdentifier: String, title: String) {
		self.reuseIdentifier = reuseIdentifier
		self.title = title
		self.detail = nil
		self.score = nil
	}

	init(_ reuseIdentifier: String, score: Int8) {
		self.reuseIdentifier = reuseIdentifier
		self.title = "\(score)"
		self.detail = nil
		self.score = score
	}

	init(_ reuseIdentifier: String, title: String, detail: String) {
		self.reuseIdentifier = reuseIdentifier
		self.title = title
		self.detail = detail
		self.score = nil
	}
}
