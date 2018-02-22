# AppNexusTVOSSDK Playground

This repo contains the result of testing the usage of the framework AppNexusTVOSSDK in playground mode...

### Notes:
- The frameworks seems to be connecting to unsecure domains:
   It inially connects to `http://ib.adnxs.com` during setUp. But setting a TLS exception for that specific domain is not even enought. The only way to get it running that I found was to define `Allow arbitrary connections` in Info.plist.
- Console is full of logs, even when running in `Release` mode, which might have implact in performance. I did not find a way to make it less verbose.
- The frameworks exposes some public properties for customization: `adText`, `fontColor`, `backgroundColor`, etc... But they are all defined as constant, so the layout can not be actually customized.
- Some logs regarding TVJS appears in the console. To check: is there any conflict with the js application context when using the framework in an hybrid (TVMLKit+UIKit) application?
- To check, how is the framework managing the changes in the rate of the bound AVPlayer? what happens when having a KVO to "rate" keeping track of the player status?
- To check, what happens with the ads when having modals presented over the player?
- To check, what data is the SDK sending? (check with Charles proxy)

### Crash:
When the playing stream finishes the frameworks crashes. Backlog:

```
[...]
[ANTVSDK] current time : 55.000870644
[ANTVSDK] current time : 56.001293961
[ANTVSDK] current time : 57.000805806
[ANTVSDK] current time : 58.001277114
[ANTVSDK] current time : 59.000103403
[ANTVSDK] current time : 60.000576031
call show ad
show ad #60
pod #0 playing
2018-02-22 14:40:39.939909+0100 AppNexusTVOSSDK-Example[76306:987040] [aqme] 755: MEMixerChannel::EnableProcessor: failed to open processor type 0x705f6571
[ANTVSDK] current time : 60.0226777777778
ignore ad because ad is already started
maxIndex: 0
ad done
2018-02-22 14:41:18.284308+0100 AppNexusTVOSSDK-Example[76306:984472] -[AppNexusTVOSSDK_Example.ViewController adPlaybackControllerDidFinishAdBreakWithResult:]: unrecognized selector sent to instance 0x7f849cd0a4f0
2018-02-22 14:41:18.303226+0100 AppNexusTVOSSDK-Example[76306:984472] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[AppNexusTVOSSDK_Example.ViewController adPlaybackControllerDidFinishAdBreakWithResult:]: unrecognized selector sent to instance 0x7f849cd0a4f0'
*** First throw call stack:
(
0   CoreFoundation                      0x000000010bd9594b __exceptionPreprocess + 171
1   libobjc.A.dylib                     0x0000000107f56f41 objc_exception_throw + 48
2   CoreFoundation                      0x000000010be16434 -[NSObject(NSObject) doesNotRecognizeSelector:] + 132
3   CoreFoundation                      0x000000010bd184f8 ___forwarding___ + 760
4   CoreFoundation                      0x000000010bd18178 _CF_forwarding_prep_0 + 120
5   ANTVSDK                             0x00000001078a4d14 _T07ANTVSDK22VMAPPlaybackControllerC6showAdySi9adBreakNo_Si03podH0s10DictionaryVySiSaySo8AVPlayerCGG0F11PlayerArraySo0k4ViewC0CSg07contentnC0AJSg0o5VideoL0So6UIViewC4viewtFySC6CMTimeVcfU_Tf4dgnngnggg_n + 4100
6   ANTVSDK                             0x000000010789215f _T07ANTVSDK22VMAPPlaybackControllerC6showAdySi9adBreakNo_Si03podH0s10DictionaryVySiSaySo8AVPlayerCGG0F11PlayerArraySo0k4ViewC0CSg07contentnC0AJSg0o5VideoL0So6UIViewC4viewtFySC6CMTimeVcfU_ + 63
7   ANTVSDK                             0x00000001078a59ac _T07ANTVSDK22VMAPPlaybackControllerC6showAdySi9adBreakNo_Si03podH0s10DictionaryVySiSaySo8AVPlayerCGG0F11PlayerArraySo0k4ViewC0CSg07contentnC0AJSg0o5VideoL0So6UIViewC4viewtFySC6CMTimeVcfU_TA + 188
8   ANTVSDK                             0x0000000107891fb6 _T0SC6CMTimeVIxy_ABIyBy_TR + 70
9   AVFoundation                        0x000000010881c741 -[AVPeriodicTimebaseObserver _fireBlockForTime:] + 64
10  AVFoundation                        0x000000010881c867 -[AVPeriodicTimebaseObserver _effectiveRateChanged] + 288
11  AVFoundation                        0x000000010881e118 __AVTimebaseObserver_timebaseNotificationCallback_block_invoke + 126
12  libdispatch.dylib                   0x000000010db542f7 _dispatch_call_block_and_release + 12
13  libdispatch.dylib                   0x000000010db5533d _dispatch_client_callout + 8
14  libdispatch.dylib                   0x000000010db605f9 _dispatch_main_queue_callback_4CF + 628
15  CoreFoundation                      0x000000010bd58659 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
16  CoreFoundation                      0x000000010bd1cc82 __CFRunLoopRun + 2402
17  CoreFoundation                      0x000000010bd1c0a9 CFRunLoopRunSpecific + 409
18  GraphicsServices                    0x00000001100ef9c6 GSEventRunModal + 62
19  UIKit                               0x0000000109ea9f74 UIApplicationMain + 159
20  AppNexusTVOSSDK-Example             0x0000000107593d40 main + 48
21  libdyld.dylib                       0x000000010dbd21e5 start + 1
)
libc++abi.dylib: terminating with uncaught exception of type NSException
```
