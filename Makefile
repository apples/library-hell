
# Configuration

PREFIX ?= $(shell pwd)/inst

# Library Configurations

## PNG

PNG_VER  = 1.6.7
PNG_DIR := libpng-$(PNG_VER)
PNG_TAR := $(PNG_DIR).tar.gz
PNG_URL := http://downloads.sourceforge.net/project/libpng/libpng16/$(PNG_VER)/$(PNG_TAR)
PNG_LIB := $(PREFIX)/lib/libpng.a

## GLEW

GLEW_VER  = 1.10.0
GLEW_DIR := glew-$(GLEW_VER)
GLEW_TAR := $(GLEW_DIR).tgz
GLEW_URL := http://downloads.sourceforge.net/project/glew/glew/$(GLEW_VER)/$(GLEW_TAR)
GLEW_LIB := $(PREFIX)/lib/libglew32.a

## GLFW

GLFW_VER  = 3.0.3
GLFW_DIR := glfw-$(GLFW_VER)
GLFW_ZIP := $(GLFW_DIR).zip
GLFW_URL := http://downloads.sourceforge.net/project/glfw/glfw/$(GLFW_VER)/$(GLFW_ZIP)
GLFW_LIB := $(PREFIX)/lib/libglfw3.a

## GLM

GLM_VER  = 0.9.4.6
GLM_DIR := glm
GLM_ZIP := $(GLM_DIR)-$(GLM_VER).zip
GLM_URL := http://downloads.sourceforge.net/project/ogl-math/glm-$(GLM_VER)/$(GLM_ZIP)
GLM_LIB := $(PREFIX)/include/glm/glm.hpp

## All

ALL_LIBS := $(PNG_LIB) $(GLEW_LIB) $(GLFW_LIB) $(GLM_LIB)

# Library Targets

.PHONY: all
all: $(ALL_LIBS)

$(PNG_DIR):
	wget -N $(PNG_URL)
	tar zxf $(PNG_TAR)

$(PNG_LIB): $(PNG_DIR)
	cd $(PNG_DIR) \
	&& ./configure --prefix=$(PREFIX) \
	&& make \
	&& make install

$(GLEW_DIR):
	wget -N $(GLEW_URL)
	tar zxf $(GLEW_TAR)

$(GLEW_LIB): $(GLEW_DIR)
	cd $(GLEW_DIR) \
	&& make \
	&& make install GLEW_DEST=$(PREFIX)

$(GLFW_DIR):
	wget -N $(GLFW_URL)
	unzip $(GLFW_ZIP)

$(GLFW_LIB): $(GLFW_DIR)
	cd $(GLFW_DIR) \
	&& cmake -G 'Unix Makefiles' -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=$(PREFIX) \
	&& make \
	&& make install

$(GLM_DIR):
	wget -N $(GLM_URL)
	unzip $(GLM_ZIP)

$(GLM_LIB): $(GLM_DIR)
	mkdir -p $(PREFIX)/include
	cp -a $(GLM_DIR)/glm $(PREFIX)/include
	rm -f $(PREFIX)/include/glm/CMakeLists.txt
