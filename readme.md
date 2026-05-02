# AppLovin.iOS

.NET MAUI binding for the [AppLovin iOS SDK](https://www.applovin.com/). Supports interstitial, rewarded, banner, and app open ads.

## Installation

```
dotnet add package AppLovin.iOS
```

Only compatible with `net10.0-ios` projects.

## Setup

Initialize the SDK with your AppLovin SDK key (found in your AppLovin dashboard):

```csharp
using AppLovin.iOS;

AppLovinSdkBindings.ApplovininitWithSdkkey("YOUR_SDK_KEY");
```

Call this once at app startup, before loading any ads.

## Ad Types

### Interstitial Ads

Show full-screen interstitial ads:

```csharp
// Show an interstitial ad
AppLovinSdkBindings.ShowInterstitialAdWithAdid("YOUR_AD_UNIT_ID");
```

### Rewarded Ads

Load and show rewarded video ads with callbacks:

```csharp
// Load a rewarded ad
AppLovinSdkBindings.LoadRewardedAdWithAdidd("YOUR_AD_UNIT_ID");

// Load with completion callbacks
AppLovinSdkBindings.LoadRewardedAdWithAdidd(
    "YOUR_AD_UNIT_ID",
    () => Console.WriteLine("Ad loaded"),
    () => Console.WriteLine("Ad failed to load")
);

// Check if a rewarded ad is loaded
bool isLoaded = AppLovinSdkBindings.RewardedAdLoaded().BoolValue;

// Show the rewarded ad
AppLovinSdkBindings.ShowRewardedAdWithAdid("YOUR_AD_UNIT_ID");
```

### Banner Ads

Create and display banner ads (requires platform-specific code):

```csharp
// Create a banner view for a given ad unit
var bannerView = AppLovinSdkBindings.GetBannerWithAdid("YOUR_AD_UNIT_ID");
```

In a MAUI page, use `ContentView` with a `HandlerChanged` event to add the native banner:

```csharp
// XAML: <ContentView x:Name="bannerContainer" HeightRequest="50" />
bannerContainer.HandlerChanged += (s, e) =>
{
    if (bannerContainer.Handler?.PlatformView is UIKit.UIView parentView)
    {
        var adView = AppLovinSdkBindings.GetBannerWithAdid("YOUR_AD_UNIT_ID");
        parentView.AddSubview(adView);
        AppLovinSdkBindings.LoadBannerWithView(adView);
    }
};
```

### App Open Ads

Show app open / splash ads:

```csharp
AppLovinSdkBindings.ShowAppOpenAdWithAdid("YOUR_AD_UNIT_ID");
```

### Mediation Debugger

Display the mediation debugger for testing:

```csharp
AppLovinSdkBindings.ShowMeditationDebugger();
```

## Requirements

- .NET 10+
- iOS 15.0+
- Xcode 16+

---

<p align="center">
  <a href="https://paypal.me/ibrahimelkady1">
    <img src="https://raw.githubusercontent.com/stefan-niedermann/paypal-donate-button/master/paypal-donate-button.png" alt="Donate with PayPal" height="48">
  </a>
  <br>
  <sub>If this project helped you, consider supporting my work ❤️</sub>
</p>
