#import "UITextView+mxcl.h"

@interface DOMNode
- (id)item:(NSUInteger)i;
- (id)attributes;
- (id)nodeName;
- (id)nodeValue;
- (id)childNodes;
@end

static void walkNodeTree(id parent) {
	id nodeList = [parent childNodes];
	unsigned i, length = [nodeList length];
	for (i = 0; i < length; i++) {
		id node = [nodeList item:i];
		walkNodeTree(node);
		id attributes = [node attributes];
		unsigned a, attCount = [attributes length];
		NSMutableString *nodeInfo = [NSMutableString stringWithCapacity:0];
		NSString *nodeName = [node nodeName];
		NSString *nodeValue = [node nodeValue];
		[nodeInfo appendFormat:@"node[%i]:\nname: %@\nvalue: %@\nattributes:\n", 
         i, nodeName, nodeValue];
		for (a = 0; a < attCount; a++) {
			id att = [attributes item:a];
			NSString *attName = [att nodeName];
			NSString *attValue = [att nodeValue];
			[nodeInfo appendFormat:@"\tatt[%i] name: %@ value: %@\n", a, attName, attValue];
		}		
		NSLog(@"%@", nodeInfo);
	}
}

@implementation UITextView (mxcl)
- (void)dumpDOMDocument {
    walkNodeTree([[[self performSelector:@selector(webView)] performSelector:@selector(mainFrame)] performSelector:@selector(DOMDocument)]);    
}
@end
