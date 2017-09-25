//
//  AppDelegate.swift
//  Mac Demo
//
//  Created by Marco Albera on 16/09/2017.
//

import Cocoa
import Swiftify

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    let swiftify = SwiftifyHelper(with:
        SwiftifyHelper.SpotifyDeveloperApplication(
            clientId:     "64961bd35af24dd4862ae29e0a8f5caa",
            clientSecret: "8d6ec5ba180b4114b4212bcd618bf6ad",
            redirectUri:  "swiftifymac://callback"
        )
    )
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initEventManager()
        
        loadSwiftify()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.find(SpotifyTrack.self, "concrete heartbeat")
            self.library(SpotifyPlaylist.self)
            self.get(SpotifyAlbum.self, id: "4IKyYu9zNndBVpi8FoekaS")
            self.isSaved("5FTCKvxzqy72ceS4Ujux4N")
            //self.save("5FTCKvxzqy72ceS4Ujux4N")
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) { }
    
    func loadSwiftify() {
        if !swiftify.hasToken {
            // Try to authenticate if there's no token
            swiftify.authorize()
        } else {
            // Refresh the token if present
            swiftify.refreshToken { refreshed in }
        }
    }
    
    // MARK: URL handling
    
    func initEventManager() {
        NSAppleEventManager.shared().setEventHandler(self,
                                                     andSelector: #selector(handleURLEvent),
                                                     forEventClass: AEEventClass(kInternetEventClass),
                                                     andEventID: AEEventID(kAEGetURL))
    }
    
    /**
     Catches URLs with specific prefix ("muse://")
     */
    @objc func handleURLEvent(event: NSAppleEventDescriptor,
                              replyEvent: NSAppleEventDescriptor) {
        if  let descriptor = event.paramDescriptor(forKeyword: keyDirectObject),
            let urlString  = descriptor.stringValue,
            let url        = URL(string: urlString) {
            swiftify.saveToken(from: url)
        }
    }
    
    // MARK: Swiftify features implementation
    
    func get<T>(_ type: T.Type, id: String, playlistUserId: String? = nil) where T: SpotifySearchItem {
        swiftify.get(type, id: id) { result in
            print("Got: \(result)")
            
            if let collection = result as? SpotifyTrackCollection {
                print("Tracks: \(collection.collectionTracks)")
            }
        }
    }
    
    func find<T>(_ type: T.Type, _ keyword: String) where T: SpotifySearchItem {
        swiftify.find(type, keyword) { result in
            print(result)
        }
    }
    
    func library<T>(_ type: T.Type) where T: SpotifyLibraryItem {
        swiftify.library(type) { result in
            print(result)
        }
    }
    
    func isSaved(_ trackId: String) {
        swiftify.isSaved(trackId: trackId) { saved in
            print("Track \(trackId) saved: \(saved)")
        }
    }
    
    func save(_ trackId: String) {
        swiftify.save(trackId: trackId) { saved in
            print("Track \(trackId) saved: \(saved)")
        }
    }
    
    func delete(_ trackId: String) {
        swiftify.delete(trackId: trackId) { saved in
            print("Track \(trackId) deleted: \(saved)")
        }
    }
}

