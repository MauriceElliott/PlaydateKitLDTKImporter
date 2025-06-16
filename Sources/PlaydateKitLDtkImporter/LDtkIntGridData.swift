//
//  LDtkIntGridData.swift
//  PlaydateKitLDtkImporter
//
//  Created by PlaydateKit LDtk Importer
//

/// Represents IntGrid layer data from LDtk Super Simple Export
/// Provides access to grid-based collision/logic data from CSV files
public class LDtkIntGridData {

    // MARK: - Properties

    /// Layer identifier/name (C string buffer)
    private var identifierBuffer:
        (
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8
        )

    /// Grid width in cells
    public let width: UInt32

    /// Grid height in cells
    public let height: UInt32

    /// Size of each grid cell in pixels
    public let cellSize: UInt32

    /// Raw grid data pointer (managed externally)
    private let gridDataPtr: UnsafePointer<Int32>?

    /// Whether the data has been loaded
    private var isDataLoaded: Bool

    /// Memory usage of this IntGrid data
    private var memoryUsage: UInt32

    // MARK: - Initialization

    public init() {
        self.identifierBuffer = (
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        )
        self.width = 0
        self.height = 0
        self.cellSize = 0
        self.gridDataPtr = nil
        self.isDataLoaded = false
        self.memoryUsage = 0
    }

    public init(
        identifier: UnsafePointer<CChar>,
        width: UInt32,
        height: UInt32,
        cellSize: UInt32,
        gridDataPtr: UnsafePointer<Int32>?
    ) {
        // Copy identifier string to buffer
        var buffer = (
            UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
            UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
            UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
            UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0)
        )

        // Copy up to 31 characters (leave room for null terminator)
        var i = 0
        while i < 31 && identifier[i] != 0 {
            withUnsafeMutablePointer(to: &buffer) { ptr in
                let bytes = ptr.withMemoryRebound(to: UInt8.self, capacity: 32) { $0 }
                bytes[i] = UInt8(identifier[i])
            }
            i += 1
        }

        self.identifierBuffer = buffer
        self.width = width
        self.height = height
        self.cellSize = cellSize
        self.gridDataPtr = gridDataPtr
        self.isDataLoaded = gridDataPtr != nil
        self.memoryUsage = UInt32(MemoryLayout<LDtkIntGridData>.size)
    }

    // MARK: - Public API

    /// Get pointer to the identifier C string
    public func getIdentifierPtr() -> UnsafePointer<CChar> {
        return withUnsafePointer(to: identifierBuffer) { ptr in
            ptr.withMemoryRebound(to: CChar.self, capacity: 32) { $0 }
        }
    }

    /// Get IntGrid value at specific grid coordinates
    /// - Parameters:
    ///   - x: X coordinate in grid cells
    ///   - y: Y coordinate in grid cells
    /// - Returns: IntGrid value (0 for empty, positive integers for values)
    public func getValue(x: UInt32, y: UInt32) -> Int32 {
        // Stub implementation
        return 0
    }

    /// Get IntGrid value at pixel coordinates
    /// - Parameters:
    ///   - pixelX: X coordinate in pixels
    ///   - pixelY: Y coordinate in pixels
    /// - Returns: IntGrid value at that pixel location
    public func getValueAtPixel(x pixelX: Int32, y pixelY: Int32) -> Int32 {
        // Stub implementation
        return 0
    }

    /// Check if a grid cell is empty (value == 0)
    /// - Parameters:
    ///   - x: X coordinate in grid cells
    ///   - y: Y coordinate in grid cells
    /// - Returns: True if cell is empty, false otherwise
    public func isEmpty(x: UInt32, y: UInt32) -> Bool {
        // Stub implementation
        return true
    }

    /// Check if a pixel location is empty
    /// - Parameters:
    ///   - pixelX: X coordinate in pixels
    ///   - pixelY: Y coordinate in pixels
    /// - Returns: True if location is empty, false otherwise
    public func isEmptyAtPixel(x pixelX: Int32, y pixelY: Int32) -> Bool {
        // Stub implementation
        return true
    }

    /// Get all grid positions that have a specific value
    /// - Parameters:
    ///   - value: IntGrid value to search for
    ///   - buffer: Buffer to store matching positions
    ///   - maxCount: Maximum number of positions to return
    /// - Returns: Number of positions found
    public func getPositions(
        withValue value: Int32,
        into buffer: UnsafeMutablePointer<Point>,
        maxCount: Int
    ) -> Int {
        // Stub implementation
        return 0
    }

    /// Check if a rectangular region contains any non-empty cells
    /// - Parameters:
    ///   - x: Starting X coordinate
    ///   - y: Starting Y coordinate
    ///   - width: Width of region in cells
    ///   - height: Height of region in cells
    /// - Returns: True if region contains any non-zero values
    public func hasValuesInRegion(x: UInt32, y: UInt32, width: UInt32, height: UInt32) -> Bool {
        // Stub implementation
        return false
    }

    /// Convert grid coordinates to pixel coordinates
    /// - Parameters:
    ///   - gridX: X coordinate in grid cells
    ///   - gridY: Y coordinate in grid cells
    /// - Returns: Pixel coordinates of the cell's top-left corner
    public func gridToPixel(gridX: UInt32, gridY: UInt32) -> Point {
        // Stub implementation
        return Point(x: 0, y: 0)
    }

    /// Convert pixel coordinates to grid coordinates
    /// - Parameters:
    ///   - pixelX: X coordinate in pixels
    ///   - pixelY: Y coordinate in pixels
    /// - Returns: Grid coordinates containing that pixel
    public func pixelToGrid(pixelX: Int32, pixelY: Int32) -> Point {
        // Stub implementation
        return Point(x: 0, y: 0)
    }

    /// Get the pixel bounds of a grid cell
    /// - Parameters:
    ///   - gridX: X coordinate in grid cells
    ///   - gridY: Y coordinate in grid cells
    /// - Returns: Rectangle representing the pixel bounds of the cell
    public func getCellBounds(gridX: UInt32, gridY: UInt32) -> Rectangle {
        // Stub implementation
        return Rectangle(x: 0, y: 0, width: 0, height: 0)
    }

    /// Check if the data is currently loaded in memory
    /// - Returns: True if data is loaded, false otherwise
    public var isLoaded: Bool {
        return isDataLoaded
    }

    /// Clear cached data to free memory
    public func clearCache() {
        // Stub implementation - in real version would clear data
        self.isDataLoaded = false
    }

    /// Get estimated memory usage of the grid data
    /// - Returns: Estimated memory usage in bytes
    public func getMemoryUsage() -> UInt32 {
        return memoryUsage
    }

    /// Validate that coordinates are within grid bounds
    /// - Parameters:
    ///   - x: X coordinate to validate
    ///   - y: Y coordinate to validate
    /// - Returns: True if coordinates are valid, false otherwise
    public func isValidCoordinate(x: UInt32, y: UInt32) -> Bool {
        return x < width && y < height
    }
}

