//
//  AVYDraftViewController.h
//  Aviary
//
//  Created by Jeremy Foo on 21/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVYTweetDraft.h"

typedef void (^DraftEditCompletionHandler)(void);

@interface AVYDraftViewController : UIViewController <UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UITextView *tweetTextView;
@property (retain, nonatomic) AVYTweetDraft *tweet;
@property (retain, nonatomic) IBOutlet UITextView *editTextView;
@property (copy) DraftEditCompletionHandler completion;

-(id)initWithTweetDraft:(AVYTweetDraft *)_tweet completion:(DraftEditCompletionHandler)_completion;
-(void)updatedTitle;
-(void)doneEditTweet;
@end
