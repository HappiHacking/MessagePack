//
//  File.swift
//  
//
//  Created by Jim Wilenius on 2020-06-29.
//

import Foundation


import XCTest
@testable import MessagePack

class TestEncodeDecodeDualType: XCTestCase {
    static var allTests = [
        ("testEncodeDecodeDualTypeString", testEncodeDecodeDualTypeString),
        ("testEncodeDecodeDualTypeBytes", testEncodeDecodeDualTypeBytes),
        ("testEncodeDecodeDualTypeBytes2", testEncodeDecodeDualTypeBytes2),
    ]
    
    func testEncodeDecodeDualTypeString() {
        do {
            let data : Data = try MessagePackEncoder().encode(DualHolder(DualType.string("Hi!")))
            let d : DualHolder = try MessagePackDecoder().decode(DualHolder.self, from: data)
            XCTAssertEqual(d.dualType.getAsString(), "Hi!")
        } catch let e {
            print("\(String(describing: e))")
            XCTFail()
        }
    }

    func testEncodeDecodeDualTypeBytes() {
        do {
            let data : Data = try MessagePackEncoder().encode(DualHolder(DualType.bytes([1,2,3])))
            let d : DualHolder = try MessagePackDecoder().decode(DualHolder.self, from: data)
            XCTAssertEqual(d.dualType.getAsBytes(), [1,2,3])
        } catch let e {
            print("\(String(describing: e))")
            XCTFail()
        }
    }

    func testEncodeDecodeDualTypeBytes2() {
        do {
            let bytes : [UInt8] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
            let data : Data = try MessagePackEncoder().encode(DualHolder(DualType.bytes(bytes)))
            let d : DualHolder = try MessagePackDecoder().decode(DualHolder.self, from: data)
            XCTAssertEqual(d.dualType.getAsBytes(), bytes)
        } catch let e {
            print("\(String(describing: e))")
            XCTFail()
        }
    }

    class DualHolder : Codable {
        let dualType : DualType
        init(_ type : DualType) {
            dualType = type
        }
    }
    
    enum DualType : Codable, Equatable {
        case bytes([UInt8])
        case string(String)
        
        public func getAsString() -> String? {
            switch self {
            case .string(let id):
                return Optional.some(id)
            default:
                return Optional.none
            }
        }
        
        public func getAsBytes() -> [UInt8]? {
            switch self {
            case .bytes(let mac):
                return Optional.some(mac)
            default:
                return Optional.none
            }
        }
        
        public init(from decoder: Decoder) throws {
            let container  = try decoder.singleValueContainer()
            do {
                self = .bytes(try container.decode([UInt8].self))
            } catch DecodingError.valueNotFound {
                self = .string(try container.decode(String.self))
            }
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .bytes(let value):
                try container.encode(value)
            case .string(let value):
                try container.encode(value)
            }
        }
    }
}
