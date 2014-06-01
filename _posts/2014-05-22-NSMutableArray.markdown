# NSMutableArray


## NSMutableArray.pop


Treats receiver like a stack and removes the last object, returning it.

{% highlight objectivec %}
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.push(@1).push(@2).push(@3).pop()
// rv => @3
{% endhighlight %}


## NSMutableArray.push


Treats receiver like a stack and adds the given object to the end of the
receiver.

{% highlight objectivec %}
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.push(@1).push(@2).push(@3)
// rv => @[@1, @2, @3]
{% endhighlight %}


## NSMutableArray.shift


Removes the receiver’s first object and returns it.

{% highlight objectivec %}
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.unshift(@1).unshift(@2).unshift(@3).shift();
// rv => @3
{% endhighlight %}


## NSMutableArray.unshift


Inserts the given object at the front of receiver, moving all other
objects in the receiver up one index.

{% highlight objectivec %}
NSMutableArray *aa = [NSMutableArray new];
id rv = aa.unshift(@1).unshift(@2).unshift(@3);
// rv => @[@3, @2, @1]
{% endhighlight %}

