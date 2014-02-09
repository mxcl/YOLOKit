YOLOKit
=======
YOLOKit is a delightful library for enumerating Foundation.

Friends don’t let friends use APIs designed thirty years ago. Let’s use
categories, let’s make new classes, let’s use modern design patterns.


Chainable, Dot-notated, Ruby-like Enumeration
---------------------------------------------
For example:

```objc
#import "YOLO.h"

//…

campaigns.reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

Many people have done Ruby-like enumeration for Objective-C. It’s not a new
thing. Just search CocoaPods. But everyone else did it with square bracket
syntax. Square bracket syntax is not conducive to chaining. Ruby-like
enumeration (practically) demands chaining. So we figured out how to do it with
dot-notation. You’re welcome.

We have also tried to add iOS/Objective-C niceties, and additional function to make
up for various shortcomings.

###NSArray.map()
```objc
id rv = @[@1, @2, @3, @4].map(^(NSNumber *n){
    return @(n.intValue^2);
});
// rv => @[@1, @4, @9, @16]
```

Notably, if you return nil, we don’t insert `NSNull` (we can’t insert nil),
we just return an array with one less element.

###NSArray.select()
```objc
id rv = @[@1, @2, @3, @4].select(^BOOL(NSNumber *n){
    return n.intValue % 2 == 0;
});
// rv => @[@2, @4]
```

###NSArray.reject()
```objc
id rv = @[@1, @2, @3, @4].reject(^BOOL(NSNumber *n){
    return n.intValue % 2 == 0;
});
// rv => @[@1, @3]
```

###NSArray.each()
```objc
__block NSMutableArray *rv = @[].mutableCopy;
@[@1, @2, @3, @4].each(^(NSNumber *n){
    rv.unshift(n);
});
// rv => @[@4, @3, @2, @1]
```

###NSArray.each_with_index()
```objc
__block NSMutableDictionary *rv = @{}.mutableCopy;
@[@4, @3, @2, @1].each_with_index(^(id n, uint ii){
    rv[n] = @(ii^2);
});
// rv => @{@1: @16, @2: @9, @3: @4, @4: @1}
```

Note, the above example would be better produced with *inject*.

###NSArray.reduce()
```objc
id rv = @[@1, @2, @3, @4].reduce(^(NSNumber *memo, NSNumber *n){
    return @(memo.intValue + n.intValue);
});
// rv => @10
```

###NSArray.inject()
```objc
id rv = @[@1, @2, @3, @4].inject(@{}, ^(NSDictionary *memo, NSNumber *n){
    memo[n] = @(n.intValue ^ 2);
    return memo;
});
// rv => @{@1: @1, @2: @4, @3: @9, @4: @16}
```

###NSArray.flatten
```objc
id rv = @[@[@1, @2], @3, @[@4]].flatten

// rv => @[@1, @2, @3, @4]
```

###NSArray.min()
```objc
id rv = @[@4, @2, @1, @3].min(^int(NSNumber *n){
    return n.intValue;
});
// rv => @1

id rv = @[@4, @2, @1, @3].min(^int(NSNumber *n){
    return (n.intValue - 3) ^ 2;
});
// rv => @3
```

###NSArray.max()
```objc
id rv = @[@4, @2, @1, @3].max(^int(NSNumber *n){
    return n.intValue;
});
// rv => @4

id rv = @[@4, @2, @1, @3].max(^int(NSNumber *n){
    return (n.intValue - 3) ^ 2;
});
// rv => @1
```

###NSArray.find()
```objc
id rv = @[@1, @2, @3, @4].find(^(id n){
    return [n isEqual:@3];
});
// rv => @3
```

###NSArray.index_of()
```objc
uint rv = @[@1, @2, @3, @4].index_of(@2)

// rv => 2
```

###NSArray.flat_map()
```objc
id rv = @[@1, @2, @3, @4].flat_map(^(id n){
    return @[n, @[n]];
});
// rv => @[@1, @[@1], @2, @[@2], @3, @[@3], @4, @[@4]]
```

Useful over vanilla `map` followed by a `flatten` because `flatten` is
recursive, and you may want to preserve array relationships beyond the first
level.

###NSArray.group_by()
```objc
id rv = @[@1, @2, @3, @4].group_by(^(NSNumber *n) {
    return @(n.intValue % 2);
});
// rv => @{@0: @[@1, @3], @1: @[@2, @4]}
```

###NSArray.sort_by()
```objc
id rv = @[@[@2], @[@1]].sort_by(^(id a){
    return a[0];
});
// rv => @[@[@1], @[@2]]

MKShape *shape1 = [MKShape new]; shape1.title = @"foo";
MKShape *shape2 = [MKShape new]; shape2.title = @"bar";
id rv = @[shape1, shape2].sort_by(@"title")

rv => @[shape2, shape1]
```

###NSArray.sort
```objc
id rv = @[@2, @1, @3, @5, @4].sort

