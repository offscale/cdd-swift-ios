import JSONUtilities

extension ArraySchema : Encodable {
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch items {
        case .single(let schema):
            try container.encode(schema, forKey: .items)
        case .multiple(let schemas):
            try container.encode(schemas, forKey: .items)
        }
        
    }
}

public struct ArraySchema {
    public let items: ArraySchemaItems
    public let minItems: Int?
    public let maxItems: Int?
    public let additionalItems: Schema?
    public let uniqueItems: Bool

    public enum ArraySchemaItems {
        case single(Schema)
        case multiple([Schema])
    }
}

extension ArraySchema: JSONObjectConvertible {

    public init(jsonDictionary: JSONDictionary) throws {
        let itemsKey = "items"
        if let single: Schema = jsonDictionary.json(atKeyPath: .key(itemsKey)) {
            items = .single(single)
        } else if let multiple: [Schema] = jsonDictionary.json(atKeyPath: .key(itemsKey)) {
            items = .multiple(multiple)
        } else {
            throw SwaggerError.invalidArraySchema(jsonDictionary)
        }

        minItems = jsonDictionary.json(atKeyPath: "minItems")
        maxItems = jsonDictionary.json(atKeyPath: "maxItems")
        additionalItems = jsonDictionary.json(atKeyPath: "additionalItems")
        uniqueItems = jsonDictionary.json(atKeyPath: "uniqueItems") ?? false
    }
}
