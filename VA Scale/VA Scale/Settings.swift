//
//  Settings.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/19/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import Foundation

struct Settings {
	@UserDefault("input_etdrs", defaultValue: true)
	static var input_etdrs: Bool

	@UserDefault("display_snellen_10feet", defaultValue: false)
	static var display_snellen_10feet: Bool

	@UserDefault("display_snellen_3meters", defaultValue: false)
	static var display_snellen_3meters: Bool

	@UserDefault("display_snellen_6meters", defaultValue: false)
	static var display_snellen_6meters: Bool

	@UserDefault("display_decimal", defaultValue: false)
	static var display_decimal: Bool

	@UserDefault("display_mar", defaultValue: false)
	static var display_mar: Bool

	@UserDefault("display_logmar", defaultValue: false)
	static var display_logmar: Bool
}

@propertyWrapper
struct UserDefault<T> {
	let key: String
	let defaultValue: T

	init(_ key: String, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
	}

	var wrappedValue: T {
		get {
			return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
		}
		set {
			UserDefaults.standard.set(newValue, forKey: key)
		}
	}
}
