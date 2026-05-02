//
//  DotnetNewBinding.swift
//  NewBinding
//
//  Created by .NET MAUI team on 6/18/24.
//

import Foundation
import AppLovinSDK

@objc(DotnetNewBinding)
public class DotnetNewBinding : NSObject, MAAdDelegate, MARewardedAdDelegate
{
    // MARK: - Static state

    public static var  appOpenAd: MAAppOpenAd!
    public static var  interstitialAd: MAInterstitialAd!
    public static var  rewardedAd: MARewardedAd!
    public static var  Pause: Bool = false
    public static var  Rewarded: Bool = false
    public static var  binding = DotnetNewBinding()

    // Callbacks keyed by adUnitIdentifier — supports NormalId and ExpensiveId simultaneously
    private static var loadedCallbacks: [String: () -> Void] = [:]
    private static var failedCallbacks: [String: () -> Void] = [:]

    // MARK: - SDK init

    @objc
    public static func applovininit(sdkkey: String) {
        let initConfig = ALSdkInitializationConfiguration(sdkKey: sdkkey) { builder in
            builder.mediationProvider = ALMediationProviderMAX
        }
        ALSdk.shared().initialize(with: initConfig) { _ in }
    }

    // MARK: - Interstitial

    @objc
    public static func ShowInterstitialAd(adid: String) {
        DotnetNewBinding.interstitialAd = MAInterstitialAd(adUnitIdentifier: adid)
        DotnetNewBinding.interstitialAd.delegate = DotnetNewBinding.binding
        DotnetNewBinding.interstitialAd.load()
    }

    // MARK: - Rewarded

    // Legacy overload — no callbacks, kept for source compatibility with pages being retired
    @objc
    public static func LoadRewardedAd(adidd: String) {
        LoadRewardedAd(adidd: adidd, onLoaded: {}, onFailed: {})
    }

    @objc
    public static func LoadRewardedAd(adidd: String, onLoaded: @escaping () -> Void, onFailed: @escaping () -> Void) {
        DotnetNewBinding.loadedCallbacks[adidd] = onLoaded
        DotnetNewBinding.failedCallbacks[adidd] = onFailed
        let ad = MARewardedAd.shared(withAdUnitIdentifier: adidd)
        ad.delegate = DotnetNewBinding.binding
        ad.load()
        DotnetNewBinding.rewardedAd = ad
    }

    @objc
    public static func ShowRewardedAd(adid: String) {
        let ad = MARewardedAd.shared(withAdUnitIdentifier: adid)
        if ad.isReady { ad.show() }
    }

    @objc
    public static func RewardedAdLoaded() -> NSNumber {
        if let ad = DotnetNewBinding.rewardedAd {
            return NSNumber(value: ad.isReady)
        }
        return NSNumber(value: false)
    }

    // MARK: - Banner

    @objc
    public static func getBanner(adid: String) -> UIView {
        let adView = MAAdView(adUnitIdentifier: adid)
        adView.backgroundColor = UIColor.white
        return adView
    }

    @objc
    public static func LoadBanner(view: UIView) {
        if let ad = view as? MAAdView {
            ad.loadAd()
        }
    }

    // MARK: - App Open

    @objc
    public static func ShowAppOpenAd(adid: String) {
        DotnetNewBinding.appOpenAd = MAAppOpenAd(adUnitIdentifier: adid)
        DotnetNewBinding.appOpenAd.delegate = DotnetNewBinding.binding
        DotnetNewBinding.appOpenAd.load()
    }

    // MARK: - Mediation debugger

    @objc
    public static func ShowMeditationDebugger() {
        DispatchQueue.main.async {
            ALSdk.shared().showMediationDebugger()
        }
    }

    // MARK: - MAAdDelegate

    public func didLoad(_ ad: MAAd) {
        DispatchQueue.main.async {
            // App open ad — auto-show on load
            if let aoa = DotnetNewBinding.appOpenAd, aoa.isReady {
                aoa.show()
            }

            // Interstitial — auto-show on load
            if let inter = DotnetNewBinding.interstitialAd, inter.isReady {
                inter.show()
            }

            // Rewarded — call the stored callback; caller decides when to show
            if let cb = DotnetNewBinding.loadedCallbacks[ad.adUnitIdentifier] {
                DotnetNewBinding.loadedCallbacks.removeValue(forKey: ad.adUnitIdentifier)
                cb()
            }
        }
    }

    public func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
        if let cb = DotnetNewBinding.failedCallbacks[adUnitIdentifier] {
            DotnetNewBinding.failedCallbacks.removeValue(forKey: adUnitIdentifier)
            DotnetNewBinding.loadedCallbacks.removeValue(forKey: adUnitIdentifier)
            DispatchQueue.main.async { cb() }
        }
        DotnetNewBinding.Pause = true
    }

    public func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withErrorCode errorCode: Int) {
        if let cb = DotnetNewBinding.failedCallbacks[adUnitIdentifier] {
            DotnetNewBinding.failedCallbacks.removeValue(forKey: adUnitIdentifier)
            DotnetNewBinding.loadedCallbacks.removeValue(forKey: adUnitIdentifier)
            DispatchQueue.main.async { cb() }
        }
    }

    public func didFail(toDisplay ad: MAAd, withError error: MAError) {
        if let cb = DotnetNewBinding.failedCallbacks[ad.adUnitIdentifier] {
            DotnetNewBinding.failedCallbacks.removeValue(forKey: ad.adUnitIdentifier)
            DotnetNewBinding.loadedCallbacks.removeValue(forKey: ad.adUnitIdentifier)
            DispatchQueue.main.async { cb() }
        }
        DotnetNewBinding.Pause = true
    }

    public func didDisplay(_ ad: MAAd) {}

    public func didClick(_ ad: MAAd) {}

    public func didHide(_ ad: MAAd) {
        // "Rewarded" notification fires only after user earns the reward and ad closes
        if DotnetNewBinding.Rewarded {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Rewarded"), object: nil)
            DotnetNewBinding.Rewarded = false
        }
    }

    // MARK: - MARewardedAdDelegate

    public func didRewardUser(for ad: MAAd, with reward: MAReward) {
        DotnetNewBinding.Rewarded = true
    }
}
