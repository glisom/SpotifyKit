//
//  SpotifyPlaylist.swift
//  SpotifyKit
//
//  Created by Isom,Grant on 2/19/19.
//

import Foundation

public struct SpotifyPlaylist: SpotifySearchItem, SpotifyLibraryItem, SpotifyTrackCollection {
    struct Tracks: Decodable {
        struct Item: Decodable {
            var track: SpotifyTrack
        }
        
        var total: Int
        
        // Track list is contained only in full playlist objects
        var items: [Item]?
    }
    
    public var id:   String
    public var uri:  String
    public var name: String
    
    var tracks: Tracks
    
    public var collectionTracks: [SpotifyTrack]? {
        return tracks.items?.map { $0.track }
    }
    
    public var count: Int {
        return tracks.total
    }
    
    var images: [SpotifyImage]
    
    public var artUri: String {
        return images.first?.url ?? ""
    }
    
    public static let type: SpotifyItemType = .playlist
}
