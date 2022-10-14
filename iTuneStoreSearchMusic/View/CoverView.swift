//
//  CoverView.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 14.10.22.
//

import SwiftUI

enum CoverType {
    case small
    case medium
    case large
}

struct CoverView: View {
    @State var track: TrackViewModel
    let type: CoverType
    var body: some View {
        if let url = cover.url {
            AsyncImage(url: url) { coverImage in
                coverImage
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image("NoCover")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: cover.width, height: cover.height)
        } else {
            Image("NoCover")
                .frame(width: cover.width, height: cover.height)
        }
    }
    
    var cover: TrackViewModel.Cover {
        switch type {
        case .small:
            return track.coverSmall
        case .medium:
            return track.coverMedium
        case .large:
            return track.coverLarge
        }
    }
}

struct CoverView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track(artistId: 1, trackId: 0, artistName: "testName", collectionName: "testCollectionName", trackViewUrl: "www.google.com", releaseDate: Date(), primaryGenreName: "testPrimaryGenreName")
        CoverView(track: TrackViewModel(id: 0, track: track), type: .large)
    }
}
