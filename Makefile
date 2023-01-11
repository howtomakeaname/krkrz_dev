ifeq ($(VCPKG_ROOT),)
$(error Variables VCPKG_ROOT not set correctly.)
endif

ifeq ($(shell type cygpath > /dev/null && echo true),true)
FIXPATH = cygpath -ma
else
FIXPATH = realpath
endif

VCPKG=$(shell $(FIXPATH) "$(VCPKG_ROOT)/vcpkg")

ifeq ($(VCPKG_TARGET_TRIPLET),)
ifeq ($(OS),Windows_NT)
	# USE MSVC
	export CC=cl.exe
	VCPKG_TARGET_TRIPLET=$(VSCMD_ARG_TGT_ARCH)-windows-static
else
    UNAME_S := $(shell uname -s)
    UNAME_P := $(shell uname -p)
	VCPKG_TARGET_TRIPLET=$(UNAME_P)-$(UNAME_S)
endif
endif

ifeq ($(TARGET_TRIPLET),)
ifeq ($(OS),Windows_NT)
	TARGET_TRIPLET=$(VSCMD_ARG_TGT_ARCH)-windows
else
    UNAME_S := $(shell uname -s)
    UNAME_P := $(shell uname -p)
	TARGET_TRIPLET=$(UNAME_P)-$(UNAME_S)
endif
endif

ifeq ($(BUILD_TYPE),)
BUILD_TYPE=Release
endif

export VCPKG_TARGET_TRIPLET
export TARGET_TRIPLET
export BUILD_TYPE

ifeq ($(DATAPATH),)
DATAPATH=data
endif

DATAPATH_ABS=$(shell $(FIXPATH) "$(DATAPATH)")

BUILD_PATH=build/$(TARGET_TRIPLET)/$(BUILD_TYPE)

.PHONY: dependlib  dependlib.clean  build  prebuild

LIBRARIES=egl-registry \
	freetype[core,zlib,png,bzip2] \
	glm \
	libjpeg-turbo \
	libogg \
	libpng \
	libvorbis \
	oniguruma \
	opus \
	opusfile \
	zlib \
	picojson

ifeq ($(VCPKG_TARGET_TRIPLET),x86-windows-static)
LIBRARIES_ADD = glfw3 jxrlib libvpx libwebm
endif


LIBRARIES_NAME=$(addsuffix :$(VCPKG_TARGET_TRIPLET),$(LIBRARIES) $(LIBRARIES_ADD))

all: build

# 必要な vcpkg ライブラリを登録
dependlib:
	$(VCPKG) install $(LIBRARIES_NAME)

dependlib.clean:
	$(VCPKG) uninstall $(LIBRARIES_NAME)

# ビルド実行
# 現状 msys 環境だと MSVCコンパイラとリンカの探索に失敗する
# 一度 DOS 側で c:\msys64\usr\bin\make prebuild して CMakeCache.txt を作れば build は通るようになる
# CMAKEOPT で引数定義追加
prebuild:
	cmake -G Ninja -DVCPKG_TARGET_TRIPLET=$(VCPKG_TARGET_TRIPLET) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) ${CMAKEOPT} -B $(BUILD_PATH)

build:
	cmake --build $(BUILD_PATH)

clean:
	cmake --build $(BUILD_PATH) --target clean


# WIN版用ルール
ifeq (windows,$(findstring windows,$(VCPKG_TARGET_TRIPLET)))

ifeq (x86,$(findstring x86,$(VCPKG_TARGET_TRIPLET)))
PLUGINS_SRC_DIR=plugin
PLUGINS_DST_DIR=$(BUILD_PATH)/plugin
endif

ifeq (x64,$(findstring x64,$(VCPKG_TARGET_TRIPLET)))
PLUGINS_SRC_DIR=plugin64
PLUGINS_DST_DIR=$(BUILD_PATH)/plugin64
endif

PLUGINS = $(patsubst $(PLUGINS_SRC_DIR)/%.dll, $(PLUGINS_DST_DIR)/%.dll, $(wildcard $(PLUGINS_SRC_DIR)/*.dll))

$(PLUGINS_DST_DIR)/%.dll : $(PLUGINS_SRC_DIR)/%.dll
	@mkdir -p `dirname $@`
	cp $< $@

EXEFILE=$(BUILD_PATH)/krkrz.exe

$(EXEFILE): build

run: $(EXEFILE) $(PLUGINS)
	$(EXEFILE) $(DATAPATH_ABS)

endif
