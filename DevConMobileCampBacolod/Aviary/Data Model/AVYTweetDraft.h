//
//  DCTweetDraft.h
//  test
//
//  Created by Jeremy Foo on 20/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

typedef enum {
    DCTweetDraftPublished = 0,
    DCTweetDraftUnpublished
} DCTweetDraftStatus;

typedef void (^TweetCompletionHandler)(NSDictionary *result, NSError *error);

@interface AVYTweetDraft : NSObject

@property (readonly) NSDate *dateCreated;
@property (nonatomic, copy) NSString *tweetBody;
@property (readwrite) DCTweetDraftStatus status;
@property (nonatomic, copy) NSString *tweetID;
@property (nonatomic, assign) ACAccount *account;

-(void)publishTweetWithCompletion:(TweetCompletionHandler)completion;
-(NSInteger)charsRemaining;

@end
