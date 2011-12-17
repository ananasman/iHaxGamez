/*
 iHaxGamez - External process memory search-and-replace tool for MAC OS X
 Copyright (C) <2007>  <Raymond Wilfong and Glenn Hartmann>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
 You may contact Raymond Wilfong by email at rwilfong@rewnet.com
 */

#import "MemoryAccess.h"

#import <mach/vm_types.h>
#import <mach/mach_types.h>

#import "AppAddressData.h"
#import "PrivilegedHelperConnection.h"

@implementation MemoryAccess
- (id)init
{
    return [self initWithPID:0];
}

- (id)initWithPID:(pid_t)PID
{
    self = [super init];
    AppPid = PID;
    return self;
}

- (void) getSearchArray64:(vm_size_t)ReturnedBufferContentSize ReturnedBuffer:(Byte *)ReturnedBuffer ValueString:(NSString *)ValueString SourceAddress:(vm_address_t)SourceAddress AddrList:(NSMutableArray *)AddrList Value:(Byte *)Value SearchSize:(uint)SearchSize
{
	const int comparisonSize = sizeof(int64_t);
	Byte* valuePosition;
	Byte* valueEnd;
	Byte* resetDestPosition;
	Byte* endDestPosition = ReturnedBuffer + ReturnedBufferContentSize - SearchSize;
	Byte* destPosition = ReturnedBuffer;
	while(destPosition <= endDestPosition)
	{
            // speed processing by skipping all these calcs when we have no match
            // NOTE: "No match" happens more often than "match"
            // NOTE: check isIntMode first because 99% of the time it will be an integer that is being sought
		if (*(int64_t*)destPosition == *(int64_t*)Value)
		{
                // store the destPosition to reset position without expensive calculation
			resetDestPosition = destPosition;
			valuePosition = Value; // we just tested position 0 (first byte/int/int64_t) so start pointing there so that we can check to see if we are done with inner loop
			valueEnd = Value + SearchSize - comparisonSize; // we stop when we've checked all bytes in the search value
			do
			{
				if (valueEnd == valuePosition) // success
				{
					[AddrList addObject:[[AppAddressData alloc] initWithValues:(vm_address_t)(SourceAddress + (resetDestPosition - ReturnedBuffer)) val:ValueString]];
					break;
				}
				else // not yet done testing all bytes
				{
                        // set indexes so we can test next bytes
					valuePosition+=comparisonSize;
					destPosition++;
				}
			} while (*(int64_t*)destPosition == *(int64_t*)valuePosition);
			
                // back where we started -- testing is complete for now (we may OR may not have found a match, but we dont care any more)
			destPosition = resetDestPosition;
		}
		destPosition++; // start search on the next character in the destination byte array
	}
}

- (void) getSearchArray32:(vm_size_t)ReturnedBufferContentSize ReturnedBuffer:(Byte *)ReturnedBuffer ValueString:(NSString *)ValueString SourceAddress:(vm_address_t)SourceAddress AddrList:(NSMutableArray *)AddrList Value:(Byte *)Value SearchSize:(uint)SearchSize
{
	const int comparisonSize = sizeof(int32_t);
	Byte* valuePosition;
	Byte* valueEnd;
	Byte* resetDestPosition;
	Byte* endDestPosition = ReturnedBuffer + ReturnedBufferContentSize - SearchSize;
	Byte* destPosition = ReturnedBuffer;
	while(destPosition <= endDestPosition)
	{
            // speed processing by skipping all these calcs when we have no match
            // NOTE: "No match" happens more often than "match"
            // NOTE: check isIntMode first because 99% of the time it will be an integer that is being sought
		if (*(int32_t*)destPosition == *(int32_t*)Value)
		{
                // store the destPosition to reset position without expensive calculation
			resetDestPosition = destPosition;
			valuePosition = Value; // we just tested position 0 (first byte/int/int64_t) so start pointing there so that we can check to see if we are done with inner loop
			valueEnd = Value + SearchSize - comparisonSize; // we stop when we've checked all bytes in the search value
			do
			{
				if (valueEnd == valuePosition) // success
				{
					[AddrList addObject:[[AppAddressData alloc] initWithValues:(vm_address_t)(SourceAddress + (resetDestPosition - ReturnedBuffer)) val:ValueString]];
					break;
				}
				else // not yet done testing all bytes
				{
                        // set indexes so we can test next bytes
					valuePosition+=comparisonSize;
					destPosition++;
				}
			} while (*(int32_t*)destPosition == *(int32_t*)valuePosition);
			
                // back where we started -- testing is complete for now (we may OR may not have found a match, but we dont care any more)
			destPosition = resetDestPosition;
		}
		destPosition++; // start search on the next character in the destination byte array
	}
}

