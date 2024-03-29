import Foundation
import SwiftCLI
import Willow

let TEMPLATE_PATH = "/.cdd/swift"

class GenerateCommand: Command {
    let name = "generate"
    let shortDescription = "Generates a new CDD project."
    let projectName = SwiftCLI.Parameter()
    let projectPath = Key<String>("-p", "--project-path", description: "Manually specify a path to output the project")
    
    let verbose = Flag("-v", "--verbose", description: "Show verbose output", defaultValue: false)
    let output = Key<String>("-f", "--output-file", description: "Output logging to file")
    
    func execute() throws {
        let templatePath = NSHomeDirectory() + TEMPLATE_PATH
        
        if let path = output.value {
            log.enableFileOutput(path: path)
        }
        
        guard fileExists(file: templatePath) else {
            log.errorMessage("Template path does not exist: \(templatePath)")
            return
        }
        
        let targetDir:String = {
            if let projectPath = projectPath.value {
                return projectPath
            } else {
                return "./\(projectName.value)"
            }
        }()
        
        copyDirectory(from: templatePath, to: targetDir, projectName: projectName.value)
        log.infoMessage("Project template successfully generated at \(targetDir)")
    }
}

