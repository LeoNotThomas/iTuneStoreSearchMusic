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

//    enum CodingKeys: String, CodingKey {
//        case wrapperType, kind
//        case artistId
//        case collectionId
//        case trackId
//        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
//        case artistViewUrl
//        case collectionViewUrl
//        case trackViewUrl
//        case previewUrl
//        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, collectionArtistName
//        case collectionArtistId
//        case collectionArtistViewUrl
//    }
    
    init(artistId: Int, trackId: Int, artistName: String) {
        self.artistId = artistId
        self.trackId = trackId
        self.artistName = artistName
        
        wrapperType = nil
        kind = nil
        collectionId = nil
        collectionName = nil
        trackName = nil
        collectionCensoredName = nil
        trackCensoredName = nil
        artistViewUrl = nil
        collectionViewUrl = nil
        trackViewUrl = nil
        previewUrl = nil
        artworkUrl30 = nil
        artworkUrl60 = nil
        artworkUrl100 = nil
        collectionPrice = nil
        trackPrice = nil
        releaseDate = nil
        collectionExplicitness = nil
        trackExplicitness = nil
        discCount = nil
        discNumber = nil
        trackCount = nil
        trackNumber = nil
        trackTimeMillis = nil
        country = nil
        currency = nil
        primaryGenreName = nil
        isStreamable = nil
        collectionArtistName = nil
        collectionArtistId = nil
        collectionArtistViewUrl = nil
    }
}

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