- (void) getSearchArray16:(vm_size_t)ReturnedBufferContentSize ReturnedBuffer:(Byte *)ReturnedBuffer ValueString:(NSString *)ValueString SourceAddress:(vm_address_t)SourceAddress AddrList:(NSMutableArray *)AddrList Value:(Byte *)Value SearchSize:(uint)SearchSize
{
	const int comparisonSize = sizeof(int16_t);
	Byte* valuePosition;
	Byte* valueEnd;
	Byte* resetDestPosition;
	Byte* endDestPosition = ReturnedBuffer + ReturnedBufferContentSize - SearchSize;
	Byte* destPosition = ReturnedBuffer;
	while(destPosition <= endDestPosition)
	{
            // speed processing by skipping all these calcs when we have no match
            // NOTE: "No match" happens more often than "match"
            // NOTE: check isIntMode first because 99% of the time it will be an integer that is being sought
		if (*(int16_t*)destPosition == *(int16_t*)Value)
		{
                // store the destPosition to reset position without expensive calculation
			resetDestPosition = destPosition;
			valuePosition = Value; // we just tested position 0 (first byte/int/int64_t) so start pointing there so that we can check to see if we are done with inner loop
			valueEnd = Value + SearchSize - comparisonSize; // we stop when we've checked all bytes in the search value
			do
			{
				if (valueEnd == valuePosition) // success
				{
					[AddrList addObject:[[AppAddressData alloc] initWithValues:(vm_address_t)(SourceAddress + (resetDestPosition - ReturnedBuffer)) val:ValueString]];
					break;
				}
				else // not yet done testing all bytes
				{
                        // set indexes so we can test next bytes
					valuePosition+=comparisonSize;
					destPosition++;
				}
			} while (*(int16_t*)destPosition == *(int16_t*)valuePosition);
			
                // back where we started -- testing is complete for now (we may OR may not have found a match, but we dont care any more)
			destPosition = resetDestPosition;
		}
		destPosition++; // start search on the next character in the destination byte array
	}
}

- (void) getSearchArray8:(vm_size_t)ReturnedBufferContentSize ReturnedBuffer:(Byte *)ReturnedBuffer ValueString:(NSString *)ValueString SourceAddress:(vm_address_t)SourceAddress AddrList:(NSMutableArray *)AddrList Value:(Byte *)Value SearchSize:(uint)SearchSize
{
	const int comparisonSize = sizeof(int8_t);
	Byte* valuePosition;
	Byte* valueEnd;
	Byte* resetDestPosition;
	Byte* endDestPosition = ReturnedBuffer + ReturnedBufferContentSize - SearchSize;
	Byte* destPosition = ReturnedBuffer;
	while(destPosition <= endDestPosition)
	{
            // speed processing by skipping all these calcs when we have no match
            // NOTE: "No match" happens more often than "match"
            // NOTE: check isIntMode first because 99% of the time it will be an integer that is being sought
		if (*(int8_t*)destPosition == *(int8_t*)Value)
		{
                // store the destPosition to reset position without expensive calculation
			resetDestPosition = destPosition;
			valuePosition = Value; // we just tested position 0 (first byte/int/int64_t) so start pointing there so that we can check to see if we are done with inner loop
			valueEnd = Value + SearchSize - comparisonSize; // we stop when we've checked all bytes in the search value
			do
			{
				if (valueEnd == valuePosition) // success
				{
					[AddrList addObject:[[AppAddressData alloc] initWithValues:(vm_address_t)(SourceAddress + (resetDestPosition - ReturnedBuffer)) val:ValueString]];
					break;
				}
				else // not yet done testing all bytes
				{
                        // set indexes so we can test next bytes
					valuePosition+=comparisonSize;
					destPosition++;
				}
			} while (*(int8_t*)destPosition == *(int8_t*)valuePosition);
			
                // back where we started -- testing is complete for now (we may OR may not have found a match, but we dont care any more)
			destPosition = resetDestPosition;
		}
		destPosition++; // start search on the next character in the destination byte array
	}
}

