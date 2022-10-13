//
//  SearchMusicRequest.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 11.10.22.
//

import Foundation

final class SearchMusicRequest: APIRequest {
    typealias ReplyHandler = (SearchMusicRequest) -> Void
    
    var completionHandler: ReplyHandler?
    
    required init(term: String, offset: Int, limit: Int = 25, completionHandler: ReplyHandler? = nil) {
        super.init(url: "https://itunes.apple.com/search?term=\(term)&entity=song&limit=\(limit)&media=music&offset=\(offset)")
        self.completionHandler = completionHandler
    }
    
    override func deliverResult() {
        completionHandler?(self)
    }

}
