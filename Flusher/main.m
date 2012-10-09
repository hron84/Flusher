//
//  main.m
//  Flusher
//
//  Created by Gabor Garami on 2012.10.09..
//  Copyright (c) 2012 Gabor Garami. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <RubyCocoa/RBRuntime.h>

int main(int argc, char *argv[])
{
  RBApplicationInit("rb_main.rb", argc, (const char **)argv, nil);
  return NSApplicationMain(argc, (const char **)argv);
}
