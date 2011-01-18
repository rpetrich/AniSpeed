TWEAK_NAME = AniSpeed
AniSpeed_OBJC_FILES = AniSpeed.m
AniSpeed_FRAMEWORKS = Foundation QuartzCore CoreGraphics

ADDITIONAL_CFLAGS = -std=c99

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk
