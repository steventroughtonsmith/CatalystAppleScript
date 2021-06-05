//
//  ContentView.swift
//  CatalystAppleScript
//
//  Created by Steven Troughton-Smith on 05/06/2021.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var data = DataModel.shared
	
	var body: some View {
		
		GroupBox {
		VStack {
			TextField("Type here", text: $data.testString)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()
			
			Text("The contents of this text field will be exposed to AppleScript. For example:")
				.padding()
			
			Text("tell application \"CatalystAppleScript\"\n\tactivate\n\tget the saved string\nend tell")
				.padding()
			
			Text("Other commands: set saved string, get/set saved number, get saved list, command 1, command 2 [\"one\", \"two\"]]")
				.padding()
			
			HStack {
				ForEach(data.testArgs, id: \.self) { argument in
					
					Button(argument) {
						
					}
				}
				.padding()
			}
			.padding()

			Rectangle()
				.fill(data.testState1 ? Color.red : Color(.systemBackground))

		}
		.frame(maxWidth:400)
		.padding()
		}
		.padding()

	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
