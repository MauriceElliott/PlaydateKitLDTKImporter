# PlaydateKitLDtkImporter

A Swift package for importing LDtk Super Simple Export files into PlaydateKit games.

## Overview

This library provides a simple way to import and use LDtk level data in your PlaydateKit games using LDtk's "Super Simple Export" feature. Instead of parsing complex JSON structures, this importer works with the simplified PNG and data files that LDtk generates.

## What is LDtk Super Simple Export?

LDtk's Super Simple Export feature generates:

- **One PNG per layer** in each level
- A **composite PNG per level** (all layers merged together)
- A simple **JSON file per level** for entities and metadata
- For IntGrid layers: **PNG representations** and **CSV files**

This makes integration much simpler than parsing the full LDtk JSON format.

## Features

- ✅ Load composite level images for quick display
- ✅ Access individual layer PNGs
- ✅ Parse simplified level JSON for entity data
- ✅ Read IntGrid data from CSV files
- ✅ Easy level discovery and management
- ✅ PlaydateKit-compatible data structures
- ✅ Minimal memory footprint with lazy loading

## Quick Start

```swift
import PlaydateKitLDtkImporter

// Initialize the importer with your Super Simple Export folder
let importer = LDtkSimpleImporter()
try importer.loadProject(from: "path/to/exported/levels")

// Get available levels
let levelNames = importer.availableLevels

// Load a specific level
let level = try importer.loadLevel("Level_1")

// Access the composite image
let compositeImage = level.compositeImage

// Get individual layers
let backgroundLayer = level.getLayer("Background")
let foregroundLayer = level.getLayer("Foreground")

// Access entities
let playerSpawns = level.getEntities(ofType: "PlayerSpawn")
let enemies = level.getEntities(ofType: "Enemy")

// Read IntGrid data
let collisionData = level.getIntGridData("Collisions")
```

## API Reference

### Core Classes

#### `LDtkSimpleImporter`

Main importer class that manages the project and level loading.

**Key Methods:**

- `loadProject(from: String)` - Load a Super Simple Export project folder
- `availableLevels: [String]` - Get list of available level names
- `loadLevel(_ name: String) -> LDtkSimpleLevel` - Load a specific level
- `hasLevel(_ name: String) -> Bool` - Check if a level exists

#### `LDtkSimpleLevel`

Represents a loaded level with all its data.

**Key Properties:**

- `identifier: String` - Level identifier
- `compositeImage: ImageData?` - The merged composite image
- `size: Size` - Level dimensions in pixels
- `worldPosition: Point` - Position in the world

**Key Methods:**

- `getLayer(_ name: String) -> LDtkSimpleLayer?` - Get a specific layer
- `getEntities(ofType: String) -> [LDtkSimpleEntity]` - Get entities by type
- `getIntGridData(_ layerName: String) -> LDtkIntGridData?` - Get IntGrid data
- `getAllEntities() -> [LDtkSimpleEntity]` - Get all entities in the level

#### `LDtkSimpleLayer`

Represents an individual layer (PNG file).

**Key Properties:**

- `identifier: String` - Layer name
- `image: ImageData?` - Layer image data
- `visible: Bool` - Layer visibility
- `opacity: Float` - Layer opacity (0.0 to 1.0)

#### `LDtkSimpleEntity`

Represents an entity instance from the level JSON.

**Key Properties:**

- `identifier: String` - Entity type name
- `position: Point` - Position in the level
- `size: Size` - Entity dimensions
- `fields: [String: Any]` - Custom field values

**Key Methods:**

- `getField<T>(_ name: String, as: T.Type) -> T?` - Get typed field value
- `getStringField(_ name: String) -> String?` - Get string field
- `getIntField(_ name: String) -> Int?` - Get integer field
- `getBoolField(_ name: String) -> Bool?` - Get boolean field

#### `LDtkIntGridData`

Represents IntGrid layer data from CSV files.

**Key Properties:**

- `width: Int` - Grid width in cells
- `height: Int` - Grid height in cells
- `cellSize: Int` - Size of each grid cell in pixels

**Key Methods:**

- `getValue(x: Int, y: Int) -> Int` - Get IntGrid value at coordinates
- `getValueAtPixel(x: Int, y: Int) -> Int` - Get value at pixel coordinates
- `getAllValues() -> [[Int]]` - Get 2D array of all values

#### `LDtkProjectInfo`

Contains basic project information from the simplified export.

**Key Properties:**

- `projectName: String` - Name of the project
- `levels: [String]` - List of level identifiers
- `exportPath: String` - Path to the export folder

### Utility Classes

#### `LDtkFileManager`

Handles file system operations for the Super Simple Export structure.

**Key Methods:**

- `discoverLevels(in: String) -> [String]` - Find all level folders
- `loadLevelData(_ levelName: String, from: String) -> LDtkLevelData` - Load level files
- `validateExportStructure(_ path: String) -> Bool` - Verify export folder structure

#### `LDtkImageLoader`

Manages loading and caching of PNG images.

**Key Methods:**

- `loadImage(from: String) -> ImageData?` - Load PNG file
- `preloadImages(for: LDtkSimpleLevel)` - Preload all level images
- `clearCache()` - Clear image cache

#### `LDtkCSVParser`

Parses IntGrid CSV files.

**Key Methods:**

- `parseCSV(from: String) -> [[Int]]` - Parse CSV file to 2D array
- `parseCSVToIntGrid(from: String, cellSize: Int) -> LDtkIntGridData` - Parse to IntGrid object

## File Structure

The Super Simple Export creates this structure:

```
ExportedProject/
├── Level_1/
│   ├── _composite.png          # Complete level image
│   ├── data.json              # Level data and entities
│   ├── Background.png         # Individual layer PNGs
│   ├── Foreground.png
│   ├── Collisions-int.png     # IntGrid visualization
│   └── Collisions.csv         # IntGrid data
├── Level_2/
│   └── ...
└── ...
```

## Implementation Plan

### Phase 1: Core Structure

1. Create basic data models (Point, Size, Rectangle, etc.)
2. Implement file discovery and validation
3. Create level loading infrastructure

### Phase 2: Image Loading

1. Implement PNG loading for composite images
2. Add individual layer image loading
3. Create image caching system

### Phase 3: Data Parsing

1. Parse simplified level JSON files
2. Extract entity data and properties
3. Handle custom field types

### Phase 4: IntGrid Support

1. Implement CSV parsing for IntGrid data
2. Create IntGrid data access methods
3. Add coordinate conversion utilities

### Phase 5: PlaydateKit Integration

1. Ensure compatibility with PlaydateKit types
2. Optimize for Playdate hardware constraints
3. Add memory management features

### Phase 6: Advanced Features

1. Level streaming and lazy loading
2. Multi-world support
3. Asset preloading strategies

## Error Handling

The library includes comprehensive error handling for:

- Missing or invalid export folders
- Corrupted or missing image files
- Invalid JSON data
- File system access errors
- Memory constraints

## Performance Considerations

- Lazy loading of images and data
- Efficient memory management for Playdate constraints
- Minimal parsing overhead
- Optional image caching strategies

## Requirements

- Swift 5.5+
- PlaydateKit framework
- macOS 10.15+ / iOS 13+ (for development)

## License

[Add your license information here]
