#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:@"./float/objc.txt"];
        [fileHandle closeFile];
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:@"./float/objc.txt"];
        
        unsigned int a = 0b00000001 << 24;  // 2^24
        unsigned int b = 0b00000010 << 24;  // 2^25
        
        NSLog(@"a = %u", a);
        NSLog(@"b = %u", b);

        NSDate *start_time = [NSDate date];
        int n = 0;
        for (unsigned int c = a; c <= b; c++) {
            NSString *outputString = [NSString stringWithFormat:@"c = %08u => %8.1f\n", c, *((float*)&c)];
            [fileHandle writeData:[outputString dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle synchronizeFile];

            if (n == ((c-a)*100/a)) {
                n++;
                NSLog(@"%d/100\n", n);
            }
        }
        NSDate *stop_time = [NSDate date];
        NSLog(@"%f", [stop_time timeIntervalSinceDate:start_time]);
        [fileHandle synchronizeFile];
        [fileHandle closeFile];
    }
    return 0;
}
