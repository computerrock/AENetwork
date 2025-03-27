/**
 *  https://github.com/tadija/AENetwork
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import Foundation

public extension Data {

    enum SerializationError: Swift.Error {
        case jsonSerializationFailed
    }

    init(jsonWith any: Any) throws {
		let encodable = JSONCodableValue(value: any)
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		self = try encoder.encode(encodable)
    }

    func jsonDictionary() throws -> [String: Any] {
        try serializeJSON()
    }

    func jsonArray() throws -> [Any] {
        try serializeJSON()
    }

    // MARK: Helpers

    private func serializeJSON<T>() throws -> T {
        let jsonObject = try JSONSerialization.jsonObject(
            with: self, options: .allowFragments
        )
        guard let parsed = jsonObject as? T else {
            throw SerializationError.jsonSerializationFailed
        }
        return parsed
    }

}

enum JSONCodableValue: Codable {
	case string(String)
	case int(Int)
	case double(Double)
	case float(Float)
	case bool(Bool)
	case array([JSONCodableValue])
	case dictionary([String: JSONCodableValue])
	case null
	
	init(value: Any) {
		switch value {
		case let str as String:
			self = .string(str)
		case let int as Int:
			self = .int(int)
		case let double as Double:
			self = .double(double)
		case let float as Float:
			self = .float(float)
		case let bool as Bool:
			self = .bool(bool)
		case let array as [Any]:
			self = .array(array.map { JSONCodableValue(value: $0) })
		case let dict as [String: Any]:
			self = .dictionary(dict.mapValues { JSONCodableValue(value: $0) })
		case Optional<Any>.none:
			self = .null
		default:
			debugPrint("Unsupported type: \(type(of: value))")
			self = .null
		}
	}
	
	// Encode method
	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		
		switch self {
		case .string(let str):
			try container.encode(str)
		case .int(let int):
			try container.encode(int)
		case .double(let double):
			try container.encode(double)
		case .float(let float):
			try container.encode(float)
		case .bool(let bool):
			try container.encode(bool)
		case .array(let array):
			try container.encode(array)
		case .dictionary(let dict):
			try container.encode(dict)
		case .null:
			try container.encodeNil()
		}
	}
	
	// Decoder (if needed)
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		
		if let str = try? container.decode(String.self) {
			self = .string(str)
		} else if let int = try? container.decode(Int.self) {
			self = .int(int)
		} else if let double = try? container.decode(Double.self) {
			self = .double(double)
		} else if let float = try? container.decode(Float.self) {
			self = .float(float)
		} else if let bool = try? container.decode(Bool.self) {
			self = .bool(bool)
		} else if let array = try? container.decode([JSONCodableValue].self) {
			self = .array(array)
		} else if let dict = try? container.decode([String: JSONCodableValue].self) {
			self = .dictionary(dict)
		} else if container.decodeNil() {
			self = .null
		} else {
			throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Cannot decode"))
		}
	}
}
