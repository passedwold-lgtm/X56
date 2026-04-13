export THEOS = $(HOME)/theos
export ARCHS = arm64
export TARGET = iphone:clang:16.5:16.5

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NexoraFF

# ไฟล์และ Framework
$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_FRAMEWORKS = UIKit WebKit

# Compiler flags
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

# ใช้ plist ที่ชื่อเดียวกับ tweak
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += $(TWEAK_NAME)

include $(THEOS)/makefiles/tweak.mk

# ========== คัดลอก HTML ไปติดตั้ง ==========
internal-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/NexoraFF
	cp -f Fluorite.html $(THEOS_STAGING_DIR)/Library/NexoraFF/ 2>/dev/null || true

after-install::
	install.exec "killall -9 SpringBoard"
