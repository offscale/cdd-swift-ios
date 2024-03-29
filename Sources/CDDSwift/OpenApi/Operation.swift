import JSONUtilities

extension Operation : Encodable {
	enum CodingKeys: String, CodingKey {
		case summary
		case operationId
		case tags
        case parameters
        case responses
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

        
		// print(self)
		try container.encode(summary, forKey: .summary)
		try container.encode(identifier, forKey: .operationId)
		try container.encode(tags, forKey: .tags)
        try container.encode(parameters, forKey: .parameters)
        
        var responsesDict:Dictionary<String,OperationResponse> = [:]
        for response in responses {
            if let statusCode = response.statusCode {
                responsesDict["\(statusCode)"] = response
            }
            else {
                responsesDict["default"] = response
            }
        }
        
        try container.encode(responsesDict, forKey: .responses)
	}
}

public struct Operation {

	public let json: [String: Any]
	public var path: String
	public var method: Method
	public let summary: String?
	public let description: String?
	public let requestBody: PossibleReference<RequestBody>?
	public let pathParameters: [PossibleReference<Parameter>]
	public var operationParameters: [PossibleReference<Parameter>]

	public var parameters: [PossibleReference<Parameter>] {
		return pathParameters.filter { pathParam in
			!operationParameters.contains { $0.value.name == pathParam.value.name }
			} + operationParameters
	}

	public var responses: [OperationResponse]
	public var defaultResponse: PossibleReference<Response>?
	public let deprecated: Bool
	public let identifier: String?
	public let tags: [String]
	public let securityRequirements: [SecurityRequirement]?

	public var generatedIdentifier: String {
		return identifier ?? "\(method)\(path)"
	}

	public enum Method: String {
		case get
		case put
		case post
		case delete
		case options
		case head
		case patch
	}
}

extension Operation {

	public init(path: String, method: Method, pathParameters: [PossibleReference<Parameter>], jsonDictionary: JSONDictionary) throws {
		json = jsonDictionary
		self.path = path
		self.method = method
		self.pathParameters = pathParameters
		if jsonDictionary["parameters"] != nil {
			operationParameters = try jsonDictionary.json(atKeyPath: "parameters")
		} else {
			operationParameters = []
		}
		summary = jsonDictionary.json(atKeyPath: "summary")
		description = jsonDictionary.json(atKeyPath: "description")
		requestBody = jsonDictionary.json(atKeyPath: "requestBody")

		identifier = jsonDictionary.json(atKeyPath: "operationId")
		tags = (jsonDictionary.json(atKeyPath: "tags")) ?? []
		securityRequirements = jsonDictionary.json(atKeyPath: "security")

		let allResponses: [String: PossibleReference<Response>] = try jsonDictionary.json(atKeyPath: "responses")
		var mappedResponses: [OperationResponse] = []
		for (key, response) in allResponses {
			if let statusCode = Int(key) {
				let response = OperationResponse(statusCode: statusCode, response: response)
				mappedResponses.append(response)
			}
		}

		if let defaultResponse = allResponses["default"] {
			self.defaultResponse = defaultResponse
			mappedResponses.append(OperationResponse(statusCode: nil, response: defaultResponse))
		} else {
			defaultResponse = nil
		}

		responses = mappedResponses.sorted {
			let code1 = $0.statusCode
			let code2 = $1.statusCode
			switch (code1, code2) {
			case let (.some(code1), .some(code2)): return code1 < code2
			case (.some, .none): return true
			case (.none, .some): return false
			default: return false
			}
		}

		deprecated = (jsonDictionary.json(atKeyPath: "deprecated")) ?? false
	}
}
