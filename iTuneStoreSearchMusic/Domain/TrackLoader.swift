//
//  TrackLoader.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 11.10.22.
//

import Foundation

final class TrackLoader: JsonDecodeDelegate {
    
    private let term: String
    private var limit: Int
    private var offset: Int = 0
    private (set) var trackList = [Track]()
    private (set) var moreTracksAvaileble = true
    
    private var decoder: JSONDecode!
    init(term: String, limit: Int) {
        self.term = term
        self.limit = limit
        decoder = JSONDecode()
        decoder.delegate = self
    }
    
    func decoded<T>(data: T) where T : Decodable {
        if let tracks = data as? Tracks {
            if tracks.resultCount < limit {
                moreTracksAvaileble = false
            }
            if tracks.resultCount > 0 {
                trackList.append(contentsOf: tracks.results)
            }
            offset = offset + limit
        }
    }
    
    func decoded(error: Error) {
        // TO DO: put the error in a global Error object
        offset = offset + limit
        print("Error fetch data")
    }
    
    func startDecode() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.decode(type: Tracks.self, dateFormatter: dateFormatter)
    }
    
    typealias TrackListReplyHandler = ([Track]) -> Void
    func next(completion: TrackListReplyHandler?) {
        let request = SearchMusicRequest(term: term, offset: offset, limit: limit) { request in
            self.decoder.data = request.data
            completion?(self.trackList)
        }
        request.send()
    }
}
