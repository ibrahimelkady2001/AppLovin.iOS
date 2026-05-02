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

```csharp
AppLovinSdkBindings.ShowInterstitialAdWithAdid("YOUR_AD_UNIT_ID");
```

### Rewarded Ads

```csharp
AppLovinSdkBindings.LoadRewardedAdWithAdidd("YOUR_AD_UNIT_ID");

AppLovinSdkBindings.LoadRewardedAdWithAdidd(
    "YOUR_AD_UNIT_ID",
    () => Console.WriteLine("Ad loaded"),
    () => Console.WriteLine("Ad failed to load")
);
```

### Banner Ads

Use `AppLovinBanner` — a MAUI `View` subclass:

**XAML:**
```xml
xmlns:al="clr-namespace:AppLovin.iOS"
...
<al:AppLovinBanner AdUnitId="YOUR_AD_UNIT_ID" />
```

**Code-behind:**
```csharp
var banner = new AppLovinBanner { AdUnitId = "YOUR_AD_UNIT_ID" };
myLayout.Children.Add(banner);
```

### App Open Ads

```csharp
AppLovinSdkBindings.ShowAppOpenAdWithAdid("YOUR_AD_UNIT_ID");
```

### Mediation Debugger

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