- (NSMutableArray *)getSearchArray:(Byte *)Value ByteSize:(int)Bytes SoughtValueString:(NSString *)ValueString PrgBar:(NSProgressIndicator *)pBar
{
    NSMutableArray *AddrList = [[NSMutableArray alloc] initWithCapacity:1000];
	
        // First we need a Task based on our pid
    kern_return_t KernelResult;
        // Cool! we have a task...
        // Now we need to start grabbing blocks of memory from our slave task and copying it into our memory space for analysis
    mach_vm_address_t SourceAddress = 0;
    mach_vm_size_t SourceSize = 0;
    
    uint64 BarMaxValue = UINT64_MAX;
    
    double PercentDone = 0.0;
    [pBar setDoubleValue:0.0];
    [pBar setHidden:false];
    [pBar displayIfNeeded];
    
    while(KERN_SUCCESS == (KernelResult = helper_vm_region(AppPid, &SourceAddress, &SourceSize)))
    {
            // If we get here then we have a block of memory and we know how big it is... let's copy writable blocks and see what we've got!
        PercentDone = 100.0 * SourceAddress / BarMaxValue; // bar represents position in total app memory
        if ((PercentDone - [pBar doubleValue]) > 0.25)
        {
            [pBar setDoubleValue:PercentDone];
            [pBar displayIfNeeded];
        }
        
        
        Byte *readBuffer = 0;
        mach_msg_type_number_t bufferSize;
        
        if (KERN_SUCCESS == helper_vm_read(AppPid, SourceAddress, SourceSize, &readBuffer, &bufferSize))
        {
            uint SearchSize = Bytes;
                // Note: we cannot assume memory alignment so each address could be the start of our multi-byte value
                // Note: instead of always comparing bytes, use long and int or short when possible (ie: SearchSize % sizeof(long) == 0, or SearchSize % sizeof(int) == 0 respectively)    
                // incrementing addresses instead of calculating offsets for speed
            if (0 == SearchSize % (int)sizeof(int64_t))
            {
                [self getSearchArray64: bufferSize ReturnedBuffer: readBuffer ValueString: ValueString SourceAddress: SourceAddress AddrList: AddrList Value: Value SearchSize: SearchSize];
            }
            else if (0 == SearchSize % (int)sizeof(int32_t))
            {
                [self getSearchArray32: bufferSize ReturnedBuffer: readBuffer ValueString: ValueString SourceAddress: SourceAddress AddrList: AddrList Value: Value SearchSize: SearchSize];
            }
            else if (0 == SearchSize % (int)sizeof(int16_t))
            {
                [self getSearchArray16: bufferSize ReturnedBuffer: readBuffer ValueString: ValueString SourceAddress: SourceAddress AddrList: AddrList Value: Value SearchSize: SearchSize];
            }
            else
            {
                [self getSearchArray8: bufferSize ReturnedBuffer: readBuffer ValueString: ValueString SourceAddress: SourceAddress AddrList: AddrList Value: Value SearchSize: SearchSize];
            }
            
        }
        
        if (readBuffer)
            helper_vm_free(readBuffer, bufferSize);
        
            // reset some values to search some more
        SourceAddress += SourceSize;
    }
    [pBar setHidden:true];
#if 0
	{
		NSAlert *MyAlert = [NSAlert alertWithMessageText:@"The external process could not be accessed."
										   defaultButton:nil
										 alternateButton:nil
											 otherButton:nil 
							   informativeTextWithFormat:@"You may not have rights to access this process, or this process may have ended."];
		[MyAlert runModal];
	}
#endif
	
    return AddrList;
}

- (NSMutableArray *)getFilteredArray:(Byte *)Value ByteSize:(size_t)Bytes SoughtValueString:(NSString *)ValueString Addresses:(NSMutableArray *)Addrs PrgBar:(NSProgressIndicator *)pBar
{
    AppAddressData *MyAddrRec;
    vm_address_t MyAddrRecAddress;
    NSUInteger recCount = [Addrs count];
    
    bool isMatchingValue;
	
    double PercentDone = 0.0;
    [pBar setDoubleValue:0.0];
    [pBar setHidden:false];
    [pBar displayIfNeeded];
	
	NSUInteger x;
    
    for (x=recCount; x>0 ; /* Decrementing in body at beginning of use instead of end */ ) // count down so we can remove from object array by index number
    {
        PercentDone = 100.0 * (recCount - x) / recCount;
        if (PercentDone - [pBar doubleValue] > 0.25)
        {
            [pBar setDoubleValue:PercentDone];
            [pBar displayIfNeeded];
        }
        
        isMatchingValue = false;
        x--;
        MyAddrRec = [Addrs objectAtIndex:x];
        MyAddrRecAddress = [MyAddrRec address];
        Byte *buffer;
        mach_msg_type_number_t bufferSize;
        @try {
            if ( (KERN_SUCCESS == helper_vm_read(AppPid, MyAddrRecAddress, Bytes, &buffer, &bufferSize)) &&
                (bufferSize == Bytes) )
            {
                NSUInteger y;
                isMatchingValue = true;
                for (y=Bytes ; isMatchingValue && (y>0) ; /* Decrementing in body at beginning of use instead of end */ )
                {
                    y--;
                    isMatchingValue = Value[y] == ((Byte *)buffer)[y];
                }
                
            }
        } @catch (NSException *exception) {
            isMatchingValue = NO;
        } @finally {
            helper_vm_free(buffer, bufferSize);
        }
            // check for match here -- removes record if any errors occurred along the way
        if (isMatchingValue)
        {
            [MyAddrRec setValue:ValueString];
        }
        else
        {
            [Addrs removeObjectAtIndex:x];
        }
    }
    
    [pBar setHidden:true];
	
    return Addrs;
}

- (bool)saveDataForAddress:(vm_address_t)Address Buffer:(Byte *)DataBuffer BufLength:(int)Bytes
{	    
    return helper_vm_write(AppPid, Address, DataBuffer, Bytes) == KERN_SUCCESS;
}

- (bool)loadDataForAddress:(vm_address_t)Address Buffer:(Byte *)DataBuffer BufLength:(vm_size_t)Bytes
{
    Byte *buffer;
    mach_msg_type_number_t bufferSize;
	kern_return_t kr = helper_vm_read(AppPid, Address, Bytes, &buffer, &bufferSize);
    if (kr == KERN_SUCCESS && bufferSize == Bytes) {
        memcpy(DataBuffer, (Byte *)buffer, bufferSize);
        helper_vm_free(buffer, bufferSize);
        return YES;
    }
    return NO;
}

@end
