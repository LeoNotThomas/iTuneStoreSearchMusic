//
//  TrackListView.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 12.10.22.
//

import SwiftUI

struct TrackListView: View {
    @ObservedObject var viewModel: TracksViewModel
    var loader: TrackLoader
    
    fileprivate func loadNextPage() {
        loader.next { tracks in
            DispatchQueue.main.async {
                viewModel.add(tracks: tracks)
            }
        }
    }
    
    var body: some View {
        if viewModel.tracks.isEmpty {
            Text("Please wait loading Data")
                .onAppear {
                    loadNextPage()
                }
            Spacer()
            ProgressView()
        } else {
            List(viewModel.tracks, id: \.id) { track in
                NavigationLink(destination: Text("Test")) {
                    VStack(alignment: .leading) {
                        Text(track.artistName).bold()
                        HStack(alignment: .top) {
                            let cover = track.coverMedium
                            if let url = cover.url {
                                AsyncImage(url: url, content: { image in
                                    image.resizable()
                                }, placeholder: {
                                    ProgressView()
                                }).frame(width: cover.width, height: cover.height)
                            } else {
                                Text("No Cover")
                            }
                            VStack(alignment: .leading) {
                                HStack(alignment: .top, spacing: 4) {
                                    Text("Song:")
                                        .frame(width: 60, alignment: .leading)
                                    Text("\(track.trackName)")
                                }
                                HStack(alignment: .top, spacing: 4) {
                                    Text("Album:")
                                        .frame(width: 60, alignment: .leading)
                                    Text("\(track.collectionName)")
                                }
                            }
                        }
                    }
                    .onAppear {
                        if track == viewModel.tracks.last {
                            loadNextPage()
                        }
                    }
                }
            }
            .navigationTitle("List View")
        }
    }
    
    init(term: String) {
        loader = TrackLoader(term: term, limit: 25)
        viewModel = TracksViewModel(trackList: loader.trackList)
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView(term: "Peter Maffay")
    }
}
