export THEOS = $(HOME)/theos
export ARCHS = arm64
export TARGET = iphone:clang:16.5:16.5

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NexoraFF

$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_FRAMEWORKS = UIKit WebKit
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS)/makefiles/tweak.mk

# บรรทัดที่ 21 ↓ ต้องขึ้นต้นด้วย TAB เท่านั้น
internal-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/NexoraFF
	cp -f Fluorite.html $(THEOS_STAGING_DIR)/Library/NexoraFF/ 2>/dev/null || true

after-install::
	install.exec "killall -9 SpringBoard"
