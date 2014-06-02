
### <span style='color:lightgray'>NSDictionary.</span>array


 Returns a new array of arrays of key, value pairs.

{% highlight objectivec %}
id rv = @{@3: @"c", @1: @"a", @4: @"d", @2: @"b"}.array
// rv = [@[@"3", @"c"], @[@1, @"a"], @[@4, @"d"], @[@2, @"b"]]
// NOTE array order is undefined

rv = rv.sort.transpose[1]
// rv = [@"a", @"b", @"c", @"d"]
// NOTE `rv.allValues.sort` would be more efficient
{% endhighlight %}

### <span style='color:lightgray'>NSDictionary.</span>extend


 Returns a new, merged dictionary.

 @param higherPriorityDictionary The dictionary to merge with the
 receiver. If any keys conflict, the values in this dictionary take precendence.

{% highlight objectivec %}
id rv = @{@1: @1, @2: @4}.extend(@{@1: @9, @10: @100});
// rv => @{@1: @9, @2: @4, @10: @100}
{% endhighlight %}

### <span style='color:lightgray'>NSDictionary.</span>get


 Returns the value associated with a given key.

{% highlight objectivec %}
id rv = @{@1: @1, @2: @4}.get(@2);
// rv => @4

{% endhighlight %}

### <span style='color:lightgray'>NSDictionary.</span>map


 Invokes the given block once for each key, value pair in the receiver.
 Returns an array containing the values returned by the block.

{% highlight objectivec %}
id rv = @{@1: @2, @2: @4, @3: @9}.map(^(id key, id obj){
    return @([key intValue] + [obj intValue]);
}).sort;

// rv = @[@3, @6, @12]
// NOTE `sort` called illustratively because dictionary order is undefined.
{% endhighlight %}

### <span style='color:lightgray'>NSDictionary.</span>pick


 Returns a new dictionary consisting of the given keys.
