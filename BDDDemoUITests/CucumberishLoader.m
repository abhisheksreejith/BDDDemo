//
//  CucumberishLoader.m
//  DemoAppUITests
//
//  Created by Akshatha on 03/10/23.
//

#import <Foundation/Foundation.h>
#import "BDDDemoUITests-Swift.h"

__attribute__((constructor))
void CucumberishInit() {
    [CucumberInitilaizer setupCucumberish];
}

