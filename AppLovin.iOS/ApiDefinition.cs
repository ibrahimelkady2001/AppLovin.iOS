using System;
using Foundation;
using UIKit;

namespace AppLovin.iOS
{
	// @interface AppLovinSdkBindings : NSObject <MARewardedAdDelegate>
	[BaseType(typeof(NSObject))]
	interface AppLovinSdkBindings
	{
		// + (void)applovininitWithSdkkey:(NSString *)sdkkey;
		[Static]
		[Export("applovininitWithSdkkey:")]
		void ApplovininitWithSdkkey(string sdkkey);

		// + (void)ShowInterstitialAdWithAdid:(NSString *)adid;
		[Static]
		[Export("ShowInterstitialAdWithAdid:")]
		void ShowInterstitialAdWithAdid(string adid);

		// + (void)LoadRewardedAdWithAdidd:(NSString *)adidd;
		[Static]
		[Export("LoadRewardedAdWithAdidd:")]
		void LoadRewardedAdWithAdidd(string adidd);

		// + (void)LoadRewardedAdWithAdidd:(NSString *)adidd onLoaded:(void(^)(void))onLoaded onFailed:(void(^)(void))onFailed;
		[Static]
		[Export("LoadRewardedAdWithAdidd:onLoaded:onFailed:")]
		void LoadRewardedAdWithAdidd(string adidd, Action onLoaded, Action onFailed);

		// + (void)ShowRewardedAdWithAdid:(NSString *)adid;
		[Static]
		[Export("ShowRewardedAdWithAdid:")]
		void ShowRewardedAdWithAdid(string adid);

		// + (NSNumber *)RewardedAdLoaded;
		[Static]
		[Export("RewardedAdLoaded")]
		NSNumber RewardedAdLoaded();

		// + (UIView *)getBannerWithAdid:(NSString *)adid;
		[Static]
		[Export("getBannerWithAdid:")]
		UIView GetBannerWithAdid(string adid);

		// + (void)LoadBannerWithView:(UIView *)view;
		[Static]
		[Export("LoadBannerWithView:")]
		void LoadBannerWithView(UIView view);

		// + (void)ShowAppOpenAdWithAdid:(NSString *)adid;
		[Static]
		[Export("ShowAppOpenAdWithAdid:")]
		void ShowAppOpenAdWithAdid(string adid);

		// + (void)ShowMeditationDebugger;
		[Static]
		[Export("ShowMeditationDebugger")]
		void ShowMeditationDebugger();
	}
}
