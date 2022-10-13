//
//  Notifivation+Name.swift
//  iTuneStoreSearchMusic
//
//  Created by Thomas Leonhardt on 11.10.22.
//

import Foundation

public extension Notification.Name {
    static let requestDidFinish = Notification.Name("requestDidFinish")
    static let requestDidError  = Notification.Name("requestDidError")
    static let tracksLoaded     = Notification.Name("tracksLoaded")
}
