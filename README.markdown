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
dot-notation: and using it feels *great*.

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
    return @(n.intValue * n.intValue);
});
// rv => @[@1, @4, @9, @16]
```

Notably, if you return nil, we skip that element in the returned array.
Justification:

1. We can’t add nil to NSArray
2. We could add NSNull instead, but then we’d be crashy and *YOLOKit is forgiving*
3. In Objective-C calling a method on nil returns nil. When enumerating an array this is equivalent to just skipping that element. Hence: we skip the element.

###NSArray.select()
```objc
id rv = @[@1, @2, @3, @4].select(^BOOL(NSNumber *n){
    return n.intValue % 2 == 0;
});
// rv => @[@2, @4]

**id rv = @[@1, @"1", @{}].select(NSNumber.class)
// rv => @[@1]
**
```

###NSArray.reject()
```objc
id rv = @[@1, @2, @3, @4].reject(^BOOL(NSNumber *n){
    return n.intValue % 2 == 0;
});
// rv => @[@1, @3]

**id rv = @[@1, @"1", @{}].reject(NSNumber.class)
// rv => @[@"1", @{}]
```

###NSArray.each()
```objc
@[@1, @2, @3, @4].each(^(id n){
	NSLog(@"%@", n);
});
// => 1\n2\n3\n4\n
```

###NSArray.eachWithIndex()
```objc
__block NSMutableDictionary *rv = @{}.mutableCopy;
@[@4, @3, @2, @1].eachWithIndex(^(id n, uint ii){
    rv[n] = @(ii * ii);
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
id rv = @[@1, @2, @3, @4].inject(@{}, ^(NSMutableDictionary *memo, NSNumber *n){
    memo[n] = @(n.intValue * n.intValue);
    return memo;
});
// rv => @{@1: @1, @2: @4, @3: @9, @4: @16}
```

If you feed inject a non-mutable dictionary or array YOLOKit mutates it for
your block, and then finally returns a non-mutable `copy`.

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
    return (n.intValue - 3) * (n.intValue - 3);
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
    return (n.intValue - 3) * (n.intValue - 3);
});
// rv => @1
```

###NSArray.find()
```objc
id rv = @[@1, @2, @3, @4].find(^(id n){
    return [n isEqual:@3];
});
// rv => @3

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = tableView.visibleCells.find(^(id cell){
        return [[tableView indexPathForCell:cell] isEqual:indexPath];
    });
}
```

###NSArray.indexOf()
```objc
uint rv = @[@1, @2, @3, @4].indexOf(@2);

// rv => 1
```

###NSArray.flatMap()
```objc
id rv = @[@1, @2, @3, @4].flatMap(^(id n){
    return @[n, n];
});
// rv => @[@1, @1, @2, @2, @3, @3, @4, @4]

id rv = @[@1, @2, @3, @4].flatMap(^(id n){
    return @[n, @[n]];
});
// rv => @[@1, @[@1], @2, @[@2], @3, @[@3], @4, @[@4]]
```

Useful over vanilla `map` followed by a `flatten` because `flatten` is
recursive, and you may want to preserve array relationships beyond the first
level.

###NSArray.groupBy()
```objc
id rv = @[@1, @2, @3, @4].groupBy(^(NSNumber *n) {
    return @(n.intValue % 2);
});
// rv => @{@0: @[@1, @3], @1: @[@2, @4]}
```

###NSArray.sortBy()
```objc
MKShape *rhombas = [MKShape new]; rhombas.title = @"rhombas";
MKShape *ellipse = [MKShape new]; ellipse.title = @"ellipse";
MKShape *hexagon = [MKShape new]; hexagon.title = @"hexagon";

id rv = @[rhombas, ellipse, hexagon].sortBy(^(id shape){
    return [shape title];
});
// rv => @[ellipse, hexagon, rhombas]

id rv = @[rhombas, ellipse, hexagon].sortBy(@"title")
// rv => @[ellipse, hexagon, rhombas]

id rv = @[
    @{@"name": @"frank", @"age": @32},
    @{@"name": @"frank", @"age": @31},
    @{@"name": @"bob", @"age": @54},
    @{@"name": @"zane", @"age": @1},
    @{@"name": @"frank", @"age": @12}
].sortBy(^(id o){
    return @[o[@"name"], o[@"age"]];
});
// rv => @[
    @{@"name": @"bob", @"age": @54},
    @{@"name": @"frank", @"age": @12},
    @{@"name": @"frank", @"age": @31},
    @{@"name": @"frank", @"age": @32},
    @{@"name": @"zane", @"age": @1}
];
```

You will need you to implement a `compare:` method for any custom objects
returned.

###NSArray.sort
```objc
id rv = @[@2, @1, @3, @5, @4].sort;
// rv => @[@1, @2, @3, @4, @5]

id rv = @[@"20", @"1", @3, @5, @"4"].sort;
// rv => @[@"1", @3, @"4", @5, @"20"]   // handles mixed object types

```

###NSArray.pluck()
```objc
MKShape *rhombas = [MKShape new]; rhombas.title = @"rhombas";
MKShape *ellipse = [MKShape new]; ellipse.title = @"ellipse";
MKShape *hexagon = [MKShape new]; hexagon.title = @"hexagon";

id rv = @[rhombas, ellipse, hexagon].pluck(@"title")
// rv => @[@"rhombas", @"ellipse", @"hexagon"]

id rv = @[rhombas, ellipse, hexagon].pluck(@"title.uppercaseString")
// rv => @[@"RHOMBAS", @"ELLIPSE", @"HEXAGON"]
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

###NSArray.skip()
```objc
id rv = @[@1, @2, @3, @4, @5, @6].skip(2);

// rv => @[@3, @4, @5, @6]
```

Skips *num* entries and returns the rest of the array.

###NSArray.snip()
```objc
id rv = @[@1, @2, @3, @4, @5, @6].snip(2);

// rv => @[@1, @2, @3, @4]
```

Snips the end off the array.

###NSArray.slice()
```objc
id rv = @[@1, @2, @3, @4, @5, @6].slice(2, 2));

// rv => @[@3, @4]
```

Use slice instead of first, last, skip and snip… when you have to. If you find
yourself writing `array.slice(0, 4)` then consider `array.first(4)` instead:
it’s more expressive, more explicit and shorter to boot.

###NSArray.reverse
```objc
id rv = @[@1, @2, @3, @4].reverse;

// rv => @[@4, @3, @2, @1]
```

###NSArray.join()
```objc
id rv = @[@1, @2, @3, @4].join(@",");
// rv => @"1,2,3,4"

id rv = @[@1, @2, @3, @4].join(@"");
// rv => @"1234"
```

###NSArray.transpose
```objc
id rv = @[@[@1, @2, @3], @[@4, @5, @6]].transpose;

// rv => @[@[@1, @4], @[@2, @5], @[@3, @6]]
```

`transpose` is surprisingly useful, if you think laterally about your problem.

###NSArray.shuffle
```objc
id rv = @[@1, @2, @3, @4, @5, @6].shuffle;

// rv => @[@2, @4, @5, @1, @3, @6]  // order is *random*
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
arrays since the overhead of thread-synchronization may be greater than the
parallel savings otherwise.

###NSArray.empty
```objc
BOOL rv = @[@1, @2].empty;
// rv => NO

BOOL rv = @[].empty;
// rv => YES
```

We picked `empty` rather than `isEmpty` because of context. We almost always
use empty in an if statement, and there the form: `if (array.empty) {}` is
clear and reads more easily than `isEmpty`. Small wins add up.

###NSArray.all()
```objc
BOOL rv = @[@1, @2, @3].all(^BOOL(id o){
	return [o intValue] > 0;
});
// rv => YES

BOOL rv = @[@1, @2, @3].all(^BOOL(id o){
	return [o intValue] < 3;
});
// rv => NO

BOOL rv = @[@1, @2, @3].all(NSNumber.class);
// rv => YES
```

###NSArray.none()
```objc
BOOL rv = @[@1, @2, @3].none(^BOOL(id o){
	return [o intValue] > 4;
});
// rv => YES

BOOL rv = @[@1, @2, @3].none(NSString.class);
// rv => YES
```

###NSArray.any()
```objc
BOOL rv = @[@1, @2, @3].any(^BOOL(id o){
	return [o intValue] == 3;
});
// rv => YES
```

###NSArray.has()
```objc
BOOL rv = @[@1, @2, @3].has(@2)
// rv => YES
```

Short-hand for `containsObject:`. Provided because doing a map, then a select
and a few more chained dot-notations are commonly followed with the need to
then determine if a particular value is in the resulting array, and then having
to square bracket the whole chain is ugly.

We decided not to override any or find with the capability to take an object
rather than a block and instead add this method. Rest assured the decision was
careful. In the end `has()` seemed the choice that resulted in the clearest
code.

`has` was chosen over `contains` or `includes` because it is short and clear.

###NSDictionary.map()
```objc
id rv = @{@1: @2, @2: @4, @3: @9}.map(^(id key, id obj){
    return @([key intValue] + [obj intValue]);
}).sort;

// rv = @[@3, @6, @12]
```

Note that internally we are fast enumerating the dictionary’s keys, which Apple
documents as having undefined order. Thus the above example calls sort.

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

Same as: `[NSDictionary objectForKey:]`. Provided because once you start
a chain of dot-notations, square brackets at the end are just ugly.

###NSDictionary.array()
```objc
id rv = @{@3: @"c", @1: @"a", @4: @"d", @2: @"b"}.array.sort.transpose[1]

// rv = [@"a", @"b", @"c", @"d"]

Returns a new array of key, value pairs.

###NSNumber.upTo()
```objc
id rv = @1.upTo(6);

// rv => @[@1, @2, @3, @4, @5, @6]
```

###NSString.split()
```objc
id rv = @"1,2,3,4,5,6".split(@",");

// rv => @[@"1", @"2", @"3", @"4", @"5", @"6"]
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

first, last, skip, snip & slice
-------------------------------
These methods are related and worth memorizing:

```objc
@[@1, @2, @3, @4, @5].first(2)		// [1,2]
@[@1, @2, @3, @4, @5].last(2)		// [4,5]
@[@1, @2, @3, @4, @5].skip(2)		// [3,4,5]
@[@1, @2, @3, @4, @5].snip(2)		// [1,2,3]
@[@1, @2, @3, @4, @5].slice(2, 2)	// [3,4]
```

Real World Examples
-------------------
I don’t think I would have been happy with this code without YOLOKit:

```objc
id chicago = [[CLLocation alloc] initWithLatitude:41.905088 longitude:-87.670083];
id austin = [[CLLocation alloc] initWithLatitude:30.2500 longitude:-97.7500];

[PPAPI GET:@"/campaigns" success:^(NSArray *got) {
    id closestCity = @[chicago, austin].min(^(id city) {
        return [locationManager.location distanceFromLocation:city];
    });

    self.campaigns = got.groupBy(^(PPCampaign *campaign) {
        return @[chicago, austin].min(^(id city) {
            return [campaign.location distanceFromLocation:city];
        });
    }).get(closestCity);
}];
```

Do you have a great example of real-world YOLOKit use? Please submit it here!

Caveats
-------
###`nil`
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

###Completion
Xcode (as of 5.1) does not complete YOLOKit well, apparently AppCode works
better. If you use Xcode, you will just have to remember the arguments that
YOLOKit blocks take. Someone should radar this.

Contribution
------------
Please open issues for suggestions and pull requests for contributions.

Please don’t submit the many aliases for the above methods, as we think it’s
about time someone made decisions about which one to use. So we did.

The Alternatives People Talk About
----------------------------------
* http://underscorem.org
* https://github.com/robb/Asterism
* https://github.com/ReactiveCocoa/ReactiveCocoa

License
-------
I, Max Howell the copyright holder of this work, hereby release it into the
public domain. This applies worldwide.

In case this is not legally possible, I grant any entity the right to use this
work for any purpose, without any conditions, unless such conditions are
required by law.
