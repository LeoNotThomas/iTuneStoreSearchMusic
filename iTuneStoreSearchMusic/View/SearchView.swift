//
//  ContentView.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 11.10.22.
//

import SwiftUI

struct SearchView: View {
    #if RELEASE
    @State private var searchText = ""
    #endif
    
    #if DEBUG
    @State private var searchText = "Peter Maffay"
    #endif
    
    @State private var showSearchResult = false
    @State private var showAlert = false
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.AppColor.navigationItem]
        navBarAppearance.backgroundColor = UIColor.AppColor.navigationBar
        navBarAppearance.shadowColor = .gray
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
    }
    
    private func searchBarImage() -> UIImage {
        let image = UIImage(systemName: "magnifyingglass")
        return image!.withTintColor(UIColor(.red), renderingMode: .alwaysOriginal)
    }
    
    func getView() -> any View {
        return Text("Error")
    }
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: TrackListView(term: searchText), isActive: $showSearchResult) {
                VStack {
                    Text("")
                       .searchable(text: $searchText, prompt: "Search terms")
                    Button("Start Search") {
                        if !searchText.isEmpty {
                            print(searchText)
                            showSearchResult = true
                        } else {
                            showAlert = true
                        }
                    }
                    .frame(width: 120, height: 44)
                    .foregroundColor(Color(uiColor: UIColor.AppColor.navigationBar))
                    .border(Color(uiColor: UIColor.AppColor.navigationBar))
                    .alert("Give me a search term :)!", isPresented: $showAlert) {
                        Button("Close", role: .cancel) { }
                    }
                    
                }
                .navigationTitle("Search View")
                .navigationBarTitleDisplayMode(.inline)
            }
        }.accentColor(Color(uiColor: UIColor.AppColor.navigationItem))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
