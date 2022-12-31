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
            let asset = AKAsset(url: "http://44.205.204.197/public/connect_assets/upload_images/1665173372.mov")
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
