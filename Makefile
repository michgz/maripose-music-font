
FONT_NAME = Maripose
FONT_NAME_LOWCASE = $(shell python -c "print('$(FONT_NAME)'.lower())")

PYTHON = python
MKDIR = mkdir
RM = rm -fr
COPY = cp

all: $(FONT_NAME_LOWCASE)-temp-2.sfd otf

otf: $(FONT_NAME_LOWCASE)-temp-2.sfd scripts/build_otf.py _build
	$(RM) _build/otf
	$(MKDIR) _build/otf
	$(PYTHON) scripts/build_otf.py $(FONT_NAME_LOWCASE)-temp-2.sfd _build/otf/$(FONT_NAME_LOWCASE)-temp-4.otf
	$(COPY) $(FONT_NAME_LOWCASE)-temp-2-metadata.json _build/otf/$(FONT_NAME_LOWCASE)-metadata.json
	$(COPY) _build/otf/$(FONT_NAME_LOWCASE)-temp-4.otf font/$(FONT_NAME_LOWCASE).otf
	$(COPY) _build/otf/$(FONT_NAME_LOWCASE)-metadata.json font/

$(FONT_NAME_LOWCASE)-temp-2.sfd: scripts/build_font.py $(FONT_NAME).sfdir
	$(PYTHON) scripts/build_font.py $(FONT_NAME).sfdir $(FONT_NAME_LOWCASE)-temp-2.sfd

_build:
	$(MKDIR) _build

.PHONY: otf
