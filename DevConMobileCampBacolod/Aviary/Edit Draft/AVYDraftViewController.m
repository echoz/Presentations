//
//  AVYDraftViewController.m
//  Aviary
//
//  Created by Jeremy Foo on 21/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AVYDraftViewController.h"

@interface AVYDraftViewController ()

@end

@implementation AVYDraftViewController
@synthesize editTextView;
@synthesize tweetTextView, tweet;
@synthesize completion;

-(id)initWithTweetDraft:(AVYTweetDraft *)_tweet completion:(DraftEditCompletionHandler)_completion {
    if ((self = [super initWithNibName:@"AVYDraftViewController" bundle:nil])) {
        self.tweet = _tweet;
        self.completion = _completion;
    }
    
    return self;
}

- (void)dealloc {
    [tweetTextView release];
    [editTextView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.editTextView.text = self.tweet.tweetBody;
    [self.editTextView becomeFirstResponder];
    [self updatedTitle];
    
    if (self.completion) {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditTweet)] autorelease];
    }
}

- (void)viewDidUnload
{
    [self setTweetTextView:nil];
    [self setEditTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Implementation Specifics

-(void)doneEditTweet {
    self.tweet.tweetBody = self.editTextView.text;
    
    if (self.completion)
        self.completion();
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.editTextView.text = [self.editTextView.text stringByReplacingCharactersInRange:range withString:text];
    [self updatedTitle];
    return NO;
}

-(void)updatedTitle {
    self.tweet.tweetBody = self.editTextView.text;
    if ([self.tweet charsRemaining] > 0) {
        self.title = [NSString stringWithFormat:@"Edit Tweet (%d)", [self.tweet charsRemaining]];
        
    } else {
        self.title = @"Edit Tweet (%d)";

    }
}

@end
