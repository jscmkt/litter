//
//  main.m
//  算法
//
//  Created by shoule on 2018/8/21.
//  Copyright © 2018年 WT. All rights reserved.
//

#import <Foundation/Foundation.h>
//二分法
//递归
int erfen(int *a,int b, int first,int end ){
    int mid;
    if (first>end) {
        return -1;
    }
    mid = (first + end)/2;
    if (a[mid] == b) {
        return mid;
    }else if(a[mid]>b){
        erfen(a, b, first, mid-1);
    }else{
        return erfen(a, b, mid+1, end);
    }
    return 0;
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int a[10] = {1,3,4,6,2,9,0,8,5,7};
        int b = 1;
        int length  = sizeof(a)/sizeof(a[0]);
        //冒泡
        for (int i=0; i<length; i++) {
            for (int j=i+1; j<length; j++) {
                if (a[i]<a[j]) {
                    int temp = a[i];
                    a[i] = a[j];
                    a[j] = temp;
                }
            }
        }
        for (int i=0; i<length; i++) {
            printf("%d\n",a[i]);
        }
        printf("%d",erfen(a, b, 0, length-1));
        
    }
    return 0;
}
