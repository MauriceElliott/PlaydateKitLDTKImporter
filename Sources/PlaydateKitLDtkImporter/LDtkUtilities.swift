//
//  LDtkUtilities.swift
//  PlaydateKitLDtkImporter
//
//  Created by PlaydateKit LDtk Importer
//

// MARK: - Core Types

/// Basic geometric types for LDtk data
public struct Point {
    public let x: Int32
    public let y: Int32

    public init(x: Int32, y: Int32) {
        self.x = x
        self.y = y
    }

    public init(x: Int, y: Int) {
        self.x = Int32(x)
        self.y = Int32(y)
    }
}

public struct Size {
    public let width: UInt32
    public let height: UInt32

    public init(width: UInt32, height: UInt32) {
        self.width = width
        self.height = height
    }

    public init(width: Int, height: Int) {
        self.width = UInt32(width)
        self.height = UInt32(height)
    }
}

public struct Rectangle {
    public let x: Int32
    public let y: Int32
    public let width: UInt32
    public let height: UInt32

    public init(x: Int32, y: Int32, width: UInt32, height: UInt32) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    public init(x: Int, y: Int, width: Int, height: Int) {
        self.x = Int32(x)
        self.y = Int32(y)
        self.width = UInt32(width)
        self.height = UInt32(height)
    }
}

/// Represents image data for PlaydateKit compatibility
public struct ImageData {
    public let width: UInt32
    public let height: UInt32
    public let dataPtr: UnsafePointer<UInt8>
    public let dataSize: UInt32

    public init(width: UInt32, height: UInt32, dataPtr: UnsafePointer<UInt8>, dataSize: UInt32) {
        self.width = width
        self.height = height
        self.dataPtr = dataPtr
        self.dataSize = dataSize
    }
}

// MARK: - Error Types

/// Simple error codes for LDtk import operations
public enum LDtkErrorCode: UInt8 {
    case none = 0
    case fileNotFound = 1
    case invalidExportStructure = 2
    case csvParsingError = 3
    case jsonParsingError = 4
    case imageLoadingError = 5
    case invalidGridDimensions = 6
    case memoryError = 7
    case invalidPath = 8
}

/// Result type for operations that can fail
public struct LDtkResult<T> {
    public let value: T?
    public let errorCode: LDtkErrorCode

    public init(value: T) {
        self.value = value
        self.errorCode = .none
    }

    public init(error: LDtkErrorCode) {
        self.value = nil
        self.errorCode = error
    }

    public var isSuccess: Bool {
        return errorCode == .none
    }

    public var isError: Bool {
        return errorCode != .none
    }
}

// MARK: - String Utilities

/// Fixed-size string for Embedded Swift compatibility
public struct LDtkString {
    private var buffer:
        (
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8
        )
    private var length: UInt8

    public static let maxLength: Int = 64

    public init() {
        self.buffer = (
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        )
        self.length = 0
    }

    public var count: Int {
        return Int(length)
    }

    public var isEmpty: Bool {
        return length == 0
    }
}

// MARK: - Memory Management

/// Fixed-size array for Embedded Swift compatibility
public struct LDtkFixedArray<T> {
    private var storage:
        (
            T?, T?, T?, T?, T?, T?, T?, T?,
            T?, T?, T?, T?, T?, T?, T?, T?,
            T?, T?, T?, T?, T?, T?, T?, T?,
            T?, T?, T?, T?, T?, T?, T?, T?
        )
    private var count: UInt8

    public static var maxCount: Int { return 32 }

    public init() {
        self.storage = (
            nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil, nil
        )
        self.count = 0
    }

    public var elementCount: Int {
        return Int(count)
    }

    public func get(at index: Int) -> T? {
        // Stub implementation
        return nil
    }

    public mutating func set(at index: Int, value: T) -> Bool {
        // Stub implementation
        return false
    }

    public mutating func append(_ value: T) -> Bool {
        // Stub implementation
        return false
    }

    public mutating func clear() {
        self.count = 0
    }
}

// MARK: - Basic Field Types

/// Simple field value type for entity data
public struct LDtkFieldValue {
    public let type: UInt8  // 0=int, 1=bool, 2=string
    public let intValue: Int32
    public let boolValue: Bool
    public let stringValue: LDtkString

    public init(intValue: Int32) {
        self.type = 0
        self.intValue = intValue
        self.boolValue = false
        self.stringValue = LDtkString()
    }

    public init(boolValue: Bool) {
        self.type = 1
        self.intValue = 0
        self.boolValue = boolValue
        self.stringValue = LDtkString()
    }

    public init(stringValue: LDtkString) {
        self.type = 2
        self.intValue = 0
        self.boolValue = false
        self.stringValue = stringValue
    }

    public var asInt: Int32? {
        return type == 0 ? intValue : nil
    }

    public var asBool: Bool? {
        return type == 1 ? boolValue : nil
    }

    public var asString: LDtkString? {
        return type == 2 ? stringValue : nil
    }
}

/// Simple key-value pair for entity fields
public struct LDtkFieldPair {
    public let key: LDtkString
    public let value: LDtkFieldValue

    public init(key: LDtkString, value: LDtkFieldValue) {
        self.key = key
        self.value = value
    }
}

/// Fixed-size collection of entity fields
public typealias LDtkFieldCollection = LDtkFixedArray<LDtkFieldPair>

// MARK: - Coordinate Utilities

/// Utility functions for coordinate conversions
public struct LDtkCoordinateUtils {
    /// Convert pixel coordinates to grid coordinates
    public static func pixelToGrid(pixelX: Int32, pixelY: Int32, cellSize: UInt32) -> Point {
        // Stub implementation
        return Point(x: 0, y: 0)
    }

    /// Convert grid coordinates to pixel coordinates
    public static func gridToPixel(gridX: Int32, gridY: Int32, cellSize: UInt32) -> Point {
        // Stub implementation
        return Point(x: 0, y: 0)
    }

    /// Calculate distance between two points (squared to avoid floating point)
    public static func distanceSquared(from point1: Point, to point2: Point) -> UInt64 {
        // Stub implementation
        return 0
    }

    /// Check if a point is inside a rectangle
    public static func pointInRect(_ point: Point, _ rect: Rectangle) -> Bool {
        // Stub implementation
        return false
    }
}

// MARK: - Project Info

/// Contains basic information about a Super Simple Export project
public struct LDtkProjectInfo {
    /// Name of the project (derived from folder name)
    public let projectName: LDtkString

    /// List of discovered level identifiers
    public let levels: LDtkFixedArray<LDtkString>

    /// Number of levels in the project
    public let levelCount: UInt8

    public init(projectName: LDtkString, levels: LDtkFixedArray<LDtkString>, levelCount: UInt8) {
        self.projectName = projectName
        self.levels = levels
        self.levelCount = levelCount
    }
}

// MARK: - Memory Statistics

/// Memory usage statistics
public struct LDtkMemoryStats {
    public let totalBytes: UInt32
    public let imagesBytes: UInt32
    public let gridDataBytes: UInt32
    public let entitiesBytes: UInt32

    public init(
        totalBytes: UInt32, imagesBytes: UInt32, gridDataBytes: UInt32, entitiesBytes: UInt32
    ) {
        self.totalBytes = totalBytes
        self.imagesBytes = imagesBytes
        self.gridDataBytes = gridDataBytes
        self.entitiesBytes = entitiesBytes
    }
}
