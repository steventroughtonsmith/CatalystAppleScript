//
//  Scripting.swift
//  CatalystAppleScript
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

#if targetEnvironment(macCatalyst)
import Foundation

class Scripting: NSObject {
	
	class func enableScripting() {
		
		/*
		Catalyst doesn't have access to the regular NSApplication or AppKit application delegate.
		This is just one method to swizzle NSApplication and process scripting events as they happen
		*/
		
		do {
			let m1 = class_getInstanceMethod(NSClassFromString("NSApplication"), NSSelectorFromString("valueForKey:"))
			let m2 = class_getInstanceMethod(NSClassFromString("NSApplication"), NSSelectorFromString("MyAppScriptingValueForKey:"))
			
			if let m1 = m1, let m2 = m2 {
				method_exchangeImplementations(m1, m2)
			}
		}
		
		do {
			let m1 = class_getInstanceMethod(NSClassFromString("NSApplication"), NSSelectorFromString("setValue:forKey:"))
			let m2 = class_getInstanceMethod(NSClassFromString("NSApplication"), NSSelectorFromString("MyAppScriptingSetValue:forKey:"))
			
			if let m1 = m1, let m2 = m2 {
				method_exchangeImplementations(m1, m2)
			}
		}
	}
}

@objc class MyDoThingCommand: NSScriptCommand {
	
	@objc public func performDefaultImplementation() -> Any? {
		NSLog("MyDoThingCommand")
		
		DataModel.shared.testState1.toggle()
		
		return nil
	}
}

@objc class MyDoThingWithArgumentCommand: NSScriptCommand {
	@objc public func performDefaultImplementation() -> Any? {
		
		let arguments = evaluatedArguments()
		
		NSLog("MyDoThingWithArgumentCommand: \(arguments)")
		
		if arguments.count > 0 {
			if let parameters = arguments.value(forKey: "") as? NSArray { // get the direct argument
				
				var processedArray:[String] = []
				
				for item in parameters {
					if let item = item as? String {
						processedArray.append(item)
					}
				}
				DataModel.shared.testArgs = processedArray
			}
		}
		
		
		return nil
	}
}

extension NSObject {
	@objc public func MyAppScriptingValueForKey(_ key:String) -> Any? {
		
		NSLog("[APPLESCRIPT] Querying value for \(key)")
		
		if key == "savedString" {
			return DataModel.shared.testString
		}
		
		if key == "savedNumber" {
			return DataModel.shared.testNumber
		}
		
		if key == "savedList" {
			return DataModel.shared.testList
		}
		
		if key == "savedBool" {
			return DataModel.shared.testBool
		}
		
		return self.MyAppScriptingValueForKey(key)
	}
	
	@objc public func MyAppScriptingSetValue(_ value:Any, forKey:String) {
		NSLog("[APPLESCRIPT] Setting value for \(forKey): \(String(describing:value))")
		
		if forKey == "savedString" {
			DataModel.shared.testString = String(describing:value)
			return
		}
		
		if forKey == "savedNumber" {
			DataModel.shared.testNumber = value as? Int ?? -1
			return
		}
		
		return self.MyAppScriptingSetValue(value, forKey: forKey)
	}
	
	@objc func evaluatedArguments() -> NSDictionary {
		return NSDictionary()
	}
}
#endif
