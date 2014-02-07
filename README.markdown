YOLOKit
=======
YOLOKit is a delightful library for enumerating Foundation.

Friends don’t let friends use APIs designed thirty years ago. Let’s use
categories, let’s make new classes, let’s use modern design patterns.


Chainable, Dot-notated, Ruby-style Enumeration
==============================================
YOLOKit offers dot-notated Ruby-style enumeration:

```objc
campaigns.reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

Versus:

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

Some Other Nice Examples
========================
From:

```objc
[campaigns subArrayWithRange:NSMakeRange(0, 2)] arrayByAppendingArray:[campaigns subArrayWithRange:NSMakeRange(4, campaigns.count-4)]];
```

To:

```objc
campaigns.first(2).concat(campaigns.slice(4,-1))
```

I don’t think I would have been happy with this code without YOLOKit:

```objc
id chicago = [[CLLocation alloc] initWithLatitude:41.905088 longitude:-87.670083];
id austin = [[CLLocation alloc] initWithLatitude:30.2500 longitude:-97.7500];

[PPAPI GET:@"/campaigns" success:^(NSArray *got) {
    id closest_city = @[chicago, austin].min(^(id city) {
        return [locationManager.location distanceFromLocation:city];
    });

    self.campaigns = got.group_by(^(PPCampaign *campaign) {
        return @[chicago, austin].min(^(id city) {
            return [campaign.location distanceFromLocation:city];
        });
    }).get(closest_city);
}];
```

Forgiving
=========
YOLOKit assumes you'd rather not have crashes. Whenever possible it will behave
defensively. Eg. if you ask for `slice(0, 3)` and the array only has 2 items, it
will return as though you called `slice(0, 2)`.

We are writing iPhone apps. Not space shuttle control modules.

Caveats
=======
Calling nil in block form crashes and doesn't just not happen as is
typical of the square bracket syntax. So… that sucks. So if it's possible your
*initial* object is nil you should do something like this:

```objc
(campaigns ?: @[]).reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

But we only live once, so why not:

```objc
if (campaigns) campaigns.reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

OMG we didn’t push ENTER! Kittens might die!!1!

Using via CocoaPods
===================
In your Podfile:

    pod 'YOLOKit'

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
