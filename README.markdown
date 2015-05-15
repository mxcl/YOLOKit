Enough with the bazillion lines of array parsing logic. YOLO.

```objc
@import YOLOKit;

campaigns.reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

* YOLOKit is completely modular, if you only want `map` then only have `map`: `pod "YOLOKit/map"`
* YOLOKit is thorough, well-tested and inside apps on the store
* Every single method in YOLOKit was carefully considered; every detail poured over. YOLOKit is not just a direct port of *Ruby’s Enumerable* or *Underscore*, it is a *delightful* implementation inspired by such but designed for your needs as an iOS developer.

YOLOKit is thoroughly documented at http://mxcl.github.io/YOLOKit/.


[![Join the chat at https://gitter.im/mxcl/YOLOKit](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/mxcl/YOLOKit?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)