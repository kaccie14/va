//
//  KeyboardToolbar.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/15/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import UIKit

class KeyboardToolbar: UIToolbar {

	typealias doneHandler = ()->Void

	private (set) var onDone: doneHandler?

	init(_ onDone: @escaping doneHandler) {
		super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
		self.onDone = onDone
		barStyle = .default
		items = [
			UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
			UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped(_:)))
		]
		sizeToFit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	@objc func doneTapped(_ sender: UIBarButtonItem) {
		onDone?()
	}
}
