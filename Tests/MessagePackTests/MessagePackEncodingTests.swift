import XCTest
@testable import MessagePack

class MessagePackEncodingTests: XCTestCase {
    var encoder: MessagePackEncoder!
    
    override func setUp() {
        self.encoder = MessagePackEncoder()
    }
    
    func testEncodeFalse() {
        let value = try! encoder.encode(false)
        XCTAssertEqual(value, Data(bytes: [0xc2]))
    }
    
    func testEncodeTrue() {
        let value = try! encoder.encode(true)
        XCTAssertEqual(value, Data(bytes: [0xc3]))
    }
    
    func testEncodeInt() {
        let value = try! encoder.encode(42)
        XCTAssertEqual(value, Data(bytes: [0x2A]))
    }
    
    func testEncodeDouble() {
        let value = try! encoder.encode(3.14159)
        XCTAssertEqual(value, Data(bytes: [0xCB, 0x40, 0x09, 0x21, 0xF9, 0xF0, 0x1B, 0x86, 0x6E]))
    }
    
    func testEncodeArray() {
        let value = try! encoder.encode([1, 2, 3])
        XCTAssertEqual(value, Data(bytes: [0x93, 0x01, 0x02, 0x03]))
    }
    
    func testEncodeDictionary() {
        let value = try! encoder.encode(["a": 1, "b": 2, "c": 3])
        XCTAssertEqual(value, Data(bytes: [0x83, 0xA1, 0x62, 0x02, 0xA1, 0x61, 0x01, 0xA1, 0x63, 0x03]))
    }
    
//    func testEncodeStructure() {
//        let airport = Airport(name: "Portland International Airport", iata: "PDX", icao: "KPDX", coordinates: [-122.5975, 45.5886111111111], runways: [Airport.Runway(direction: "3/21", distance: 1829, surface: .flexible)])
//        let value = try! encoder.encode(airport)
//        XCTAssertEqual(value, Data(bytes: [0x85, 0xA4, 0x6E, 0x61, 0x6D, 0x65, 0xBE, 0x50, 0x6F, 0x72, 0x74, 0x6C, 0x61, 0x6E, 0x64, 0x20, 0x49, 0x6E, 0x74, 0x65, 0x72, 0x6E, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x61, 0x6C, 0x20, 0x41, 0x69, 0x72, 0x70, 0x6F, 0x72, 0x74, 0xA4, 0x69, 0x61, 0x74, 0x61, 0xA3, 0x50, 0x44, 0x58, 0xA4, 0x69, 0x63, 0x61, 0x6F, 0xA4, 0x4B, 0x50, 0x44, 0x58, 0xAB, 0x63, 0x6F, 0x6F, 0x72, 0x64, 0x69, 0x6E, 0x61, 0x74, 0x65, 0x73, 0x92, 0xCB, 0xC0, 0x5E, 0xA6, 0x3D, 0x70, 0xA3, 0xD7, 0x0A, 0xCB, 0x40, 0x46, 0xCB, 0x57, 0x9B, 0xE0, 0x24, 0x67, 0xA7, 0x72, 0x75, 0x6E, 0x77, 0x61, 0x79, 0x73, 0x91, 0x83, 0xA8, 0x64, 0x69, 0x73, 0x74, 0x61, 0x6E, 0x63, 0x65, 0xCD, 0x07, 0x25, 0xA9, 0x64, 0x69, 0x72, 0x65, 0x63, 0x74, 0x69, 0x6F, 0x6E, 0xA4, 0x33, 0x2F, 0x32, 0x31, 0xA7, 0x73, 0x75, 0x72, 0x66, 0x61, 0x63, 0x65, 0xA8, 0x66, 0x6C, 0x65, 0x78, 0x69, 0x62, 0x6C, 0x65]))
//    }

    static var allTests = [
        ("testEncodeFalse", testEncodeFalse),
        ("testEncodeTrue", testEncodeTrue),
        ("testEncodeInt", testEncodeInt),
        ("testEncodeDouble", testEncodeDouble),
        ("testEncodeArray", testEncodeArray),
        ("testEncodeDictionary", testEncodeDictionary)
    ]
}