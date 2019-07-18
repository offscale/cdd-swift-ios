//
//  ProjectReader.swift
//	- Responsible for understanding project directory structure and writing reading files

import Foundation
import Yams
import SwiftSyntax

let SPEC_FILE = "/openapi.yml"
let MODELS_DIR = "/ios/API"
let SETTINGS_FILE = "/ios/Settings.swift"

struct FileResult<T> {
	let fileName: String
	let modificationDate: Date
	let result: Result<T,Swift.Error>
}

class ProjectReader {
	let projectPath: String
	var specFile: SpecFile
	var settingsFile: SourceFile
	var sourceFiles: [SourceFile]
    var classToSourceFile: [String:URL] = [:]

	init(path: String) throws {
		self.projectPath = path

		do {
			let specUrl = URL(fileURLWithPath: "\(self.projectPath)/\(SPEC_FILE)")
			self.specFile = SpecFile(
				path: specUrl,
				modificationDate: try fileLastModifiedDate(url: specUrl),
				syntax: try SwaggerSpec.init(url: specUrl)
			)
			self.settingsFile = try SourceFile(path: "\(self.projectPath + SETTINGS_FILE)")
			self.sourceFiles = try [
				"\(self.projectPath + MODELS_DIR)/Test.swift"
			].map({ path in
				try SourceFile(path: path)
			})
		} catch let error {
			throw error
		}
	}

	func generateProject() -> Result<Project, Swift.Error> {
		guard case let .success(projectInfo) = parseProjectInfo(self.settingsFile) else {
			return .failure(
				ProjectError.InvalidSettingsFile("Cannot parse \(SETTINGS_FILE)"))
		}

        let objects = parse(sourceFiles: self.sourceFiles)
        classToSourceFile = objects.2
		return .success(Project(
			info: projectInfo,
			models: objects.0,
			requests: objects.1
		))
	}

    func sync() -> Result<Project, Swift.Error> {
		do {
			// generate a Project from swift files
			let swiftProject = try self.generateProject().get()

			// generate a Project from the openapi spec
			// todo: convert interface to .generateProject() -> Result
			let specProject = Project.fromSwagger(self.specFile)

			// merge the projects with most recent data from each set
			// todo: fix spec to return properly
			let mergedProject = specProject!.merge(with: swiftProject)

			return .success(mergedProject)
		} catch (let err) {
			return .failure(err)
		}
    }

	func apply(project: Project) {

		// apply ProjectInfo to spec file
		self.specFile.apply(projectInfo: project.info)

		// apply ProjectInfo to Settings.swift
		self.settingsFile.update(projectInfo: project.info)

		for model in project.models {
			if self.specFile.contains(model: model.name) {
				self.specFile.update(model: model)
			} else {
				self.specFile.insert(model: model)
			}
		}

		// clean up additional models in spec
		for specModel in self.specFile.generateProject().models {
			if !project.models.contains(where: {$0.name == specModel.name}) {
				self.specFile.remove(model: specModel.name)
			}
		}

		// clean up additional models in source
		// ...

		var projectModels = project.models
		for (fileIndex, file) in self.sourceFiles.enumerated() {
			// todo: clean syntax of parse()
			let (swiftModels, routes, _) = parse(sourceFiles: [file])

			log.eventMessage("Parsing \(file.path.path)")
//			print(swiftModels.map({$0.name}))
//			print(project.models.map({$0.name}))

			for swiftModel in swiftModels {
				if project.models.contains(where: {$0.name == swiftModel.name}) {
					self.sourceFiles[fileIndex].update(model: swiftModel)
					log.eventMessage("Updated \(swiftModel.name) in \(file.path.path)")
				} else {
					self.sourceFiles[fileIndex].delete(model: swiftModel)
					log.eventMessage("Deleted \(swiftModel.name) from \(file.path.path)")
				}

				projectModels = projectModels.filter({$0.name == swiftModel.name})
			}

			for model in projectModels {
				// add remaining models as new files
				self.createSourceFile(from: model)
				log.eventMessage("Created \(model.name) in ---")
			}

			for route in routes {
				print("route: \(route.name)")
			}
		}
	}

	func createSourceFile(from model: Model) {

	}
    
    func writeToSwiftFiles(changes:[Change]) {
        for change in changes {
            if let url = classToSourceFile[change.objectName()],
                let _ = sourceFiles.first(where: {$0.path == url}) {
            }
        }
	}
    
    func writeToSwaggerFiles(changes:[Change]) {
//        self.specFile.syntax.apply(changes)
    }
}

extension Change {
    func objectName() -> String {
        switch self {
        case .deletion(let object):
           return object.objectName()
        case .insertion(let object):
          return object.objectName()
        case .update(let object):
           return object.objectName()
        }
    }
}

extension APIObjectChange {
    func objectName() -> String {
        switch self {
        case .model(let model, _):
            return model.name
        case .request(let request, _):
            return request.name
        }
    }
}
