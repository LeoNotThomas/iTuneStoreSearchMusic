// Tracks.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tracks = try? newJSONDecoder().decode(Tracks.self, from: jsonData)

import Foundation

// MARK: - Tracks
struct Tracks: Codable {
    let resultCount: Int
    let results: [Track]
}

// Result.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let result = try? newJSONDecoder().decode(Result.self, from: jsonData)

import Foundation

// MARK: - Result
struct Track: Codable {
    let wrapperType: WrapperType?
    let kind: String?
    let artistId: Int
    let collectionId: Int?
    let trackId: Int
    let artistName: String
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: Date?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistName: String?
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?
    
    // this initiailize is primarily for tests, no reason to use this inside the main project
    init(artistId: Int, trackId: Int, artistName: String, collectionName: String? = nil, trackViewUrl: String? = nil, releaseDate: Date? = nil, primaryGenreName: String? = nil) {
        self.artistId = artistId
        self.trackId = trackId
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackViewUrl = trackViewUrl
        self.releaseDate = releaseDate
        self.primaryGenreName = primaryGenreName
        
        wrapperType = nil
        kind = nil
        collectionId = nil
        trackName = nil
        collectionCensoredName = nil
        trackCensoredName = nil
        artistViewUrl = nil
        collectionViewUrl = nil
        previewUrl = nil
        artworkUrl30 = nil
        artworkUrl60 = nil
        artworkUrl100 = nil
        collectionPrice = nil
        trackPrice = nil
        collectionExplicitness = nil
        trackExplicitness = nil
        discCount = nil
        discNumber = nil
        trackCount = nil
        trackNumber = nil
        trackTimeMillis = nil
        country = nil
        currency = nil
        isStreamable = nil
        collectionArtistName = nil
        collectionArtistId = nil
        collectionArtistViewUrl = nil
    }
}

// would use this in the future, but getting errors and can find the case, must be a value, that not inside in the PrimaryGenreName
enum PrimaryGenreName: String, Codable {
    case childrenSMusic = "Children's Music"
    case germanPop = "German Pop"
    case pop = "Pop"
    case rock = "Rock"
    case singerSongwriter = "Singer/Songwriter"
    case spokenWord = "Spoken Word"
    case worldwide = "Worldwide"
}

enum WrapperType: String, Codable {
    case track = "track"
    case collection = "collection"
    case artistFor = "artistFor"
}
