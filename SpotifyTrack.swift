//
//  SpotifyTrack.swift
//  SpotifyKit
//
//  Created by Isom,Grant on 2/19/19.
//

import Foundation

public struct SpotifyTrack: SpotifySearchItem, SpotifyLibraryItem {
    public var id:    String
    public var uri:   String
    public var name:  String
    
    // Simplified track objects don't contain album reference
    // so it should be an optional
    public var album: SpotifyAlbum?
    
    public static let type: SpotifyItemType = .track
    
    var artists = [SpotifyArtist]()
    
    public var artist: SpotifyArtist {
        return artists.first!
    }
}
