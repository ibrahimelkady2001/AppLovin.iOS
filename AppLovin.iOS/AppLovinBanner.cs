using Microsoft.Maui.Handlers;
using UIKit;

namespace AppLovin.iOS;

public class AppLovinBannerHandler : ViewHandler<AppLovinBanner, UIView>
{
    public static PropertyMapper<AppLovinBanner, AppLovinBannerHandler> AppLovinBannerMapper =
        new(ViewMapper);

    public static CommandMapper<AppLovinBanner, AppLovinBannerHandler> AppLovinBannerCommandMapper =
        new(ViewCommandMapper);

    public AppLovinBannerHandler() : base(AppLovinBannerMapper, AppLovinBannerCommandMapper)
    {
    }

    protected override UIView CreatePlatformView()
    {
        return AppLovinSdkBindings.GetBannerWithAdid(VirtualView.AdUnitId);
    }
}

public class AppLovinBanner : View
{
    public static readonly BindableProperty AdUnitIdProperty =
        BindableProperty.Create(nameof(AdUnitId), typeof(string), typeof(AppLovinBanner), string.Empty);

    public string AdUnitId
    {
        get => (string)GetValue(AdUnitIdProperty);
        set => SetValue(AdUnitIdProperty, value);
    }

    public AppLovinBanner()
    {
        ClassId = "ignore";
        if (Device.Idiom == TargetIdiom.Phone)
            MinimumHeightRequest = 50;
        else
            MinimumHeightRequest = 90;
        HorizontalOptions = LayoutOptions.FillAndExpand;

        Loaded += (s, e) =>
        {
            if (Handler?.PlatformView is UIView view)
                AppLovinSdkBindings.LoadBannerWithView(view);
        };
    }
}
