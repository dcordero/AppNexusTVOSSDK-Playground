import AVKit
import AVFoundation
import UIKit
import ANTVSDK

private let appNexusPsetId = 8

class ViewController: UIViewController, AdControllerProtocol {

    private var playerContainerView: UIView!

    private var playerViewController: AVPlayerViewController!
    private var adController: AdController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpAppNexusSDK()
        
        setUpStreamToPlay(url: URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
        playerViewController.player?.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentDummyModalViewController()
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

    }

    func adPlaybackControllerDidNotifyAnEvent(adSlot: AdSlot?, event: VideoEvent?, data: String?) {

    }

    func adPlaybackControllerDidNotifyAdSlotEnded(adSlot: AdSlot?) {

    }

    func adPlaybackControllerShouldStartAd(adSlot: AdSlot?) -> Bool {
        return true
    }
        
    // MARK: - Private
    
    private func setUpView() {
        playerContainerView = UIView()
        playerContainerView.frame = view.bounds

        view.addSubview(playerContainerView)

        playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer()
        
        addChildViewController(playerViewController)
        playerViewController.view.frame = view.bounds
        playerContainerView.addSubview(playerViewController.view)
    }
    
    private func setUpAppNexusSDK() {
        adController = AdController()
        
        // This property allows skiping the Ad with a click in touch area of SiriRemote.
        // adPlaybackController.isSkippable = true
        
        adController.setup(appNexusPsetId: appNexusPsetId,
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
    
    private func presentDummyModalViewController() {
        let modalViewController = ModalViewController()
        modalViewController.modalPresentationStyle = .blurOverFullScreen
        present(modalViewController, animated: true, completion: nil)
    }
}
