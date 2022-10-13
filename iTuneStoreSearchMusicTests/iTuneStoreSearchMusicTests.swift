//
//  iTuneStoreSearchMusicTests.swift
//  iTuneStoreSearchMusicTests
//
//  Created by Thomas Leonhardt on 11.10.22.
//

import XCTest
@testable import iTuneStoreSearchMusic

final class iTuneStoreSearchMusicTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTracksReading() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "Maffay", ofType: "json") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            guard let decodedData = try? decoder.decode(Tracks.self, from: data) else {
                XCTAssertTrue(false, "Can't decode data")
                return
            }
            XCTAssertFalse(decodedData.results.isEmpty, "No entries found")
        } catch {
            XCTAssertTrue(false, "Can't read data")
        }
    }
    
    func testSearchMusicRequest() {
        var data: Data?
        let expectation = self.expectation(description: "Request")
        let request = SearchMusicRequest(term: "Maffay", offset: 0, limit: 25) { request in
            data = request.data
            expectation.fulfill()
        }
        request.send()
        waitForExpectations(timeout: 5)
        XCTAssertTrue(data != nil, "No request data (wrong response)")
    }
    
    func testTrackLoader() {
        let loader = TrackLoader(term: "Peter Maffay", limit: 10)
        var trackList: [Track]?
        let expectation = self.expectation(description: "Loader")
        loader.next { tracks in
            trackList = tracks
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(trackList?.count == 10, "number of tracks wrong")
        let nextExpectation = self.expectation(description: "Next")
        loader.next { tracks in
            trackList = tracks
            nextExpectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertTrue(trackList?.count == 20, "number of tracks wrong")
    }
    
    func testSort() {
        let track_A = Track(artistId: 11, trackId: 0, artistName: "Abel")
        let track_B = Track(artistId: 12, trackId: 1, artistName: "Kahn")
        let track_C = Track(artistId: 1, trackId: 2, artistName: "Kain")
        let model = TracksViewModel(trackList: [track_C, track_A, track_B])
        XCTAssertTrue(model.tracks.first?.artistName == "Abel" && model.tracks.last?.artistName == "Kain", "no alphabetical sort")
    }
    
    func testViewModelSortAfterAdd() {
        let track_A = Track(artistId: 11, trackId: 0, artistName: "Abel")
        let track_B = Track(artistId: 12, trackId: 1, artistName: "Kahn")
        let track_C = Track(artistId: 1, trackId: 2, artistName: "Kain")
        let model = TracksViewModel(trackList: [track_C])
        model.add(tracks: [track_A, track_B])
        XCTAssertTrue(model.tracks.first?.artistName == "Kain" && model.tracks.last?.artistName == "Kahn", "wrong sort complete List")
    }
    
    func testViewModelIsLast() {
        let track_A = Track(artistId: 0, trackId: 0, artistName: "A")
        let track_B = Track(artistId: 1, trackId: 1, artistName: "B")
        let track_C = Track(artistId: 2, trackId: 2, artistName: "C")
        let model = TracksViewModel(trackList: [track_A, track_B, track_C])
        XCTAssertTrue(model.isLast(model: TrackViewModel(id: 3, track: track_C)), "last track unexpected")
    }
    
    func testViewModelUniqueIDs() {
        let track_0 = Track(artistId: 0, trackId: 0, artistName: "A")
        let track_1 = Track(artistId: 1, trackId: 1, artistName: "B")
        let track_2 = Track(artistId: 2, trackId: 2, artistName: "C")
        let model = TracksViewModel(trackList: [track_0, track_1, track_2])
        let track_3 = Track(artistId: 3, trackId: 3, artistName: "D")
        let track_4 = Track(artistId: 4, trackId: 4, artistName: "E")
        let track_5 = Track(artistId: 5, trackId: 5, artistName: "F")
        model.add(tracks: [track_3, track_4, track_5])
        XCTAssertTrue(model.tracks.first?.id == 0 && model.tracks.last?.id == 5, "Found unexpected id's")
    }
    
    func testViewModelPage() {
        let track_0 = Track(artistId: 0, trackId: 0, artistName: "A")
        let track_1 = Track(artistId: 1, trackId: 1, artistName: "B")
        let track_2 = Track(artistId: 2, trackId: 2, artistName: "C")
        let model = TracksViewModel(trackList: [track_0, track_1, track_2])
        let track_3 = Track(artistId: 3, trackId: 3, artistName: "D")
        let track_4 = Track(artistId: 4, trackId: 4, artistName: "E")
        let track_5 = Track(artistId: 5, trackId: 5, artistName: "F")
        model.add(tracks: [track_3, track_4, track_5])
        XCTAssertTrue(model.page(model: TrackViewModel(id: 1, track: track_1)) == 0 && model.page(model: TrackViewModel(id: 5, track: track_5)) == 1, "Page of track's are unexpected ")
    }
    
    func testViewModelCompareEqual() {
        let model_0 = TrackViewModel(id: 0, track: Track(artistId: 0, trackId: 0, artistName: "A"))
        let model_same0 = TrackViewModel(id: 0, track: Track(artistId: 0, trackId: 0, artistName: "B"))
        XCTAssertTrue(model_0 == model_same0, "models unequal ")
    }
    
    func testViewModelCompareUnequal() {
        let model_0 = TrackViewModel(id: 0, track: Track(artistId: 0, trackId: 0, artistName: "A"))
        let model_unequal0 = TrackViewModel(id: 1, track: Track(artistId: 0, trackId: 0, artistName: "B"))
        XCTAssertTrue(model_0 != model_unequal0, "models equal ")
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
