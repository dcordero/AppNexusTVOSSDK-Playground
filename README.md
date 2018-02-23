# AppNexusTVOSSDK Playground

This repo contains the result of testing the usage of the framework AppNexusTVOSSDK in playground mode...

### Notes:
- The framework seems to be connecting to unsecure domains:

   It inially connects to `http://ib.adnxs.com` during setUp. But setting a TLS exception for that specific domain is not enought. The only way to get it running that I found was to define `Allow arbitrary connections` in Info.plist.
   
- Console is full of logs, even when running in `Release` mode, which might have some impact in performance. I did not find a way to make it less verbose.
- The framework exposes some public properties for customization: `adText`, `fontColor`, `backgroundColor`, etc... But they are all defined as constant, so the layout can not be actually customized.
- Some logs regarding TVJS appears in the console. To check: is there any conflict with the js application context when using the framework in an hybrid (TVMLKit+UIKit) application?
- To check, how is the framework managing the changes in the rate of the bound AVPlayer? what happens when having a KVO to "rate" keeping track of the player status?
- To check, what happens with the ads when having modals presented over the player?
- To check, what data is the SDK sending? (check with Charles proxy)

### Crashes:
1. When the playing stream finishes the framework crashes. [Crash logs](crash1.log)
2. Random crash on play. [Crash logs](crash2.log)

