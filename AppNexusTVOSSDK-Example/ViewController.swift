import AVKit
import AVFoundation
import UIKit
import ANTVSDK

private let appNexusPsetId = 8

class ViewController: UIViewController, VMAPPlaybackControllerProtocol {

    private var playerViewController: AVPlayerViewController!
    private var adPlaybackController: VMAPPlaybackController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpAppNexusSDK()
        
        setUpStreamToPlay(url: URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
    }
    
    // MARK: - VMAPPlaybackControllerProtocol
    
    func adPlaybackControllerDidPrepare(result: Bool) {
        if result {
            adPlaybackController?.play()
        } else {
            playerViewController.player?.play()
        }
    }
        
    // MARK: - Private
    
    private func setUpView() {
        playerViewController = AVPlayerViewController()
        playerViewController.view.frame = view.bounds
        playerViewController.player = AVPlayer()
        
        addChildViewController(playerViewController)
        view.addSubview(playerViewController.view)
    }
    
    private func setUpAppNexusSDK() {
        adPlaybackController = VMAPPlaybackController()
        
        // This property allows skiping the Ad with a click in touch area of SiriRemote.
        adPlaybackController.isSkippable = true
        
        adPlaybackController.setup(appNexusPsetId: appNexusPsetId,
                                   contentVideoPlayerViewController: playerViewController,
                                   contentVideoPlayer: playerViewController.player!,
                                   contentUIViewController: self,
                                   delegate: self)
    }
    
    private func setUpStreamToPlay(url: URL) {
        let asset = AVURLAsset(url: url, options: nil)
        let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: nil)
        playerViewController?.player?.replaceCurrentItem(with: playerItem)
    }
}
