import Foundation
import SwiftCLI
import Rainbow

class SyncCommand: Command {
	let name = "sync"
	let shortDescription = "Synchronizes OpenAPI spec to a CDD-Swift project"
	//		let verbose = Flag("--verbose", "-v", description: "Show verbose output", defaultValue: false)
	//		let silent = Flag("--silent", "-s", description: "Silence standard output", defaultValue: false)
	let spec = SwiftCLI.Parameter()

	func execute() throws {

		// spec
		let specURL: URL
		if let url = URL(string: spec.value) {
			specURL = url
		} else {
			exitWithError("Must pass valid spec. It can be a path or a url")
		}

		sync(spec: specURL)
	}

	func sync(spec: URL) {
		let projectReader = try! ProjectReader(path: spec.absoluteString)

		printFileResults(fileResults: [projectReader.settingsSyntax])
		printFileResults(fileResults: projectReader.parsableFiles)

		switch projectReader.generateProject() {
		case .success(let project):
			print("[OK] Successfully generated project with \(project.models.count) models, \(project.routes.count) routes.".green)
			print(project)
		case .failure(let error):
			print("[Error] \(error.localizedDescription)".red)
		}
	}
}

func printResult<T>(fileName: String, result: Result<T, Swift.Error>) {
	switch result {
	case .success(_):
		print("[OK] Parsed \(fileName)".green)
	case .failure(let error):
		print("[Error] parsing: \(fileName):\n\(error.localizedDescription)".red)
	}
}

func printFileResults<T>(fileResults: [FileResult<T>]) {
	for fileResult in fileResults {
		printResult(fileName: fileResult.fileName, result: fileResult.result)
	}
}

func exitWithError(_ string: String) -> Never {
	print(string.red)
	exit(EXIT_FAILURE)
}