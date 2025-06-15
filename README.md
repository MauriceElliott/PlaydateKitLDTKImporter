# PlaydateKitLDtkImporter

An LDtk Importer for Playdate Kit.

# LDtk to Swift Conversion Guide

**Date:** 2025-06-15 20:48:09 UTC
**User:** MauriceElliott

## Overview

This document outlines the conversion of a Lua-based LDtk (Level Designer Toolkit) importer for Playdate games to Swift using PlaydateKit. The original Lua file imports LDTK levels into Playdate games using the standard Lua API, and we need to create equivalent functionality in Swift for PlaydateKit projects.

## Original Request

> This lua file is written as a way to import LDTK (which is a tile based level editor, can be found at https://ldtk.io), into playdate games, using the standard lua API, I need to create code that is thematically similar, and does the same job, but is written in swift, to import into a PlaydateKit project (A library for Playdate which uses the Playdate C api, and adds a wrapper round it, documenation for which can be found here: https://finnvoor.github.io/PlaydateKit/documentation/playdatekit/), and Swift embedded, which is a current feature of Swift embedded.

## Analysis of LDtk.lua File

The LDtk.lua file is a comprehensive importer for LDtk (Level Designer Toolkit) files in Playdate Lua games. Here's what it accomplishes:

### Core Functionality:

1. **Loading LDtk Projects**: Parses JSON files from the LDtk level editor
2. **Tilemap Management**: Creates Playdate tilemaps from LDtk tile layers
3. **Entity Processing**: Extracts and processes entity data with custom fields
4. **Tileset Handling**: Manages tilesets with support for flipped tiles
5. **Level Management**: Loads/unloads levels (especially for external level files)
6. **Optimization**: Exports to Lua files for faster loading
7. **Collision Detection**: Provides tile IDs for collision systems

### Key Features:

- Support for external level files (memory management)
- Flipped tile support (doubles tileset size for rotations)
- Custom entity fields and properties
- Level neighbors and world positioning
- Performance optimization through precompiled Lua files

## Step-by-Step Conversion Plan

### 1. Project Structure

Create these Swift files:

- `LDtkImporter.swift` (main class)
- `LDtkTypes.swift` (data structures)
- `LDtkLevel.swift` (level management)
- `LDtkTileset.swift` (tileset handling)

### 2. Key Swift/PlaydateKit Concepts to Use:

**File Operations:**

- Use PlaydateKit's file system APIs
- Swift's `Codable` for JSON parsing
- Bundle resources for asset loading

**Graphics:**

- PlaydateKit's `Bitmap` and `BitmapTable` instead of Lua's `imagetable`
- `Tilemap` equivalent in PlaydateKit
- Image generation using PlaydateKit's graphics context

**Memory Management:**

- Swift's automatic memory management
- Optional reference counting for heavy resources
- Proper cleanup in `deinit`

### 3. Data Structure Mapping:

````swift
// Equivalent to Lua tables
struct LDtkProject: Codable {
    let levels: [LDtkLevelData]
    let defs: LDtkDefinitions
    let externalLevels: Bool
}

struct LDtkEntity {
    let name: String
    let position: Point
    let center: Point
    let size: Size
    let zIndex: Int
    let fields: [String: Any]
}```

#### Claude Attempted a full conversion, here are the types, followed by the class

```swift
import Foundation

// MARK: - JSON Codable Types

public struct LDtkProject: Codable {
    let levels: [LDtkLevelData]
    let defs: LDtkDefinitions
    let externalLevels: Bool
}

public struct LDtkDefinitions: Codable {
    let tilesets: [LDtkTilesetData]
}

public struct LDtkTilesetData: Codable {
    let uid: String
    let relPath: String
    let pxWid: Int
    let pxHei: Int
    let tileGridSize: Int
    let __cWid: Int
    let __cHei: Int
    let enumTags: [LDtkEnumTag]
}

public struct LDtkEnumTag: Codable {
    let enumValueId: String
    let tileIds: [Int]
}

public struct LDtkLevelData: Codable {
    let iid: String
    let identifier: String
    let worldX: Int
    let worldY: Int
    let pxWid: Int
    let pxHei: Int
    let externalRelPath: String?
    let layerInstances: [LDtkLayerData]
    let fieldInstances: [LDtkFieldInstance]
    let __neighbors: [LDtkNeighborData]
}

public struct LDtkLayerData: Codable {
    let __identifier: String
    let __type: String
    let __gridSize: Int
    let __cWid: Int
    let __cHei: Int
    let __pxTotalOffsetX: Int
    let __pxTotalOffsetY: Int
    let __tilesetRelPath: String?
    let __tilesetDefUid: String?
    let gridTiles: [LDtkTileData]
    let autoLayerTiles: [LDtkTileData]
    let entityInstances: [LDtkEntityData]
}

public struct LDtkTileData: Codable {
    let px: [Int]
    let src: [Int]
    let f: Int
    let t: Int
}

public struct LDtkEntityData: Codable {
    let iid: String
    let __identifier: String
    let px: [Int]
    let __worldX: Int?
    let __worldY: Int?
    let __pivot: [Double]
    let width: Int
    let height: Int
    let __tile: LDtkTilesetRect?
    let fieldInstances: [LDtkFieldInstance]
}

public struct LDtkFieldInstance: Codable {
    let __identifier: String
    let __value: LDtkFieldValue
}

public struct LDtkNeighborData: Codable {
    let dir: String
    let levelIid: String
}

public struct LDtkTilesetRect: Codable {
    let tilesetUid: String
    let x: Int
    let y: Int
    let w: Int
    let h: Int
}

// MARK: - Runtime Types

public class LDtkLevel {
    var neighbors = LDtkNeighbors()
    var customData: [String: Any] = [:]
    var layers: [String: LDtkLayer] = [:]
}

public class LDtkLayer {
    var gridSize: Int = 0
    var zIndex: Int = 0
    var rect: Rectangle?
    var tilesetFile: String?
    var tilesetUID: String = ""
    var hasFlippedTiles = false
    var tilemapWidth: Int = 0
    var tiles: [Int]?
    var entities: [LDtkEntity]?
    var tilesetImage: BitmapTable?
}

public struct LDtkEntity {
    let name: String
    let iid: String
    let tilesetRect: LDtkTilesetRect?
    let position: Point
    let worldPosition: Point?
    let center: Point
    let size: Size
    let zIndex: Int
    let fields: [String: Any]
}

public class LDtkTileset {
    var imageTableFilename: String?
    var imageWidth: Int = 0
    var imageHeight: Int = 0
    var tileIDs: [String: [Int]] = [:]
    var tileIDsEmpty: [String: [Int]] = [:]
    var tileIDsFlipped: [String: [Int]] = [:]
    var tileIDsFlippedEmpty: [String: [Int]] = [:]
}

public class LDtkNeighbors {
    var east: [String] = []
    var west: [String] = []
    var north: [String] = []
    var south: [String] = []
    var back: [String] = []
    var front: [String] = []
    var northwest: [String] = []
    var northeast: [String] = []
    var southwest: [String] = []
    var southeast: [String] = []

    func addNeighbor(direction: String, levelName: String) {
        switch direction {
        case "east": east.append(levelName)
        case "west": west.append(levelName)
        case "north": north.append(levelName)
        case "south": south.append(levelName)
        case "back": back.append(levelName)
        case "front": front.append(levelName)
        case "northwest": northwest.append(levelName)
        case "northeast": northeast.append(levelName)
        case "southwest": southwest.append(levelName)
        case "southeast": southeast.append(levelName)
        default: break
        }
    }
}

// MARK: - Helper Types

public enum LDtkFieldValue: Codable {
    case string(String)
    case int(Int)
    case float(Double)
    case bool(Bool)
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .null
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let doubleValue = try? container.decode(Double.self) {
            self = .float(doubleValue)
        } else if let boolValue = try? container.decode(Bool.self) {
            self = .bool(boolValue)
        } else {
            throw DecodingError.typeMismatch(LDtkFieldValue.self,
                DecodingError.Context(codingPath: decoder.codingPath,
                debugDescription: "Unknown field value type"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value): try container.encode(value)
        case .int(let value): try container.encode(value)
        case .float(let value): try container.encode(value)
        case .bool(let value): try container.encode(value)
        case .null: try container.encodeNil()
        }
    }
}


import PlaydateKit
import Foundation

public class LDtkImporter {
    // MARK: - Private Properties
    private var ldtkFilepath: String?
    private var ldtkFolder: String?
    private var ldtkFilename: String?
    private var ldtkFolderComponents: [String] = []
    private var ldtkLuaFolder: String?

    private let ldtkLuaFoldername = "LDtk_lua_levels"

    private var levelFiles: [String: String] = [:]
    private var levels: [String: LDtkLevel] = [:]
    private var levelNames: [String: String] = [:] // UIDs to names
    private var levelRects: [String: Rectangle] = [:]
    private var tilesets: [String: LDtkTileset] = [:]
    private var imageTables: [String: ImageTableReference] = [:]

    private var useExternalFiles = false
    private var useLuaLevels = false

    // MARK: - Public Interface

    /// Load an LDtk project file
    public func load(_ ldtkFile: String, useLuaLevels: Bool? = nil) throws {
        guard !ldtkFile.isEmpty else {
            throw LDtkError.invalidFilePath("LDtk.load() called without a path to ldtk file")
        }

        ldtkFilepath = ldtkFile
        (ldtkFolder, ldtkFilename) = getFolderAndFilename(ldtkFile)
        ldtkFolderComponents = getFolderComponents(ldtkFolder ?? "")
        ldtkLuaFolder = (ldtkFolder ?? "") + ldtkLuaFoldername

        let luaFilename = "\(ldtkLuaFolder ?? "")/\(ldtkFilename ?? "").pdz"

        // Check if we should load lua files
        self.useLuaLevels = useLuaLevels ?? false
        if self.useLuaLevels {
            if !FileSystem.fileExists(luaFilename) {
                self.useLuaLevels = false
                print("LDtk Importer Error: cannot load lua file because it does not exist: \(luaFilename)")
            }
        }

        // Load from precomputed lua file
        if self.useLuaLevels {
            try loadFromLuaFiles(luaFilename)
            return
        }

        // Load from JSON
        try loadFromJSON(ldtkFile)
    }

    /// Create a tilemap for the specified level
    public func createTilemap(levelName: String, layerName: String? = nil) -> Tilemap? {
        guard let layer = getTileLayer(levelName: levelName, layerName: layerName) else {
            return nil
        }

        let tilemap = Tilemap()
        tilemap.setImageTable(layer.tilesetImage)
        tilemap.setTiles(layer.tiles, width: layer.tilemapWidth)

        return tilemap
    }

    /// Get entities from a level
    public func getEntities(levelName: String, layerName: String? = nil) -> [LDtkEntity] {
        guard let level = levels[levelName] else { return [] }

        if let layerName = layerName {
            guard let layer = level.layers[layerName] else { return [] }
            return layer.entities ?? []
        }

        // Return all entities from all layers
        var allEntities: [LDtkEntity] = []
        for layer in level.layers.values {
            if let entities = layer.entities {
                allEntities.append(contentsOf: entities)
            }
        }
        return allEntities
    }

    /// Get tile IDs tagged with specific enum value
    public func getTileIDs(levelName: String, tilesetEnumValue: String, layerName: String? = nil) -> [Int]? {
        guard let layer = getTileLayer(levelName: levelName, layerName: layerName),
              let tileset = tilesets[layer.tilesetUID] else {
            return nil
        }

        if layer.hasFlippedTiles {
            return tileset.tileIDsFlipped[tilesetEnumValue]
        }
        return tileset.tileIDs[tilesetEnumValue]
    }

    /// Get empty tile IDs (not tagged with specific enum value)
    public func getEmptyTileIDs(levelName: String, tilesetEnumValue: String, layerName: String? = nil) -> [Int]? {
        guard let layer = getTileLayer(levelName: levelName, layerName: layerName),
              let tileset = tilesets[layer.tilesetUID] else {
            return nil
        }

        if layer.hasFlippedTiles {
            return tileset.tileIDsFlippedEmpty[tilesetEnumValue]
        }
        return tileset.tileIDsEmpty[tilesetEnumValue]
    }

    // MARK: - Private Methods

    private func loadFromJSON(_ filepath: String) throws {
        guard let data = FileSystem.loadFile(filepath) else {
            throw LDtkError.fileNotFound("Cannot load LDtk file: \(filepath)")
        }

        let decoder = JSONDecoder()
        let ldtkProject = try decoder.decode(LDtkProject.self, from: data)

        useExternalFiles = ldtkProject.externalLevels

        // Process tilesets
        for tilesetData in ldtkProject.defs.tilesets {
            let tileset = try processTilesetData(tilesetData)
            tilesets[tilesetData.uid] = tileset
        }

        // Process level names first
        for levelData in ldtkProject.levels {
            levelNames[levelData.iid] = levelData.identifier
            levelRects[levelData.identifier] = Rectangle(
                x: levelData.worldX,
                y: levelData.worldY,
                width: levelData.pxWid,
                height: levelData.pxHei
            )
        }

        // Process levels
        for levelData in ldtkProject.levels {
            if let externalPath = levelData.externalRelPath {
                levelFiles[levelData.identifier] = convertRelativeFolder(externalPath)
            } else {
                levels[levelData.identifier] = try processLevelData(levelData)
                loadTileset(levelName: levelData.identifier)
            }
        }
    }

    private func loadFromLuaFiles(_ luaFilename: String) throws {
        // Implementation for loading precompiled lua files
        // This would need custom binary format or use PlaydateKit's serialization
        print("Loading from lua files not yet implemented")
    }

    private func processTilesetData(_ tilesetData: LDtkTilesetData) throws -> LDtkTileset {
        let tileset = LDtkTileset()
        tileset.imageTableFilename = convertRelativeFolder(tilesetData.relPath)
        tileset.imageWidth = tilesetData.pxWid
        tileset.imageHeight = tilesetData.pxHei

        // Process tile IDs and enum tags
        let gridSize = tilesetData.tileGridSize
        let cw = tilesetData.__cWid
        let ch = tilesetData.__cHei
        let cw2 = cw * 2
        let ch2 = ch * 2

        for enumDef in tilesetData.enumTags {
            var tileIDs: [Int] = []
            var tileIDsFlipped: [Int] = []
            var registeredTileIDs: Set<Int> = []
            var registeredTileIDsFlipped: Set<Int> = []

            for tileID in enumDef.tileIds {
                // Normal tileset
                let normalID = tileID + 1
                tileIDs.append(normalID)
                registeredTileIDs.insert(normalID)

                // Flipped tileset calculations
                let cy = tileID / cw
                let cx = tileID - cy * cw
                let flipNo = 1 + cy * cw2 + cx
                let flipX = 1 + cy * cw2 + (cw2 - cx - 1)
                let flipY = 1 + (ch2 - cy - 1) * cw2 + cx
                let flipXY = 1 + (ch2 - cy - 1) * cw2 + (cw2 - cx - 1)

                tileIDsFlipped.append(contentsOf: [flipNo, flipX, flipY, flipXY])
                registeredTileIDsFlipped.formUnion([flipNo, flipX, flipY, flipXY])
            }

            // Calculate empty tile IDs
            let tileIDsEmpty = (1...(cw * ch)).filter { !registeredTileIDs.contains($0) }
            let tileIDsFlippedEmpty = (1...(cw2 * ch2)).filter { !registeredTileIDsFlipped.contains($0) }

            tileset.tileIDs[enumDef.enumValueId] = tileIDs
            tileset.tileIDsEmpty[enumDef.enumValueId] = tileIDsEmpty
            tileset.tileIDsFlipped[enumDef.enumValueId] = tileIDsFlipped
            tileset.tileIDsFlippedEmpty[enumDef.enumValueId] = tileIDsFlippedEmpty
        }

        return tileset
    }

    private func processLevelData(_ levelData: LDtkLevelData) throws -> LDtkLevel {
        let level = LDtkLevel()

        // Process neighbors
        level.neighbors = LDtkNeighbors()
        for neighborData in levelData.__neighbors {
            let direction = getDirection(from: neighborData.dir)
            let neighborName = levelNames[neighborData.levelIid] ?? ""
            level.neighbors.addNeighbor(direction: direction, levelName: neighborName)
        }

        // Process custom fields
        for fieldData in levelData.fieldInstances {
            level.customData[fieldData.__identifier] = fieldData.__value
        }

        // Process layers
        let layerCount = levelData.layerInstances.count
        for (index, layerData) in levelData.layerInstances.enumerated() {
            let layer = try processLayerData(layerData, layerIndex: layerCount - index - 1, levelData: levelData)
            level.layers[layerData.__identifier] = layer
        }

        return level
    }

    // Additional helper methods would go here...
    private func getFolderAndFilename(_ filepath: String) -> (String?, String?) {
        let url = URL(fileURLWithPath: filepath)
        return (url.deletingLastPathComponent().path, url.deletingPathExtension().lastPathComponent)
    }

    private func getTileLayer(levelName: String, layerName: String?) -> LDtkLayer? {
        guard let level = levels[levelName] else { return nil }

        if let layerName = layerName {
            return level.layers[layerName]
        }

        // Return first layer with tiles
        for layer in level.layers.values {
            if layer.tiles != nil {
                return layer
            }
        }
        return nil
    }
}

// MARK: - Supporting Types

public enum LDtkError: Error {
    case invalidFilePath(String)
    case fileNotFound(String)
    case jsonDecodingError(String)
}

public struct Rectangle {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
}

public struct Point {
    let x: Double
    let y: Double
}

public struct Size {
    let width: Int
    let height: Int
}

class ImageTableReference {
    var count: Int = 0
    var image: BitmapTable?

    init(image: BitmapTable) {
        self.image = image
        self.count = 1
    }
}
````
