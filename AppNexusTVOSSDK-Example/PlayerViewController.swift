import AVKit
import AVFoundation
import UIKit
import ANTVSDK

private let appNexusPsetId = 34

class PlayerViewController: UIViewController, AdControllerProtocol {

    @IBOutlet weak var playerContainerView: UIView!
    @IBOutlet weak var customOSDView: UIView!
    
    private var playerViewController: AVPlayerViewController!
    private var adController: AdController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpAppNexusSDK()
        
        setUpStreamToPlay(url: URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
    }
    
    deinit {
        print("I am never executed. AppNexusSDK is creating a retain cycle somewhere")
    }
    
    // MARK: - AdControllerProtocol

    func adPlaybackControllerDidSetup(adSlots: Array<AdSlot>?) {
        if adSlots != nil {
            adController.play()
        }
        else {
            print("Fatal Error");
        }
    }

    func adPlaybackControllerDidRaiseAnError(adSlot: AdSlot?, result: ANTVErrorProtocol?) {
        playerViewController?.player?.play()
    }

    func adPlaybackControllerDidNotifyAnEvent(adSlot: AdSlot?, event: VideoEvent?, data: String?) {

    }

    func adPlaybackControllerDidNotifyAdSlotEnded(adSlot: AdSlot?) {
        dismiss(animated: true, completion: nil)
    }

    func adPlaybackControllerShouldStartAd(adSlot: AdSlot?) -> Bool {
        return true
    }
        
    // MARK: - Private
    
    private func setUpView() {
        playerViewController = AVPlayerViewController()
        playerViewController.playbackControlsIncludeTransportBar = false
        playerViewController.player = AVPlayer()
        
        addChildViewController(playerViewController)
        playerViewController.view.frame = view.bounds
        playerContainerView.addSubview(playerViewController.view)
    }
    
    private func setUpAppNexusSDK() {
        adController = AdController()
        
        // This property allows skiping the Ad with a click in touch area of SiriRemote.
        // adPlaybackController.isSkippable = true
        
        adController.setup(appNexusPsetId: 34,
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
