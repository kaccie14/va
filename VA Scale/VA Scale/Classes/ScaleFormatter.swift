//
//  ScaleFormatter.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/15/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import Foundation

class ScaleFormatter {

	static func scaleFormat(fromLetter score: Int8, toScale type: ScaleType) -> String {
		let etdrs = Measurement(value: Double(score), unit: ScaleUnit.etdrs)

		switch type {
		case .etdrs: // etdrs
			return String(format: "%.0f", etdrs.value)
		case .snellen6: // snellen6
			let x = etdrs.converted(to: .snellen6).value
			let dx = fabs(x - round(x))
			return "6/" + String(format: dx < 0.01 ? "%1.0f" : "%1.1f", x) + plusMinusLetters(etdrs: score)
		case .snellen20: // snellen20
			let x = etdrs.converted(to: .snellen20).value
			let dx = fabs(x - round(x))
			return "20/" + String(format: dx < 0.01 ? "%1.0f" : "%1.1f", x) + plusMinusLetters(etdrs: score)
		case .decimal: // decimal
			let x = etdrs.converted(to: .decimal).value
			let dx = fabs(x - round(1000.0 * x)/1000.0)
			return String(format: dx < 1e-3 ? "%1.2f" : "%1.3f", x)
		case .mar: // MAR
			return String(format: "%1.2f", etdrs.converted(to: .mar).value)
		case .logMAR: // logMAR
			return String(format: "%1.2f", etdrs.converted(to: .logMar).value)
		default:
			return "💩"
		}
	}

	static private func plusMinusLetters(etdrs: Int8) -> String {
		let value = Int(round(Double(etdrs) - 5.0 * round(Double(etdrs) / 5.0)))
		return (value == 0) ? "" : (value > 0 ? "⁺" : "⁻") + (abs(value) == 1 ? "¹" : "²")
	}
}
