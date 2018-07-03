# AppNexusTVOSSDK Playground

This repo contains the result of testing the usage of the framework AppNexusTVOSSDK in playground mode...

### Notes v2.0.7:
- The framework does not load any Ad, and it prints the following [error logs](error_v2_0_7.log)
- There is a typo in the log `"appnexus vmap parser initalized"` should be `""appnexus vmap parser initialized"`
- The following methods are documented as optionals but they are not actually declared as @optional in AdControllerProtocol, so they are actually required: 

```
func adPlaybackControllerDidRaiseAnError(adSlot: AdSlot?, result: ANTVErrorProtocol?) 
func adPlaybackControllerDidNotifyAnEvent(adSlot: AdSlot?, event: VideoEvent?, data: String?) 
func adPlaybackControllerDidNotifyAdSlotEnded(adSlot: AdSlot?)
```
### Notes v1.0.8:
- The framework seems to be connecting to unsecure domains:

   It inially connects to `http://ib.adnxs.com` during setUp. But setting a TLS exception for that specific domain is not enought. The only way to get it running that I found was to define `Allow arbitrary connections` in Info.plist.

- Console is full of logs, even when running in `Release` mode, which might have some impact in performance. I did not find a way to make it less verbose.
- High risk of App rejection: While showing the Ad, unless isSkippable is defined as true, the App does not react to the Menu key in Siri Remote.
- The framework exposes some public properties for customization: `adText`, `fontColor`, `backgroundColor`, etc... But they are all defined as constant, so the layout can not be actually customized.
- When the player has modal ViewController presented over it, the ads are presented over the modal.
- There is no method to pause. So when presenting another player for a different content, the Ad can still be listened on the background while the new content is played.
- To check, how is the framework managing the changes in the rate of the bound AVPlayer? what happens when having a KVO to "rate" keeping track of the player status?

### Crashes:
1. When the playing stream finishes the framework crashes. [Crash logs](crash1.log)
2. Random crash when playing live streams. [Crash logs](crash2.log)

