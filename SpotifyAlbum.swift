//
//  SpotifyAlbum.swift
//  SpotifyKit
//
//  Created by Isom,Grant on 2/19/19.
//

import Foundation

public struct SpotifyAlbum: SpotifySearchItem, SpotifyLibraryItem, SpotifyTrackCollection {
    struct Tracks: Decodable {
        var items: [SpotifyTrack]
    }
    
    struct Image: Decodable {
        var url: String
    }
    
    public var id:   String
    public var uri:  String
    public var name: String
    
    // Track list is contained only in full album objects
    var tracks: Tracks?
    
    public var collectionTracks: [SpotifyTrack]? {
        return tracks?.items
    }
    
    public static let type: SpotifyItemType = .album
    
    var images  = [Image]()
    var artists = [SpotifyArtist]()
    
    public var artist: SpotifyArtist {
        return artists.first!
    }
    
    public var artUri: String {
        return images.first!.url
    }
}
