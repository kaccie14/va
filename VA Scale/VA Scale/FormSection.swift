//
//  FormSection.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/13/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import Foundation

typealias FormSections = [FormSection]

struct FormSection {
	let title: String
	var items: [FormItem]

	init(items: [FormItem]) {
		self.init(title: "", items: items)
	}

	init(title: String, items: [FormItem]) {
		self.title = title
		self.items = items
	}
}
