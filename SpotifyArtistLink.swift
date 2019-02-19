//
//  SpotifyArtistLink.swift
//  SpotifyKit
//
//  Created by Isom,Grant on 2/19/19.
//

import Foundation

public struct SpotifyArtistLink: SpotifySearchItem {
    public var id:   String
    public var uri:  String
    public var name: String
    
    public static let type: SpotifyItemType = .artist
}
