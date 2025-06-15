//
//  LDtkUtilities.swift
//  PlaydateKitLDtkImporter
//
//  Created by PlaydateKit LDtk Importer
//

import Foundation

// MARK: - Core Types

/// Basic geometric types for LDtk data
public struct Point {
    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    public init(x: Int, y: Int) {
        self.x = Double(x)
        self.y = Double(y)
    }
}

public struct Size {
    public let width: Int
    public let height: Int

    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

public struct Rectangle {
    public let x: Int
    public let y: Int
    public let width: Int
    public let height: Int

    public init(x: Int, y: Int, width: Int, height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

/// Represents image data for PlaydateKit compatibility
public protocol ImageData {
    // var width: Int { get }
    // var height: Int { get }
    // var data: Data { get }
}

// MARK: - Error Types

/// Errors that can occur during LDtk import operations
public enum LDtkError: Error, LocalizedError {
    case fileNotFound(String)
    case invalidExportStructure(String)
    case csvParsingError(String)
    case jsonParsingError(String)
    case imageLoadingError(String)
    case invalidGridDimensions(String)

    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let path):
            return "File not found: \(path)"
        case .invalidExportStructure(let message):
            return "Invalid export structure: \(message)"
        case .csvParsingError(let message):
            return "CSV parsing error: \(message)"
        case .jsonParsingError(let message):
            return "JSON parsing error: \(message)"
        case .imageLoadingError(let message):
            return "Image loading error: \(message)"
        case .invalidGridDimensions(let message):
            return "Invalid grid dimensions: \(message)"
        }
    }
}

// MARK: - File Manager

/// Handles file system operations for Super Simple Export structure
public class LDtkFileManager {

    /// Discover all level folders in a Super Simple Export directory
    /// - Parameter projectPath: Path to the exported project folder
    /// - Returns: Array of level folder names
    /// - Throws: LDtkError if path is invalid or inaccessible
    public static func discoverLevels(in projectPath: String) throws -> [String] {
        // Check if project path exists and is directory
        // Scan for subdirectories that contain level files
        // Return sorted list of level folder names
        return []
    }

    /// Validate that a directory contains valid Super Simple Export structure
    /// - Parameter projectPath: Path to check
    /// - Returns: True if structure is valid, false otherwise
    public static func validateExportStructure(_ projectPath: String) -> Bool {
        // Check if path exists and is directory
        // Look for expected file patterns (level folders, etc.)
        // Return validation result
        return false
    }

    /// Get the contents of a level folder
    /// - Parameters:
    ///   - levelName: Name of the level
    ///   - projectPath: Path to the project folder
    /// - Returns: Dictionary mapping file types to file paths
    /// - Throws: LDtkError if level folder doesn't exist
    public static func getLevelFiles(levelName: String, in projectPath: String) throws -> [String:
        String]
    {
        // Build path to level folder
        // Scan for PNG files, JSON file, CSV files
        // Return dictionary with file type mappings
        return [:]
    }

    /// Check if a file exists at the given path
    /// - Parameter path: File path to check
    /// - Returns: True if file exists and is readable
    public static func fileExists(at path: String) -> Bool {
        // Check file existence using FileManager
        return FileManager.default.fileExists(atPath: path)
    }

    /// Get file modification date
    /// - Parameter path: File path
    /// - Returns: Modification date or nil if file doesn't exist
    public static func getModificationDate(for path: String) -> Date? {
        // Get file attributes and return modification date
        return nil
    }

    /// Get file size in bytes
    /// - Parameter path: File path
    /// - Returns: File size or 0 if file doesn't exist
    public static func getFileSize(for path: String) -> Int {
        // Get file attributes and return size
        return 0
    }
}

// MARK: - Image Loader

/// Manages loading and caching of PNG images
public class LDtkImageLoader {

    /// Shared instance for global image caching
    // public static let shared = LDtkImageLoader()

    /// Cache of loaded images by file path
    // private var imageCache: [String: ImageData]

    /// Maximum cache size in bytes
    // private let maxCacheSize: Int

    /// Current cache size in bytes
    // private var currentCacheSize: Int

    public init() {
        // Initialize cache and size limits
        // Set up memory pressure monitoring if available
    }

    /// Load a PNG image from file path
    /// - Parameter path: Path to PNG file
    /// - Returns: Loaded image data or nil if loading fails
    public func loadImage(from path: String) -> ImageData? {
        // Check cache first
        // If not cached, load from disk
        // Add to cache if successful
        // Return image data
        return nil
    }

    /// Preload multiple images for a level
    /// - Parameter imagePaths: Array of image file paths
    /// - Throws: LDtkError if any image fails to load
    public func preloadImages(_ imagePaths: [String]) throws {
        // Load each image and add to cache
        // Track total memory usage
        // Throw error if any loading fails
    }

    /// Clear specific image from cache
    /// - Parameter path: Path of image to remove from cache
    public func clearImage(at path: String) {
        // Remove image from cache
        // Update cache size tracking
    }

    /// Clear all cached images
    public func clearCache() {
        // Remove all images from cache
        // Reset size tracking
    }

    /// Get current cache usage statistics
    /// - Returns: Dictionary with cache stats
    public func getCacheStats() -> [String: Any] {
        // Return cache size, item count, hit rate, etc.
        return [:]
    }
}

// MARK: - CSV Parser

/// Parses IntGrid CSV files from Super Simple Export
public class LDtkCSVParser {

    /// Parse a CSV file into a 2D integer array
    /// - Parameter csvPath: Path to the CSV file
    /// - Returns: 2D array of integers [row][column]
    /// - Throws: LDtkError if file reading or parsing fails
    public static func parseCSV(from csvPath: String) throws -> [[Int]] {
        // Read CSV file contents
        // Split into rows and columns
        // Convert string values to integers
        // Return 2D array
        return []
    }

