//
//  LDtkSimpleEntity.swift
//  PlaydateKitLDtkImporter
//
//  Created by PlaydateKit LDtk Importer
//

import Foundation

/// Represents an entity instance from LDtk Super Simple Export
/// Contains entity position, size, type, and custom field data
public class LDtkSimpleEntity {

    // MARK: - Properties

    /// Entity type identifier from LDtk
    // public let identifier: String

    /// Unique instance ID for this entity
    // public let iid: String

    /// Position of the entity within the level (in pixels)
    // public let position: Point

    /// Size/dimensions of the entity
    // public let size: Size

    /// Pivot point for the entity (0.0 to 1.0 normalized coordinates)
    // public let pivot: Point

    /// Tags assigned to this entity in LDtk
    // public let tags: [String]

    /// Smart color assigned to this entity type in LDtk
    // public let smartColor: String

    /// Custom field values defined for this entity instance
    // public private(set) var fields: [String: Any]

    /// Tile information if entity has an associated tile/sprite
    // public let tileInfo: LDtkEntityTileInfo?

    /// Z-index/depth for rendering order
    // public let zIndex: Int

    // MARK: - Initialization

    /// Initialize an entity with data from the level's JSON
    /// - Parameters:
    ///   - entityData: Raw entity data from JSON parsing
    ///   - levelOffset: Level's world position offset
    public init(entityData: [String: Any], levelOffset: Point = Point(x: 0, y: 0)) {
        // Parse entity identifier, position, size from entityData
        // Extract custom field values
        // Calculate world position if needed
        // Parse tile information if present
    }

    // MARK: - Public API

    /// Get a custom field value with type safety
    /// - Parameters:
    ///   - fieldName: Name of the custom field
    ///   - type: Expected type of the field value
    /// - Returns: Typed field value or nil if not found/wrong type
    public func getField<T>(_ fieldName: String, as type: T.Type) -> T? {
        // Look up field in fields dictionary
        // Cast to requested type and return
        return nil
    }

    /// Get a string field value
    /// - Parameter fieldName: Name of the field
    /// - Returns: String value or nil if not found/wrong type
    public func getStringField(_ fieldName: String) -> String? {
        // Get field value as String type
        return getField(fieldName, as: String.self)
    }

    /// Get an integer field value
    /// - Parameter fieldName: Name of the field
    /// - Returns: Integer value or nil if not found/wrong type
    public func getIntField(_ fieldName: String) -> Int? {
        // Get field value as Int type
        return getField(fieldName, as: Int.self)
    }

    /// Get a boolean field value
    /// - Parameter fieldName: Name of the field
    /// - Returns: Boolean value or nil if not found/wrong type
    public func getBoolField(_ fieldName: String) -> Bool? {
        // Get field value as Bool type
        return getField(fieldName, as: Bool.self)
    }

    /// Get a double/float field value
    /// - Parameter fieldName: Name of the field
    /// - Returns: Double value or nil if not found/wrong type
    public func getDoubleField(_ fieldName: String) -> Double? {
        // Get field value as Double type
        return getField(fieldName, as: Double.self)
    }

    /// Get an array field value
    /// - Parameter fieldName: Name of the field
    /// - Returns: Array value or nil if not found/wrong type
    public func getArrayField(_ fieldName: String) -> [Any]? {
        // Get field value as Array type
        return getField(fieldName, as: Array<Any>.self)
    }

    /// Check if the entity has a specific tag
    /// - Parameter tag: Tag to check for
    /// - Returns: True if entity has the tag, false otherwise
    public func hasTag(_ tag: String) -> Bool {
        // Check if tag exists in tags array
        return false
    }

    /// Get the center point of the entity
    /// Calculated from position, size, and pivot
    /// - Returns: Center point in level coordinates
    public func getCenterPosition() -> Point {
        // Calculate center based on position, size, and pivot
        // Return center point coordinates
        return Point(x: 0, y: 0)
    }

    /// Get the bounding rectangle of the entity
    /// - Returns: Rectangle representing entity bounds
    public func getBounds() -> Rectangle {
        // Calculate bounds from position and size
        // Account for pivot point
        return Rectangle(x: 0, y: 0, width: 0, height: 0)
    }

    // MARK: - Advanced Features

    /// Check if this entity overlaps with another entity
    /// - Parameter otherEntity: Entity to check overlap with
    /// - Returns: True if entities overlap, false otherwise
    public func overlaps(with otherEntity: LDtkSimpleEntity) -> Bool {
        // Compare bounding rectangles of both entities
        // Return true if they intersect
        return false
    }

    /// Check if this entity contains a specific point
    /// - Parameter point: Point to check
    /// - Returns: True if point is inside entity bounds, false otherwise
    public func contains(point: Point) -> Bool {
        // Check if point falls within entity's bounding rectangle
        return false
    }

    /// Get distance to another entity
    /// - Parameter otherEntity: Entity to measure distance to
    /// - Returns: Distance between entity centers
    public func distance(to otherEntity: LDtkSimpleEntity) -> Double {
        // Calculate distance between center points
        return 0.0
    }

    /// Get all field names available for this entity
    /// - Returns: Array of field names
    public var availableFieldNames: [String] {
        // Return keys from fields dictionary
        return []
    }

    /// Check if a field exists
    /// - Parameter fieldName: Name of the field to check
    /// - Returns: True if field exists, false otherwise
    public func hasField(_ fieldName: String) -> Bool {
        // Check if field name exists in fields dictionary
        return false
    }

    /// Get the entity's world position
    /// Accounts for level offset in multi-level worlds
    /// - Parameter levelWorldPosition: World position of the containing level
    /// - Returns: Entity position in world coordinates
    public func getWorldPosition(levelWorldPosition: Point) -> Point {
        // Add entity position to level world position
        return Point(x: 0, y: 0)
    }

    // MARK: - Debugging

    /// Get a string representation of the entity for debugging
    /// - Returns: Human-readable entity description
    public func debugDescription() -> String {
        // Create descriptive string with entity type, position, and key fields
        return "LDtkSimpleEntity(identifier: \(identifier), position: \(position))"
    }
}

/// Information about an entity's associated tile/sprite
public struct LDtkEntityTileInfo {
    /// Tileset identifier
    // let tilesetId: String

    /// Source rectangle in the tileset
    // let sourceRect: Rectangle

    /// Whether the tile is flipped horizontally
    // let flipX: Bool

    /// Whether the tile is flipped vertically
    // let flipY: Bool
}
