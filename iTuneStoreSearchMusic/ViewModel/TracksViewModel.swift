//
//  TracksViewModel.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 12.10.22.
//

import Foundation

final class TracksViewModel: ObservableObject {
    
    private var trackList: [Track]
    @Published private (set) var tracks = [TrackViewModel]()
    
    private (set) var pageCount: Int = 0
    private (set) var pageSize: Int!
    
    init(trackList: [Track]) {
        self.trackList = trackList
        setup()
    }
    
    init(model: TracksViewModel) {
        self.trackList = model.trackList
    }
    
    private func setup() {
        add(tracks: trackList)
    }
    
    func add(tracks: [Track]) {
        var modelList = [TrackViewModel]()
        for track in tracks {
            let id = self.tracks.count + modelList.count
            let model = TrackViewModel(id: id, track: track)
            modelList.append(model)
        }
        modelList.sort()
        if !modelList.isEmpty {
            if pageSize == nil {
                pageSize = modelList.count
            }
            self.tracks.append(contentsOf: modelList)
            pageCount = pageCount + 1
        }
    }
    
    func isLast(model: TrackViewModel) -> Bool {
        let last = tracks.last
        return model.artistId == last?.artistId && model.trackId == last?.trackId
    }
    
    func page(model: TrackViewModel) -> Int? {
        guard let index = tracks.firstIndex(of: model), pageSize > 0 else {
            return nil
        }
        let value: Float = index == 0 ? 1 : Float(index) / Float(pageSize)
        return Int(ceil(value)) - 1
    }
    
    func index(of track: TrackViewModel) -> Int {
        guard let index = tracks.firstIndex(of: track) else {
            return -1
        }
        return index
    }
}

struct TrackViewModel: Comparable {
    static func == (lhs: TrackViewModel, rhs: TrackViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: TrackViewModel, rhs: TrackViewModel) -> Bool {
        return lhs.artistName < rhs.artistName && lhs != rhs
    }
    
    private let track: Track
    
    init(id: Int, track: Track) {
        self.track = track
        self.id = id
    }
    
    let id: Int
    
    var trackId: Int {
        return track.trackId
    }
    var artistId: Int {
        return track.artistId
    }
    var trackName: String {
        return track.trackName == nil ? "" : track.trackName!
    }
    var artistName: String {
        return track.artistName
    }
    var artworkUrl100: String? {
        return track.artworkUrl100
    }
    var artworkUrl60: String? {
        return track.artworkUrl60
    }
    var artworkUrl30: String? {
        return track.artworkUrl30
    }
    var collectionName: String {
        return track.collectionName == nil ? "" : track.collectionName!
    }
    var releaseDate: Date? {
        return track.releaseDate
    }
    var primaryGenreName: String? {
        return track.primaryGenreName
    }
    var trackViewUrl: String? {
        return track.trackViewUrl
    }
    
    typealias Cover = (width: CGFloat, height: CGFloat, url: URL?)
    var coverSmall: Cover {
        let size: CGFloat = 30
        var result: Cover
        result.width = size
        result.height = size
        result.url = nil
        if let artworkUrl = artworkUrl30, let url = URL(string: artworkUrl) {
            result.url = url
        }
        return result
    }
    
    var coverMedium: Cover {
        let size: CGFloat = 60
        var result: Cover
        result.width = size
        result.height = size
        result.url = nil
        if let artworkUrl = artworkUrl60, let url = URL(string: artworkUrl) {
            result.url = url
        }
        return result
    }
    
    var coverLarge: Cover {
        let size: CGFloat = 100
        var result: Cover
        result.width = size
        result.height = size
        result.url = nil
        if let artworkUrl = artworkUrl100, let url = URL(string: artworkUrl) {
            result.url = url
        }
        return result
    }
    
}
