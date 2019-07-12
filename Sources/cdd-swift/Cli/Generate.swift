//
//  Generate.swift
//  Basic
//
//  Created by Rob Saunders on 7/8/19.
//

import Foundation
import SwiftCLI

class GenerateCommand: Command {
	func execute() throws {
		let syntax = fileToSyntax("/Users/alexei/Documents/Projects/cdd-swift-ios/Test.swift")

		do {
			let result = try syntax.result.get()

//			for (_, model) in parseModels(sourceFiles: [result]) {
//				print(model)
//			}
//
//			for (_, route) in parseRoutes(sourceFiles: [result]) {
//				print(route)
//			}
		} catch (let err) {
			print("error \(err)")
            throw err
		}
	}

	let name = "generate"
	let shortDescription = "Generates a new swift CDD-Swift project"
}
