//
//  TrackDetailView.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 14.10.22.
//

import SwiftUI

struct TrackDetailView: View {
    @State var track: TrackViewModel
    @State private var showingDetail = false
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading) {
                info(prefix: Prefix.artist.rawValue, text: track.artistName)
                HStack(alignment: .top) {
                    CoverView(track: track, type: .large)
                    VStack(alignment: .leading, spacing: 8) {
                        info(prefix: Prefix.released.rawValue, text: track.formatedReleaseDate)
                        info(prefix: Prefix.album.rawValue, text: track.collectionName)
                        info(prefix: Prefix.genre.rawValue, text: track.primaryGenreName)
                        info(prefix: Prefix.title.rawValue, text: track.trackName)
                    }
                }
            }
            Group{
                Button(action: {
                    showingDetail.toggle()
                }, label: {
                    Text("Link")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                        .background(Color(uiColor: UIColor.AppColor.button(disabled: track.trackUrl == nil)))
                        .cornerRadius(15)
                        .padding()
                })
                .disabled(track.trackUrl == nil)
            }.frame(maxHeight: .infinity, alignment: .bottom)
        }.padding(4)
            .sheet(isPresented: $showingDetail) {
                TrackWebView(url: track.trackUrl!)
            }
    }
    
    func info(prefix: String, text: String) -> some View {
        return HStack(alignment: .top) {
            Text("\(prefix):")
                .bold()
                .frame(width: 80, alignment: .trailing)
            Text("\(text)")
        }
    }
    
    
    enum Prefix: String {
        case artist = "Interpret"
        case album = "Album"
        case genre = "Genre"
        case released = "Released"
        case title = "Title"
    }
}

struct TrackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track(artistId: 1, trackId: 0, artistName: "testName", collectionName: "testCollectionName", trackViewUrl: "www.google.com", releaseDate: Date(), primaryGenreName: "testPrimaryGenreName", trackName: "Lalelu")
        TrackDetailView(track: TrackViewModel(id: 0, track: track))
    }
}