/// Helper structure representing a grid position with its value
public struct LDtkGridCell {
    /// Grid X coordinate
    public let x: UInt32

    /// Grid Y coordinate
    public let y: UInt32

    /// IntGrid value at this position
    public let value: Int32

    public init(x: UInt32, y: UInt32, value: Int32) {
        self.x = x
        self.y = y
        self.value = value
    }

    /// Get pixel coordinates of this cell
    public func pixelPosition(cellSize: UInt32) -> Point {
        return Point(x: Int32(x * cellSize), y: Int32(y * cellSize))
    }
}

// MARK: - C API

@_cdecl("ldtk_intgrid_get_identifier")
public func ldtk_intgrid_get_identifier(_ intGrid: UnsafePointer<LDtkIntGridData>) -> UnsafePointer<
    CChar
> {
    // Stub implementation
    return intGrid.pointee.getIdentifierPtr()
}

@_cdecl("ldtk_intgrid_get_dimensions")
public func ldtk_intgrid_get_dimensions(
    _ intGrid: UnsafePointer<LDtkIntGridData>, _ width: UnsafeMutablePointer<UInt32>,
    _ height: UnsafeMutablePointer<UInt32>
) {
    // Stub implementation
    width.pointee = 0
    height.pointee = 0
}

@_cdecl("ldtk_intgrid_get_cell_size")
public func ldtk_intgrid_get_cell_size(_ intGrid: UnsafePointer<LDtkIntGridData>) -> UInt32 {
    // Stub implementation
    return 0
}

@_cdecl("ldtk_intgrid_get_value")
public func ldtk_intgrid_get_value(
    _ intGrid: UnsafePointer<LDtkIntGridData>, _ x: UInt32, _ y: UInt32
) -> Int32 {
    // Stub implementation
    return 0
}

@_cdecl("ldtk_intgrid_get_value_at_pixel")
public func ldtk_intgrid_get_value_at_pixel(
    _ intGrid: UnsafePointer<LDtkIntGridData>, _ pixelX: Int32, _ pixelY: Int32
) -> Int32 {
    // Stub implementation
    return 0
}

@_cdecl("ldtk_intgrid_is_empty")
public func ldtk_intgrid_is_empty(
    _ intGrid: UnsafePointer<LDtkIntGridData>, _ x: UInt32, _ y: UInt32
) -> UInt8 {
    // Stub implementation
    return 1
}

@_cdecl("ldtk_intgrid_is_loaded")
public func ldtk_intgrid_is_loaded(_ intGrid: UnsafePointer<LDtkIntGridData>) -> UInt8 {
    // Stub implementation
    return 0
}

@_cdecl("ldtk_intgrid_get_memory_usage")
public func ldtk_intgrid_get_memory_usage(_ intGrid: UnsafePointer<LDtkIntGridData>) -> UInt32 {
    // Stub implementation
    return 0
}

@_cdecl("ldtk_intgrid_clear_cache")
public func ldtk_intgrid_clear_cache(_ intGrid: UnsafeMutablePointer<LDtkIntGridData>) {
    // Stub implementation
}
