import Foundation
import JSONUtilities
import PathKit
import Yams

extension SwaggerSpec : Encodable {
	enum CodingKeys: String, CodingKey {
		case openapi
		case info
		case paths
        case servers
        case components
        case securityRequirements
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		var pathDict:Dictionary<String,Dictionary<String, Operation>> = [:]
		for path in paths {
			var op:Dictionary<String, Operation> = [:]
			for operation in path.operations {
				op["\(operation.method)"] =  operation
				pathDict[path.path] = op
			}
		}
		try container.encode(version, forKey: .openapi)
		try container.encode(info, forKey: .info)
		try container.encode(pathDict, forKey: .paths)
        try container.encode(servers, forKey: .servers)
        try container.encode(components, forKey: .components)
        try container.encode(securityRequirements, forKey: .securityRequirements)
	}
}

public struct SwaggerSpec {
	public var json: [String: Any]
	public var version: String
	public var info: Info
	public var paths: [Path]
	public var servers: [Server]
	public var components: Components
	public var securityRequirements: [SecurityRequirement]?

	public var operations: [Operation]

	public var tags: [String] {
		let tags: [String] = operations.reduce([]) { $0 + $1.tags }
		let distinctTags = Array(Set(tags))
		return distinctTags.sorted { $0.compare($1) == .orderedAscending }
	}
}

public enum TransferScheme: String {
	case http
	case https
	case ws
	case wss
}

public protocol NamedMappable {
	init(name: String, jsonDictionary: JSONDictionary) throws
}

extension SwaggerSpec {

	public init(url: URL) throws {
		let data: Data
		do {
			data = try Data(contentsOf: url)
		} catch {
			throw SwaggerError.loadError(url)
		}

		if let string = String(data: data, encoding: .utf8) {
			try self.init(string: string)
		} else if let string = String(data: data, encoding: .ascii) {
			try self.init(string: string)
		} else {
			throw SwaggerError.parseError("Swagger doc is not utf8 or ascii encoded")
		}
	}

	public init(path: PathKit.Path) throws {
		let string: String = try path.read()
		try self.init(string: string)
	}

	public init(string: String) throws {
		let yaml = try Yams.load(yaml: string)
		let json = yaml as? JSONDictionary ?? [:]

		try self.init(jsonDictionary: json)
	}
}

extension SwaggerSpec: JSONObjectConvertible {

	public init(jsonDictionary: JSONDictionary) throws {

		func decodeNamed<T: NamedMappable>(jsonDictionary: JSONDictionary, key: String) throws -> [T] {
			var values: [T] = []
			if let dictionary = jsonDictionary[key] as? [String: Any] {
				for (key, value) in dictionary {
					if let dictionary = value as? [String: Any] {
						let value = try T(name: key, jsonDictionary: dictionary)
						values.append(value)
					}
				}
			}
			return values
		}

		json = jsonDictionary
		version = try jsonDictionary.json(atKeyPath: "openapi")
		let versionParts = version.components(separatedBy: ".")
		if Int(versionParts[0]) != 3 {
			throw SwaggerError.invalidVersion(version)
		}

		info = try jsonDictionary.json(atKeyPath: "info")
		servers = jsonDictionary.json(atKeyPath: "servers") ?? []
		securityRequirements = jsonDictionary.json(atKeyPath: "security")
		components = try jsonDictionary.json(atKeyPath: "components")
		paths = try decodeNamed(jsonDictionary: jsonDictionary, key: "paths")
		operations = paths.reduce([]) { $0 + $1.operations }

		let resolver = ComponentResolver(spec: self)
		resolver.resolve()
	}
}
