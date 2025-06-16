//
//  PlaydateKitLDtkImporterTests.swift
//  PlaydateKitLDtkImporter
//
//  Created by PlaydateKit LDtk Importer
//

// Note: Testing framework not available in Embedded Swift
// This file contains stub test functions for compatibility

@testable import PlaydateKitLDtkImporter

/// Simple test function stub for Embedded Swift compatibility
public func runBasicTests() -> Bool {
    // Test basic struct initialization
    let importer = LDtkSimpleImporter()
    let level = LDtkSimpleLevel()
    let layer = LDtkSimpleLayer()
    let entity = LDtkSimpleEntity()
    let intGrid = LDtkIntGridData()

    // Test basic functionality (all should return default/stub values)
    let hasLevel = importer.hasLevel("test".utf8CString.withUnsafeBufferPointer { $0.baseAddress! })
    let layerCount = level.layerCount
    let isVisible = layer.visible
    let entityTypeId = entity.typeId
    let gridWidth = intGrid.width

    // Basic validation that types work
    return !hasLevel && layerCount == 0 && entityTypeId == 0 && gridWidth == 0
}

/// Test memory management stubs
public func runMemoryTests() -> Bool {
    let importer = LDtkSimpleImporter()
    let stats = importer.getMemoryStats()

    // All memory should be 0 in stub implementation
    return stats.totalBytes == 0 && stats.imagesBytes == 0 && stats.gridDataBytes == 0
        && stats.entitiesBytes == 0
}

/// Test coordinate utilities
public func runCoordinateTests() -> Bool {
    let point1 = Point(x: 10, y: 20)
    let point2 = Point(x: 30, y: 40)
    let rect = Rectangle(x: 0, y: 0, width: 100, height: 100)

    // Test basic coordinate operations (stub implementations)
    let distance = LDtkCoordinateUtils.distanceSquared(from: point1, to: point2)
    let inRect = LDtkCoordinateUtils.pointInRect(point1, rect)
    let gridPos = LDtkCoordinateUtils.pixelToGrid(pixelX: 32, pixelY: 48, cellSize: 16)

    // All should return default values in stub implementation
    return distance == 0 && !inRect && gridPos.x == 0 && gridPos.y == 0
}

/// Test error handling
public func runErrorTests() -> Bool {
    let result1 = LDtkResult<Bool>(error: .fileNotFound)
    let result2 = LDtkResult<Bool>(value: true)

    return result1.isError && !result1.isSuccess && result2.isSuccess && !result2.isError
}

/// Run all test suites
public func runAllTests() -> Bool {
    return runBasicTests() && runMemoryTests() && runCoordinateTests() && runErrorTests()
}
