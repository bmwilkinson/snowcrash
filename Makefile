-include config.mk

BUILDTYPE ?= Release
BUILD_DIR ?= ./build
PYTHON ?= python
GYP ?= gyp

# Default to verbose builds
V ?= 1

# Targets
all: libsnowcrash test-snowcrash snowcrash

.PHONY: libsnowcrash test-snowcrash snowcrash

libsnowcrash: $(BUILD_DIR)/Makefile
	$(MAKE) -C $(BUILD_DIR) V=$(V) libsnowcrash

test-snowcrash: $(BUILD_DIR)/Makefile
	$(MAKE) -C $(BUILD_DIR) V=$(V) test-snowcrash

snowcrash: $(BUILD_DIR)/Makefile
	$(MAKE) -C $(BUILD_DIR) V=$(V) snowcrash
	mkdir -p ./bin
	cp -f $(BUILD_DIR)/out/Default/snowcrash ./bin/snowcrash

$(BUILD_DIR)/Makefile:
	$(GYP) -f make --generator-output $(BUILD_DIR) --depth=.

clean:
	rm -rf $(BUILD_DIR)/out
	rm -rf ./bin

distclean:
	rm -rf ./build
	rm -f ./config.mk
	rm -rf ./bin	

test: test-snowcrash
	$(BUILD_DIR)/out/Default/test-snowcrash

.PHONY: libsnowcrash test-snowcrash snowcrash clean distclean test