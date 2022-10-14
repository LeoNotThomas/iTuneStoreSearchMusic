//
//  TrackWebView.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 14.10.22.
//

import SwiftUI

struct TrackWebView: View {
    @Environment(\.dismiss) var dismiss
    var url: URL
    var body: some View {
        WebView(url: url)
    }
}

struct TrackWebView_Previews: PreviewProvider {
    static var previews: some View {
        TrackWebView(url: URL(string: "www.google.com")!)
    }
}
