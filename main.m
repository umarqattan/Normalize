//
//  main.m
//  NormalizePath
//
//  Created by Umar Qattan on 3/25/15.
//  Copyright (c) 2015 Umar Qattan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define     DOT   '.'
#define     SLASH '/'
#define     DONE   1
#define NOT_DONE   0




NSString *normalizeFilePath(NSString *path)
{
    NSMutableString *newPath = [NSMutableString stringWithString:@""];
    int  len  = (int)[path length];
    BOOL scan = NOT_DONE;
    int  curr, dir, offset = 0;
    
    for (curr = (len-1), dir = -1; scan != DONE; curr += dir) // Initially Scan the Given String in Reverse from the End
    {
        NSString *character = [NSString stringWithFormat:@"%c",[path characterAtIndex:curr]]; // Load New Character to be Added
        
        if (dir < 0 && curr >= 0) // Moving Backward
        {
            [newPath insertString:character atIndex:0]; // Add Character to the Beginning of the New String
            
            if ([path characterAtIndex:curr] == SLASH) // "foo/./bar", "../foo", "foo/../bar", "foo//bar", or "foo/bar"
            {
                if([path characterAtIndex:curr-1] == DOT) // "foo/./bar", "../foo", or "foo/../bar"
                {
                    if ([path characterAtIndex:curr-2] == SLASH) // "foo/./bar"
                    {
                        curr -=2; // Skip Dot Gap
                    }
                    else if ([path characterAtIndex:curr-2] == DOT) // "../foo" or "foo/../bar"
                    {
                        if (curr == 2) // "../foo"
                        {
                            scan = DONE; // Finish Early
                        }
                        else // "foo/../bar"
                        {
                            dir  =  1; // Change Direction
                            curr = -1; // Start at the Beginning
                        }
                    }
                }
                else if ([path characterAtIndex:curr-1] == SLASH) // "foo//bar"
                {
                    curr--; // Skip over the Second Slash
                }
                else // "foo/bar"
                {
                    continue;
                }
            }
            else // "foo"
            {
                continue;
            }
        }
        else if (dir > 0) // Moving Forward to Skip to the Root
        {
            if(curr <= 0) // "../foo" or "/foo"
            {
                if([path characterAtIndex:curr] == DOT) // "../foo"
                {
                    curr  += 2; // Skip ahead of the Dot Gap
                    offset = 3; // Mind the Gap
                }
                else // "/foo" or "foo"
                {
                    [newPath insertString:character atIndex:curr -offset];
                }
            }
            else // "foo/"
            {
                if([path characterAtIndex:curr] == SLASH) // end of "foo/"
                {
                    scan = DONE;
                }
                else // before the end of "foo/"
                {
                    [newPath insertString:character atIndex:curr -offset];
                }
            }
        }
        else // The Original string was already good to begin with...but it's too late now
        {
            scan = DONE;
        }
    }
    return newPath;
}



int main(int argc, const char * argv[])
{
    int testCaseNumber = 1;
    NSArray *testCases = @[@"foo/bar",
                           @"foo//bar",
                           @"../foo/bar/",
                           @"foo/./bar",
                           @"foo/../bar",
                           @"foo/bar/../baz",
                           @"../foo/bar/baz",
                           @"../foo/bar/../baz",
                           @"../foo/./bar/../baz/../buzz"];
    
    for(NSString *testCase in testCases)
    {
        NSLog(@"Test Case %d: The Original String is: %@\n",testCaseNumber, testCase);
        NSLog(@"             The New      String is: %@\n", normalizeFilePath(testCase));
        testCaseNumber++;
    }
    
    return 0;
}
