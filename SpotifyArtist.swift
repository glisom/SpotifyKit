//
//  SpotifyArtist.swift
//  SpotifyKit
//
//  Created by Isom,Grant on 2/19/19.
//

import Foundation

public struct SpotifyArtist: SpotifySearchItem {
    public var id:   String
    public var uri:  String
    public var name: String
    
    var images: [SpotifyImage]
    
    public var artUri: String {
        return images.first?.url ?? ""
    }
    
    public static let type: SpotifyItemType = .artist
}
