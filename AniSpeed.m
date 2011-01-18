#import <QuartzCore/QuartzCore.h>
#import <CaptainHook/CaptainHook.h>

CHDeclareClass(CAAnimation)

static NSTimeInterval factor;
//static NSTimeInterval inverseFactor;

/*CHOptimizedMethod(0, self, NSTimeInterval, CAAnimation, duration)
{
	return CHSuper(0, CAAnimation, duration) * inverseFactor;
}*/

CHOptimizedMethod(1, self, void, CAAnimation, setDuration, NSTimeInterval, duration)
{
	CHSuper(1, CAAnimation, setDuration, duration * factor);
}

static void LoadSettings()
{
	factor = [[[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.rpetrich.anispeed.plist"] objectForKey:@"ASFactor"] floatValue] ?: 0.5f;
	//inverseFactor = 1.0 / factor;
}

CHConstructor
{
	CHAutoreleasePoolForScope();
	CHLoadLateClass(CAAnimation);
	CHHook(1, CAAnimation, setDuration);
	//CHHook(0, CAAnimation, duration);
	LoadSettings();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)LoadSettings, CFSTR("com.rpetrich.anispeed/settingchanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
