//
//  scaleType.swift
//  VA Scale
//
//  Created by Kaccie Y Li on 1/14/20.
//  Copyright © 2020 Kaccie Y Li. All rights reserved.
//

import Foundation

enum ScaleType: Int {
	case etdrs = 0
	case snellen3
	case snellen6
	case snellen10
	case snellen20
	case decimal
	case mar
	case logMAR

	var description: String {
		switch self {
		case .etdrs:
			return "ETDRS 85"
		case .snellen3:
			return "ETDRS (3 m)"
		case .snellen6:
			return "Snellen (6 m)"
		case .snellen10:
			return "Snellen (10 ft)"
		case .snellen20:
			return "Snellen (20 ft)"
		case .decimal:
			return "Decimal"
		case .mar:
			return "MAR (arcmin)"
		case .logMAR:
			return "logMAR"
		}
	}
}

extension ScaleType: CaseIterable {
	static let usableCases: [ScaleType] = [.etdrs, .snellen20, .logMAR]
}
