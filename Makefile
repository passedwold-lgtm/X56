export THEOS = $(HOME)/theos
export ARCHS = arm64
export TARGET = iphone:clang:latest:16.5

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NexoraFF

$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_FRAMEWORKS = UIKit WebKit
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS)/makefiles/tweak.mk

internal-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/NexoraFF
	cp -f Fluorite.html $(THEOS_STAGING_DIR)/Library/NexoraFF/ 2>/dev/null || true
