ZDOTDIR := $(shell echo ${ZDOTDIR})
ZSHRC := $(ZDOTDIR)/.zshrc
ZSHRC_MINIMAL := $(ZSHRC).minimal
OS := $(shell uname -s)

.PHONY: all
all: build build-minimal

.PHONY: build
build: $(ZSHRC)
	zsh -c "zcompile $(ZSHRC)"

.PHONY: build-minimal
build-minimal: $(ZSHRC_MINIMAL)
	zsh -c "zcompile $(ZSHRC_MINIMAL)"

$(ZSHRC_MINIMAL): clean-minimal
	cat ./main.minimal.zsh > $(ZSHRC_MINIMAL)

$(ZSHRC): clean
	cat ./main.zsh > $(ZSHRC)
	cat ./zinit.zsh >> $(ZSHRC)
	echo {alias,bind,function,iab}.zsh | xargs cat >> $(ZSHRC)
	[[ "$(OS)" == "Darwin" ]] && cat ./iterm2.zsh >> $(ZSHRC) || echo "ok"

.PHONY: clean
clean:
	[[ -e "$(ZSHRC)" ]] && rm $(ZSHRC) || echo "ok"

.PHONY: clean-minimal
clean-minimal:
	[[ -e "$(ZSHRC_MINIMAL)" ]] && rm $(ZSHRC_MINIMAL) || echo "ok"
