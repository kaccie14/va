//
//  ScaleUnits.swift
//  VA Scale
//	"baseUnit" taken as ETDRS
//
//  Created by Kaccie Y Li on 1/15/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import Foundation

class ScaleConverter: UnitConverter {

	override func baseUnitValue(fromValue value: Double) -> Double {
		value
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		baseUnitValue
	}

	fileprivate func logMar(for value: Double) -> Double {
		0.02 * (85 - value) // ETDRS → logMAR
	}

	fileprivate func from(logMar: Double) -> Double {
		85 - 50.0 * round(logMar) // logMAR → ETDRS
	}
}

// MARK: - Snellen converters
// outputs the denominator of vulgar fraction ignoring +/- letters

class ScaleSnellen3Converter: ScaleLogMarConverter {
	override func baseUnitValue(fromValue value: Double) -> Double {
		from(logMar: log10(value / 3.0))
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		let etdrs = 5.0 * round(baseUnitValue / 5.0)
		let MAR = pow(10, logMar(for: etdrs))
		let denominator = 3.0 * MAR

		return round(denominator)
	}
}

class ScaleSnellen6Converter: ScaleLogMarConverter {

	override func baseUnitValue(fromValue value: Double) -> Double {
		from(logMar: log10(value / 6.0))
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		// ETDRS (rounded to 5th letter) → logMAR/MAR → denominator (6/6)
		let etdrs = 5.0 * round(baseUnitValue / 5.0)
		let MAR = pow(10, logMar(for: etdrs))
		var denominator = 6.0 * MAR

		// Common rounded values for Snellen 6/6
		switch denominator {
		case 6.0..<12.0:
			denominator = round(2.0 * denominator) / 2.0
		case 3.0..<6:
			denominator = round(5.0 * denominator) / 5.0
		default:
			denominator = round(denominator)
		}
		return denominator
	}
}

class ScaleSnellen10Converter: ScaleLogMarConverter {
	override func baseUnitValue(fromValue value: Double) -> Double {
		from(logMar: log10(value / 10.0))
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		let etdrs = 5.0 * round(baseUnitValue / 5.0)
		let MAR = pow(10, logMar(for: etdrs))
		let denominator = 10.0 * MAR

		return round(denominator)
	}
}

class ScaleSnellen20Converter: ScaleLogMarConverter {

	override func baseUnitValue(fromValue value: Double) -> Double {
		// Denominator (20/20) → MAR/logMAR → ETDRS
		return from(logMar: value / 20.0)
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		// ETDRS (rounded to 5th letter) → logMAR/MAR → denominator (20/20)
		let etdrs = 5.0 * round(baseUnitValue / 5.0) // round to nearest 5th letter
		let mar = pow(10, logMar(for: etdrs))
		var denominator = 20.0 * mar

		switch denominator {
		case 150.0...400.0:
			denominator = 10.0 * round(denominator / 10.0) // Round to nearest 10 for very bad acuity
		case 100.0..<150.0:
			denominator = 5.0 * round(denominator / 5.0)
		case 20.0..<100.0:
			denominator = round(denominator) // Round to nearest integer for bad acuity
		case 10.0..<20.0:
			denominator = round(2.0 * denominator) / 2.0 // Round to nearest half ft for good acuity
		default:
			break
		}
		return denominator
	}
}

// MARK: - Other converters

class ScaleDecimalConverter: ScaleLogMarConverter {

	override func baseUnitValue(fromValue value: Double) -> Double {
		from(logMar: log10(1.0 / value))	// Decimal → logMAR → ETDRS
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		// ETDRS → logMAR
		let logMAR = super.value(fromBaseUnitValue: baseUnitValue)

		// logMAR → Decimal
		var decimal = 1.0 / pow(10, logMAR) // raw decimal VA
		switch decimal {
		case 1.0...2.0:
			decimal = round(decimal * 20.0) / 20.0 // round to nearest .05
		case 0.0..<1.0:
			decimal = round(decimal * 100.0) / 100.0 // round to nearest .01
		default:
			break
		}
		return decimal
	}
}

class ScaleMarConverter: ScaleLogMarConverter {

	override func baseUnitValue(fromValue value: Double) -> Double {
		from(logMar: log10(value)) // MAR → logMAR
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		pow(10, logMar(for: baseUnitValue))	// ETDRS → logMAR → MAR
	}
}


class ScaleLogMarConverter: ScaleConverter {

	override func baseUnitValue(fromValue value: Double) -> Double {
		from(logMar: value) // logMAR → ETDRS
	}

	override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
		logMar(for: baseUnitValue) // ETDRS → logMAR
	}
}

class ScaleUnit: Dimension {
	override class func baseUnit() -> Self {
		return ScaleUnit.etdrs as! Self
	}
	static let etdrs = ScaleUnit(symbol: "etdrs", converter: ScaleConverter())
	static let logMar = ScaleUnit(symbol: "logMar", converter: ScaleLogMarConverter())
	static let mar = ScaleUnit(symbol: "mar", converter: ScaleMarConverter())
	static let snellen3 = ScaleUnit(symbol: "snellen3", converter: ScaleSnellen3Converter())
	static let snellen6 = ScaleUnit(symbol: "snellen6", converter: ScaleSnellen6Converter())
	static let snellen10 = ScaleUnit(symbol: "snellen10", converter: ScaleSnellen10Converter())
	static let snellen20 = ScaleUnit(symbol: "snellen20", converter: ScaleSnellen20Converter())
	static let decimal = ScaleUnit(symbol: "decimal", converter: ScaleDecimalConverter())
}
