//
//  SourceParser.swift
//  Basic
//
//  Created by Rob Saunders on 7/6/19.
//

import Foundation
import SwiftSyntax

let MODEL_PROTOCOL = "APIModel"

func parseModels(syntaxes: [SourceFileSyntax]) -> [String: Model] {
	let visitor = ClassVisitor()
	var models: [String: Model] = [:]

	for syntax in syntaxes {
		syntax.walk(visitor)
	}

	for klass in visitor.klasses {
		if klass.interfaces.contains(MODEL_PROTOCOL) {
			models[klass.name] = Model(name: klass.name)
		}
	}

	return models
}

let ROUTE_PROTOCOL = "APIRequest"

func parseRoutes(syntaxes: [SourceFileSyntax]) -> [String: Route] {
	let visitor = ClassVisitor()
	var routes: [String: Route] = [:]

	for syntax in syntaxes {
		syntax.walk(visitor)
	}

	for klass in visitor.klasses {
		if klass.interfaces.contains(ROUTE_PROTOCOL) {
			if let e = klass.vars["urlPath"],
				case let .Complex(url) = e {
				let paths = Route(paths: [RoutePath(urlPath: url, requests: [])])
				routes[klass.name] = paths
			}
//			if let MemberVarType.Complex(let urlPath) = klass.vars["urlPath"] {
//
//			}
//			if let urlPath = MemberVarType.Complex() {
//				routes[klass.name] = Route(paths: [
//					RoutePath(urlPath: klass.vars["urlPath"], requests: [])
//				])
//			}
		}
	}

	// todo: complete
	return routes
}

func parseProjectInfo(syntax: SourceFileSyntax) -> ProjectInfo {
	let visitor = ExtractVariables()
	syntax.walk(visitor)

	let hostname =  URL(string: visitor.variables["HOST"]! + visitor.variables["ENDPOINT"]!)

	return ProjectInfo(hostname: hostname!)
}
