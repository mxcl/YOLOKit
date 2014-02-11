YOLOKit
=======
YOLOKit is a delightful library for enumerating Foundation objects.

You only live once: let’s code expressively.


Chainable, Dot-notated, Ruby-like Enumeration
---------------------------------------------
For example:

```objc
#import "YOLO.h"

campaigns.reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

Many people have done Ruby-like enumeration for Objective-C. It’s not a new
thing: just search CocoaPods. But everyone else did it with square bracket
syntax. Square bracket syntax is not conducive to chaining. Ruby-like
enumeration (practically) demands chaining. So we figured out how to do it with
dot-notation: and using it *feels great*.

We have also have tried to add a few iOS/Objective-C specific niceties and
methods that make up for various shortcomings in our platform.

However, we believe in a **lean-library** approach and will resist bloat. Hence our string functions are as minimal as possible and concerned with enumeration
only.

YOLOKit is thorough, well-tested and inside apps on the store.


YOLOKit is Forgiving
--------------------
YOLOKit assumes you’d rather not have crashes. Whenever possible it will behave
defensively, eg. if you ask for `slice(0, 3)` and the array only has 2 items, it
will return `slice(0, 2)`.

We are writing iPhone apps. Not space shuttle control modules.


Importing YOLOKit
-----------------

    pod 'YOLOKit'


Complete Method Index
=====================

###NSArray.map()
```objc
id rv = @[@1, @2, @3, @4].map(^(NSNumber *n){
    return @(n.intValue^2);
});
// rv => @[@1, @4, @9, @16]
```

Notably, if you return nil, we skip that element in the returned array.
Justification:

1. We can’t add nil to NSArray
2. We could add NSNull instead, but then we’d be crashy and *YOLOKit is forgiving*
3. In Objective-C calling a method on nil returns nil. When enumerating an array
   this is equivalent to just skipping that element. Hence: we skip the element.

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

Order is preserved.

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

Negative indexes count from the array end. `-1` is the last item.

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

id rv = @[@1, @2, @3, @4, @5, @6].rotate(-2);
// rv => @[@5, @6, @1, @2, @3, @4]
```

Returns a new array rotated about the provided index.

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
Map, but run in parallel. Obviously: be thread safe in your block. Doesn’t
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

###NSDictionary.get()
```objc
id rv = @{@1: @1, @2: @4}.get(@2);

// rv => @4
```

Same as: `[NSDictionary objectForKey:]`.

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

###NSMutableArray.push()
```objc
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.push(@1).push(@2).push(@3)
// rv => @[@1, @2, @3]
```

###NSMutableArray.pop()
```objc
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.push(@1).push(@2).push(@3).pop()
// rv => @3
```

###NSMutableArray.unshift()
```objc
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.unshift(@1).unshift(@2).unshift(@3);
// rv => @[@3, @2, @1]
```

###NSMutableArray.shift()
```objc
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.unshift(@1).unshift(@2).unshift(@3).shift();
// rv => @3
```

Real World Examples
-------------------
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

Do you have a great example of real-world YOLOKit use? Please submit it here!

Caveats
-------
You can’t call a variable that represents a block if that variable is nil. This
is markedly different to sending a message to nil: you get nil back: no crash.
If it’s possible your *initial* object is nil you need to:

```objc
(campaigns ?: @[]).reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

Or, more controversially:

```objc
if (campaigns) campaigns.reject(^(PPCampaign *campaign){
    return campaign.locked;
}).pluck(@"venues").flatten.each(^(PPVenue *venue){
    [geofencer startMonitoringForRegion:venue.region];
});
```

Code is art. Make it look good, make it readable. You don’t have to rigidly
adhere to rules about how to write an if statement if the resulting code is
*nice*.

Contribution
------------
Please open issues for suggestions and pull requests for contributions.

Please don’t submit the many aliases for the above methods, as we think it’s
about time someone made decisions about which one to use. So we did.

License
-------
I, Max Howell the copyright holder of this work, hereby release it into the
public domain. This applies worldwide.

In case this is not legally possible, I grant any entity the right to use this
work for any purpose, without any conditions, unless such conditions are
required by law.