    /// Parse a CSV file directly into IntGrid data structure
    /// - Parameters:
    ///   - csvPath: Path to the CSV file
    ///   - identifier: Layer identifier
    ///   - cellSize: Size of each grid cell in pixels
    /// - Returns: Populated LDtkIntGridData object
    /// - Throws: LDtkError if parsing fails
    public static func parseToIntGrid(from csvPath: String, identifier: String, cellSize: Int)
        throws -> LDtkIntGridData
    {
        // Parse CSV to 2D array
        // Determine grid dimensions
        // Create and populate LDtkIntGridData object
        // Return configured IntGrid data
        fatalError("Not implemented")
    }

    /// Validate CSV format and dimensions
    /// - Parameter csvPath: Path to CSV file
    /// - Returns: Tuple with (width, height) or nil if invalid
    public static func validateCSV(_ csvPath: String) -> (width: Int, height: Int)? {
        // Read and parse CSV
        // Check that all rows have same column count
        // Return dimensions or nil if invalid
        return nil
    }
}

// MARK: - JSON Parser

/// Parses simplified level JSON files from Super Simple Export
public class LDtkJSONParser {

    /// Parse level data JSON file
    /// - Parameter jsonPath: Path to the data.json file
    /// - Returns: Dictionary containing level data
    /// - Throws: LDtkError if parsing fails
    public static func parseLevelData(from jsonPath: String) throws -> [String: Any] {
        // Read JSON file
        // Parse using JSONSerialization
        // Return dictionary with level data
        return [:]
    }

    /// Extract entity data from level JSON
    /// - Parameter levelData: Parsed level data dictionary
    /// - Returns: Array of entity dictionaries
    public static func extractEntities(from levelData: [String: Any]) -> [[String: Any]] {
        // Navigate to entities section in JSON
        // Extract entity instances
        // Return array of entity data
        return []
    }

    /// Extract custom field data from level JSON
    /// - Parameter levelData: Parsed level data dictionary
    /// - Returns: Dictionary of custom field values
    public static func extractCustomFields(from levelData: [String: Any]) -> [String: Any] {
        // Navigate to custom fields section
        // Extract field values
        // Return field dictionary
        return [:]
    }

    /// Extract layer information from level JSON
    /// - Parameter levelData: Parsed level data dictionary
    /// - Returns: Array of layer info dictionaries
    public static func extractLayerInfo(from levelData: [String: Any]) -> [[String: Any]] {
        // Navigate to layer instances
        // Extract layer metadata
        // Return array of layer info
        return []
    }
}

// MARK: - Project Info

/// Contains basic information about a Super Simple Export project
public struct LDtkProjectInfo {
    /// Name of the project (derived from folder name)
    // public let projectName: String

    /// Path to the export folder
    // public let exportPath: String

    /// List of discovered level identifiers
    // public let levels: [String]

    /// Export timestamp (if available)
    // public let exportDate: Date?

    /// Project metadata from JSON (if available)
    // public let metadata: [String: Any]

    public init(projectName: String, exportPath: String, levels: [String]) {
        // Initialize project info with discovered data
        // Set default values for optional properties
    }
}

// MARK: - Coordinate Utilities

/// Utility functions for coordinate conversions
public struct LDtkCoordinateUtils {

    /// Convert pixel coordinates to grid coordinates
    /// - Parameters:
    ///   - pixelX: X coordinate in pixels
    ///   - pixelY: Y coordinate in pixels
    ///   - cellSize: Size of grid cells in pixels
    /// - Returns: Grid coordinates as tuple
    public static func pixelToGrid(pixelX: Int, pixelY: Int, cellSize: Int) -> (x: Int, y: Int) {
        return (x: pixelX / cellSize, y: pixelY / cellSize)
    }

    /// Convert grid coordinates to pixel coordinates
    /// - Parameters:
    ///   - gridX: X coordinate in grid cells
    ///   - gridY: Y coordinate in grid cells
    ///   - cellSize: Size of grid cells in pixels
    /// - Returns: Pixel coordinates as tuple
    public static func gridToPixel(gridX: Int, gridY: Int, cellSize: Int) -> (x: Int, y: Int) {
        return (x: gridX * cellSize, y: gridY * cellSize)
    }

    /// Calculate distance between two points
    /// - Parameters:
    ///   - point1: First point
    ///   - point2: Second point
    /// - Returns: Distance between points
    public static func distance(from point1: Point, to point2: Point) -> Double {
        let dx = point2.x - point1.x
        let dy = point2.y - point1.y
        return sqrt(dx * dx + dy * dy)
    }

    /// Check if a point is inside a rectangle
    /// - Parameters:
    ///   - point: Point to check
    ///   - rect: Rectangle to check against
    /// - Returns: True if point is inside rectangle
    public static func pointInRect(_ point: Point, _ rect: Rectangle) -> Bool {
        return point.x >= Double(rect.x) && point.x < Double(rect.x + rect.width)
            && point.y >= Double(rect.y) && point.y < Double(rect.y + rect.height)
    }
}

// MARK: - String Extensions

extension String {
    /// Remove file extension from filename
    var withoutExtension: String {
        return (self as NSString).deletingPathExtension
    }

    /// Get file extension
    var fileExtension: String {
        return (self as NSString).pathExtension
    }

    /// Check if string represents a valid file path
    var isValidFilePath: Bool {
        return !self.isEmpty && FileManager.default.fileExists(atPath: self)
    }
}