// rv => @[@1, @2, @3, @4, @5]
```

###NSArray.pluck()
```objc
MKShape *shape1 = [MKShape new]; shape1.title = @"shape 1";
MKShape *shape2 = [MKShape new]; shape2.title = @"shape 2";

id rv = @[shape1, shape2].pluck(@"title")
// rv => @[@"shape 1", @"shape 2"]

id rv = @[shape1, shape2].pluck(@"title.uppcaseString")
// rv => @[@"SHAPE 1", @"SHAPE 2"]

id rv = @[@1, @"1", shape1].pluck(NSNumber.class)
// rv => @[@1]

```

###NSArray.uniq
```objc
id rv = @[@1, @1, @2].uniq;

// rv => @[@1, @2]
```

###NSArray.concat()
```objc
id rv = @[@1, @2].concat(@[@3, @4]);

// rv => @[@1, @2, @3, @4]
```

###NSArray.slice()
```objc
NSArray *nums = @[@1, @2, @3, @4, @5, @6];
id yolo = nums.first(2).concat(nums.slice(4,-1));

// yolo => @[@1, @2, @5, @6]
// lolo => [nums subArrayWithRange:NSMakeRange(0, 2)] arrayByAppendingArray:[nums subArrayWithRange:NSMakeRange(4, campaigns.count-4)]];
```

###NSArray.first()
```objc
id rv = @[@1, @2, @3, @4, @5, @6].first(2);

// rv => @[@1, @2]
```

###NSArray.last()
```objc
id rv = @[@1, @2, @3, @4, @5, @6].last(2);

// rv => @[@5, @6]
```

###NSArray.reverse
```objc
id rv = @[@1, @2, @3, @4].reverse;

// rv => @[@4, @3, @2, @1]
```

###NSArray.join
```objc
id rv = @[@1, @2, @3, @4].join;

// rv => @"1234"
```

###NSArray.transpose
```objc
id rv = @[@[@1, @2, @3], @[@4, @5, @6]].tranpose;

// rv => @[@[@1, @4], @[@2, @5], @[@3, @6]]
```

###NSArray.shuffle
```objc
id rv = @[@1, @2, @3, @4, @5, @6].shuffle;

// rv => @[@2, @4, @5, @1, @3, @6]
```

###NSArray.sample
```objc
id rv = @[@1, @2, @3, @4, @5, @6].sample;

// rv => @5  // returns a random index
```

###NSArray.rotate()
```objc
id rv = @[@1, @2, @3, @4, @5, @6].rotate(2);

// rv => @[@3, @4, @5, @6, @1, @2]
```

###NSArray.without()
```objc
id rv = @[@1, @2, @3, @4, @5, @6].without(@2);

// rv => @[@1, @3, @4, @5, @6]

id rv = @[@1, @2, @3, @4, @5, @6].without(@[@2, @3]);

// rv => @[@1, @4, @5, @6]
```

###NSArray.set
```objc
id rv = @[@1, @1, @1, @1, @2, @1].set;

// rv => [NSSet setWithObjects:@1, @2, nil]
```

###NSArray.pmap
Map, but run in parallel. Obviously: be thread safe in your block. Doesn't
return until everything is done. Typically not worth using unless you have large
arrays since the overhead of thread-syncronization may be greater than the
parallel savings otherwise.

###NSArray.empty
```objc
BOOL rv = @[@1, @2].empty;

// rv => NO

BOOL rv = @[].empty;

// rv => YES
```

We picked `empty` rather than `is_empty` because of context. We almost always
use empty in an if statement, and there the form: `if (array.empty) {}` is
clear and reads more easily than `is_empty`. Small wins add up.

###NSDictionary.extend()
```objc
id rv = @{@1: @1, @2: @4}.extend(@{@1: @9, @10: @100});

// rv => @{@1: @9, @2: @4, @10: @100}
```

###NSNumber.upto()
```objc
id rv = @1.upto(6);

// rv => @[@1, @2, @3, @4, @5, @6]
```

###NSString.split()
```objc
id rv = @"1,2,3,4,5,6".split(@",")

// rv => @[@1, @2, @3, @4, @5, @6]
```

Real World Example
------------------
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

YOLOKit Forgives You
--------------------
YOLOKit assumes you'd rather not have crashes. Whenever possible it will behave
defensively. Eg. if you ask for `slice(0, 3)` and the array only has 2 items, it
will return as though you called `slice(0, 2)`.

We are writing iPhone apps. Not space shuttle control modules.

Caveats
-------
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

Contribution
------------
I have implemented most of Ruby’s Enumerable and Ruby’s Array and some bits from
Underscore, and some new stuff. Feel free to fill in the gaps. I am not too keen
on importing all the aliases and have tried to pick the one Ruby should have
chosen in the first place (IMO).

Contributions welcome and highly desired.

Importing YOLOKit
-----------------

    pod 'YOLOKit'

License
-------
I, Max Howell the copyright holder of this work, hereby release it into the
public domain. This applies worldwide.

In case this is not legally possible, I grant any entity the right to use this
work for any purpose, without any conditions, unless such conditions are
required by law.
