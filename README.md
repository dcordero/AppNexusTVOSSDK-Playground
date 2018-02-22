# AppNexusTVOSSDK Playground

This repo contains the result of testing the usage of the framework AppNexusTVOSSDK in playground mode...

### Notes:
- The frameworks seems to be connecting to a unsecure domain (http://ib.adnxs.com). So, it requires to definition of an exception in TLS settings in the Info.plist.
- Console is full of logs, I did not find yet a way to make it less verbose. To check: is there sensitive information, as the tracking pset id, shown in the logs?
- Some logs regarding TVJS appears in the console. To check: is there any conflict with the js application context when using the framework in an hybrid (TVMLKit+UIKit) application?
- To check, how is the framework managing the changes in the rate of the bound AVPlayer? what happens when having a KVO to "rate" keeping track of the player status?
- To check, what happens with the ads when having modals presented over the player?
