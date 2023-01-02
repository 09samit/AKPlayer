import Foundation
import AVFoundation

public typealias AKAssetsHandler = ((AKAsset?, AKError?) -> Void)

public typealias AKPlayerHandler = ((AVPlayer?, AKError?) -> Void)

public enum AKError: Error {
    case noURLError
    case unknown(String)
}

public struct AKPlayer {
    
    public static let shared = AKPlayer()
    
    private init() {}
    
    public func getAssetForID(_ id: String, block: @escaping AKAssetsHandler) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let asset = AKAsset(url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
            block(asset, nil)
        }
    }
    
    public func play(_ asset: AKAsset, block: @escaping AKPlayerHandler) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let url = URL(string:  asset.url) else {
                block(nil, AKError.noURLError)
                return
            }
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVQueuePlayer(items: [playerItem])
            block(player, nil)
        }
    }
}
