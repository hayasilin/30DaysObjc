//
//  BMICalc.m
//  test
//
//  Created by Kuan-Wei Lin on 2/23/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "BMICalc.h"

@implementation BMICalc

- (float)bmiCalc: (float)height weight:(float)weight{
    float mfloat = height / 100;
    float bmiFloat = weight / (mfloat * mfloat);
    
    return bmiFloat;
}

- (NSString*)bmiStr: (float)f1{
    NSString *str = [NSString stringWithFormat:@"%.2f", f1];
    
    return str;
}


@end
