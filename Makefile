##
## Makefile for CURA configuration
##

# Full version
VERSION ?= 3.6.0

# Major version
MAJOR ?= 3.6

# Application location
APPPATH ?= /Applications/Ultimaker Cura.app/Contents/Resources/resources

# Config files
CFGPATH ?= $(HOME)/Library/Application Support/cura/$(MAJOR)


## Files

APP_DIRS := #

CFG_DIRS := \
	materials		\
	quality			\
	quality_changes		\



## Rules

.PHONY: all diff cfgdiff appdiff

all: # or nothing
	@echo "Nothing to do."


diff: appdiff cfgdiff

appdiff:
	@shopt -s nullglob; \
	for DIR in $(APP_DIRS) ; do \
	  for FILE in $${DIR}/* ; do \
	    diff -u "$${FILE}" "$(APPPATH)/$${FILE}" ; \
	  done ; \
	done

cfgdiff:
	@shopt -s nullglob; \
	for DIR in $(CFG_DIRS) ; do \
	  for FILE in $${DIR}/* ; do \
	    diff -u "$${FILE}" "$(CFGPATH)/$${FILE}" ; \
	  done ; \
	done


## Install rules

INSTALLS := \
	material_install	\
	quality_install		\
	profile_install		\

.PHONY: $(INSTALLS)

install: $(INSTALLS)

material_install:
	@shopt -s nullglob; \
	for FILE in materials/* ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/$${FILE}" ; \
	done

quality_install:
	@shopt -s nullglob; \
	for FILE in quality/* ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/$${FILE}" ; \
	done

profile_install:
	@shopt -s nullglob; \
	for FILE in quality_changes/* ; do \
	  cp -fv "$${FILE}" "$(CFGPATH)/$${FILE}" ; \
	done

