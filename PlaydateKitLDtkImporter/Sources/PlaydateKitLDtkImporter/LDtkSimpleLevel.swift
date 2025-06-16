//
//  LDtkSimpleLevel.swift
//  PlaydateKitLDtkImporter
//
//  Created by PlaydateKit LDtk Importer
//

/// Represents a loaded level from LDtk Super Simple Export
/// Contains the composite image, individual layers, entities, and IntGrid data
public struct LDtkSimpleLevel {

    // MARK: - Properties

    /// Unique identifier for this level (C string buffer)
    private var identifierBuffer:
        (
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8
        )

    /// Level dimensions in pixels
    public let size: Size

    /// World position of this level (for multi-level worlds)
    public let worldPosition: Point

    /// Background color of the level (RGB packed as UInt32)
    public let backgroundColor: UInt32

    /// The composite image representing the entire level (all layers merged)
    private var compositeImage: ImageData?

    /// Individual layer images
    private var layerImages: LDtkFixedArray<LDtkSimpleLayer>

    /// Array of all entities found in this level
    private var entities: LDtkFixedArray<LDtkSimpleEntity>

    /// IntGrid data by layer
    private var intGridData: LDtkFixedArray<LDtkIntGridData>

    /// Custom field values defined in LDtk for this level
    private var customFields: LDtkFieldCollection

    /// Whether level data has been fully loaded from disk
    private var isFullyLoaded: Bool

    /// Memory usage tracking
    private var memoryUsage: UInt32

    // MARK: - Initialization

    public init() {
        self.identifierBuffer = (
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        )
        self.size = Size(width: 0, height: 0)
        self.worldPosition = Point(x: 0, y: 0)
        self.backgroundColor = 0
        self.compositeImage = nil
        self.layerImages = LDtkFixedArray<LDtkSimpleLayer>()
        self.entities = LDtkFixedArray<LDtkSimpleEntity>()
        self.intGridData = LDtkFixedArray<LDtkIntGridData>()
        self.customFields = LDtkFieldCollection()
        self.isFullyLoaded = false
        self.memoryUsage = 0
    }

    public init(
        identifier: UnsafePointer<CChar>,
        size: Size,
        worldPosition: Point,
        backgroundColor: UInt32
    ) {
        // Stub: copy identifier to buffer (implementation omitted for brevity)
        self.identifierBuffer = (
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        )
        self.size = size
        self.worldPosition = worldPosition
        self.backgroundColor = backgroundColor
        self.compositeImage = nil
        self.layerImages = LDtkFixedArray<LDtkSimpleLayer>()
        self.entities = LDtkFixedArray<LDtkSimpleEntity>()
        self.intGridData = LDtkFixedArray<LDtkIntGridData>()
        self.customFields = LDtkFieldCollection()
        self.isFullyLoaded = false
        self.memoryUsage = 0
    }

    // MARK: - Public API

    /// Get pointer to the level identifier C string
    public func getIdentifierPtr() -> UnsafePointer<CChar> {
        return withUnsafePointer(to: identifierBuffer) { ptr in
            ptr.withMemoryRebound(to: CChar.self, capacity: 32) { $0 }
        }
    }

    /// Get the composite image for this level
    public func getCompositeImage() -> ImageData? {
        // Stub implementation
        return compositeImage
    }

    /// Set the composite image
    public mutating func setCompositeImage(_ image: ImageData) -> Bool {
        // Stub implementation
        return false
    }

    /// Get a specific layer by index
    public func getLayer(at index: Int) -> LDtkSimpleLayer? {
        // Stub implementation
        return nil
    }

    /// Get number of available layers
    public var layerCount: Int {
        // Stub implementation
        return 0
    }

    /// Add a layer to the level
    public mutating func addLayer(_ layer: LDtkSimpleLayer) -> Bool {
        // Stub implementation
        return false
    }

    /// Get entities of a specific type by type ID
    public func getEntities(
        ofType entityTypeId: UInt16,
        into buffer: UnsafeMutablePointer<LDtkSimpleEntity>,
        maxCount: Int
    ) -> Int {
        // Stub implementation
        return 0
    }

    /// Get all entities in this level
    public func getAllEntities(
        into buffer: UnsafeMutablePointer<LDtkSimpleEntity>,
        maxCount: Int
    ) -> Int {
        // Stub implementation
        return 0
    }

    /// Get entities at a specific position
    public func getEntities(
        at position: Point,
        into buffer: UnsafeMutablePointer<LDtkSimpleEntity>,
        maxCount: Int
    ) -> Int {
        // Stub implementation
        return 0
    }

    /// Add an entity to the level
    public mutating func addEntity(_ entity: LDtkSimpleEntity) -> Bool {
        // Stub implementation
        return false
    }

    /// Get IntGrid data by index
    public func getIntGridData(at index: Int) -> LDtkIntGridData? {
        // Stub implementation
        return nil
    }

    /// Get number of IntGrid layers
    public var intGridLayerCount: Int {
        // Stub implementation
        return 0
    }

    /// Add IntGrid data to the level
    public mutating func addIntGridData(_ intGrid: LDtkIntGridData) -> Bool {
        // Stub implementation
        return false
    }

    /// Get a custom field value by field name
    public func getCustomField(
        _ fieldName: UnsafePointer<CChar>,
        into outValue: UnsafeMutablePointer<LDtkFieldValue>
    ) -> Bool {
        // Stub implementation
        return false
    }

    /// Add a custom field to the level
    public mutating func addCustomField(_ field: LDtkFieldPair) -> Bool {
        // Stub implementation
        return false
    }

    /// Clear all cached data to free memory
    public mutating func clearCache() {
        // Stub implementation
        self.isFullyLoaded = false
        self.memoryUsage = 0
    }

    /// Get memory usage estimate for this level
    public func getMemoryUsage() -> UInt32 {
        // Stub implementation
        return memoryUsage
    }

    /// Get detailed memory usage breakdown
    public func getMemoryBreakdown() -> LDtkMemoryStats {
        // Stub implementation
        return LDtkMemoryStats(totalBytes: 0, imagesBytes: 0, gridDataBytes: 0, entitiesBytes: 0)
    }

    /// Check if this level has been fully loaded from disk
    public var isLoaded: Bool {
        // Stub implementation
        return isFullyLoaded
    }

    /// Mark the level as fully loaded
    public mutating func markAsFullyLoaded() {
        // Stub implementation
        self.isFullyLoaded = true
    }
}

// MARK: - C API (Stub implementations)

// Note: C API functions removed for Embedded Swift compatibility
// These would need to be implemented using a different approach
// that doesn't rely on @_cdecl attribute
