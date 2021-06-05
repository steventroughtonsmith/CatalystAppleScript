//
//  DataModel.swift
//  CatalystAppleScript
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

import SwiftUI
import UIKit

class DataModel:ObservableObject {
	static let shared = DataModel()
	
	@Published var testString = "This is a test"
	@Published var testNumber = 42
	@Published var testBool = true

	@Published var testList = ["One", "Two", "Three"]

	@Published var testState1 = false
	@Published var testArgs:[String] = []
	
}
