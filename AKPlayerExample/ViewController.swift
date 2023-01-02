//
//  ViewController.swift
//  AKPlayerExample
//
//  Created by Amit Garg on 30/12/22.
//

import UIKit
import AVKit
class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loader:UIActivityIndicatorView!
    var asset: AKAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AKPlayer.shared.getAssetForID("9eur33jr38") { [weak self] asset, _ in
            self?.loader.stopAnimating()
            guard let asset else { return }
            self?.asset = asset
            self?.button.isEnabled = true
        }
    }
    
    @IBAction func playVideo() {
        guard let asset else { return }
        loader.startAnimating()
        AKPlayer.shared.play(asset) { [weak self] player, _ in
            self?.loader.stopAnimating()
            guard let player else {
                return
            }
            self?.showPlayer(player)
        }
    }
    
    func showPlayer(_ player: AVPlayer) {
        let controller = AVPlayerViewController()
        controller.player = player
        self.present(controller, animated: true) {
            DispatchQueue.main.async {
                player.play()
            }
        }
    }


}

