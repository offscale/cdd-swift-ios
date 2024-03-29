import JSONUtilities

extension Parameter : Encodable {
	enum CodingKeys: String, CodingKey {
		case name
        case location = "in"
        case description
        case required
        case type
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(description, forKey: .description)
        try container.encode(required, forKey: .required)
        try type.encode(to: encoder)
        
	}
}

public struct Parameter {
	public let name: String
	public let location: ParameterLocation
	public var description: String?
	public var required: Bool
	public let example: Any?
	public var type: ParameterType
	public let json: [String: Any]
}

extension ParameterSchema : Encodable {
    enum CodingKeys: String, CodingKey {
        case serializationStyle
        case explode
    }
    
    public func encode(to encoder: Encoder) throws {
        try schema.encode(to: encoder)
    }
}

public struct ParameterSchema {
	public var schema: Schema
	public let serializationStyle: SerializationStyle
	public let explode: Bool
}

public enum ParameterLocation: String, Encodable {
	case query
	case header
	case path
	case cookie
}

extension ParameterType : Encodable {
    enum CodingKeys: String, CodingKey {
        case schema
        case content
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
		case .content(_):
            break
        case .schema(let schema):
            try container.encode(schema, forKey: .schema)
        }
    }
}

public enum ParameterType {
	case content(Content)
	case schema(ParameterSchema)
}

extension Parameter: JSONObjectConvertible {

	public init(jsonDictionary: JSONDictionary) throws {
		json = jsonDictionary
		name = try jsonDictionary.json(atKeyPath: "name")
		let location: ParameterLocation = try jsonDictionary.json(atKeyPath: "in")
		self.location = location
		description = jsonDictionary.json(atKeyPath: "description")
		required = (jsonDictionary.json(atKeyPath: "required")) ?? false
		example = jsonDictionary["example"]

		if jsonDictionary["content"] != nil {
			let content: Content = try jsonDictionary.json(atKeyPath: "content")
			type = .content(content)
		} else {
			let schema: Schema = try jsonDictionary.json(atKeyPath: "schema")
			let serializationStyle: SerializationStyle = jsonDictionary.json(atKeyPath: "style") ?? location.defaultSerializationStyle
			let explode: Bool = jsonDictionary.json(atKeyPath: "explode") ?? (serializationStyle == .form ? true : false)
			let parameterSchema = ParameterSchema(schema: schema, serializationStyle: serializationStyle, explode: explode)
			type = .schema(parameterSchema)
		}
	}
}
