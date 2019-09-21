//
//  UnitTestBuilder.swift
//  CDDSwift
//
//  Created by Rob Saunders on 11/09/2019.
//

import Foundation


class TestsBuilder {
    var project: Project
    var projectName: String
    
    init(project: Project, projectName: String) {
        self.project = project
        self.projectName = projectName
    }
    
    func build() -> String {
        let testFunctions =  project.requests.map({buildTest(from: $0)}).joined(separator: "\n\n")
        
        return """
        import XCTest
        @testable import \(projectName)
        
        class cddRequestTests: XCTestCase {
        
        \(testFunctions)
        
        }
        """
    }
    
    private func buildTest(from request: Request) -> String {
        let method = "\(request.method)".uppercased()
        
        return """
        // \(method) \(request.urlPath)
        func test\(request.name)() {
        let request = \(request.name)(\(buildParams(request.vars)))
        
        request.send(
        client: MockClient(json: #"\(buildResponse(for: request))"#, statusCode: 200),
        onResult: { pet in /*ok*/ },
        onError: { error in XCTFail("onError: \\(error)") },
        onOtherError: { error in XCTFail("onOtherError: \\(error)") })
        }
        """
    }
    
    private func buildParams(_ vars: [Variable]) -> String  {
        return vars.map({
            "\($0.name): \(defaultArgumentForType($0.type))"
        }).joined(separator: ", ")
    }
    
    private func buildJSON(_ vars: [Variable]) -> String  {
        return vars.map({
            "\"\($0.name)\": \(defaultArgumentForType($0.type))"
        }).joined(separator: ", ")
    }
    
    private func buildResponse(for request: Request) -> String {
        let modelName = request.responseType.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        guard let model = project.models.first(where: {$0.name == modelName}) else { return "{}"}
        
        
        let modelJSON = "{" + buildJSON(model.vars) + "}"
        
        if request.responseType.hasPrefix("[") {
            return "[\(modelJSON)]"
        }
        return modelJSON
    }
    
    private func defaultArgumentForType(_ type: Type) -> String {
        switch type {
        case .primitive(let t):
            switch t {
            case .Bool:
                return "true"
            case .Float:
                return "0.0"
            case .Int:
                return "1"
            case .String:
                return "\"fred\""
            }
        case .array(let type):
            return "[\(defaultArgumentForType(type))]"
        case .complex(_):
            return "nil"
        }
    }
}
