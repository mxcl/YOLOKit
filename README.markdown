YOLOKit
=======
Friends don’t let friends use APIs designed thirty years ago.

Let’s use categories, let’s make new classes, let’s use modern design patterns.

Chainable, Dot-notated, Ruby-style Enumeration
==============================================
YOLOKit offers a novel way to do Ruby-style enumeration in Objective-C. Here’s a
real-world example taken from the [Popular Pays](http://popularpays.com)
codebase:

```objc
campaigns.reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pick(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

Versus:

```objc
[[[[campaigns reject:^(PPCampaign *campaign) {
    return campaign.locked;
}] pick:@"venues"] flatten] each:^(PPVenue *venue) {
    [geofencer startMonitoringForRegion:venue.region];
}];
```

*I prefer the former, but if you don’t then you’ll be pleased to hear that
YOLOKit offers **both** styles.*

Or, in 2002 (fast enumeration is recent!) style:

```objc
for (PPCampaign *campaign in campaigns) {
    if (!campaign.locked) {
        for (PPVenue *venue in campaign.venues) {
            [geofencer startMonitoringForRegion:venue.region];
        }
    }
}
```

Nesting square-brackets is very objective-C, but it's also so very 1983 and
it’s (let’s be honest) not very readable. You only live once, so let’s be
modern, let's make iterating over data easy, delightful, productive and awesome.

Using via CocoaPods
===================
In your Podfile:

    pod 'YOLOKit', :podspec => 'https://raw.github.com/mxcl/YOLOKit/master/Podspec'

Git Submodule Usage
===================
If you must.

    git submodule init
    git submodule add https://github.com/mxcl/YOLOCategories


License
=======
I, Max Howell the copyright holder of this work, hereby release it into the
public domain. This applies worldwide.

In case this is not legally possible, I grant any entity the right to use this
work for any purpose, without any conditions, unless such conditions are
required by law.
