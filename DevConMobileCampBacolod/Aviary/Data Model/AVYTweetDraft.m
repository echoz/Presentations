//
//  DCTweetDraft.m
//  test
//
//  Created by Jeremy Foo on 20/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AVYTweetDraft.h"
#import <Twitter/Twitter.h>

@implementation AVYTweetDraft
@synthesize tweetBody, tweetID = _tweetID, status = _status, account;
@synthesize dateCreated = _dateCreated;

-(id)init {
    if ((self = [super init])) {
        self.status = DCTweetDraftUnpublished;
        self.tweetID = @"";
        self.tweetBody = @"";
        self.account = nil;
        _dateCreated = [[NSDate date] retain];
    }
    return self;
}

-(void)dealloc {
    self.tweetID = nil;
    self.tweetBody = nil;
    self.account = nil;
    
    [_dateCreated release], _dateCreated = nil;
    
    [super dealloc];
}

-(NSInteger)charsRemaining {
    return 140 - [self.tweetBody length];
}

-(void)publishTweetWithCompletion:(TweetCompletionHandler)completion {
    if (self.status == DCTweetDraftPublished)
        return;
    
    NSURL *tweetURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params setObject:self.tweetBody forKey:@"status"];
    
    TWRequest *sendTweetRequest = [[TWRequest alloc] initWithURL:tweetURL parameters:params requestMethod:TWRequestMethodPOST];
    sendTweetRequest.account = self.account;
    
    [sendTweetRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        NSError *jsonerror = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonerror];
        
        if (result) {
            
            _status = DCTweetDraftPublished;
            _tweetID = [result objectForKey:@"id_str"];
            
            if (completion)
                completion(result, nil);
            
        } else {
            if (completion)
                completion(nil, jsonerror);
        }
        
    }];


}

@end
