import Foundation
import SwiftSyntax
import SwiftCLI

//let arguments = Array(CommandLine.arguments.dropFirst())
//let project = try! ProjectReader(path: arguments[0])

//CLI(
//    name: "cdd-swift",
//    version: "0.1.0",
//    description: "Compiler Driven Development: Swift Adaptor",
//    commands: [
//        GenerateCommand(),
//        SyncCommand()
//    ]
//).goAndExit()

try? WriteToYmlTest().run()
