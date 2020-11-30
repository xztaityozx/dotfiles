ZDOTDIR := $(shell echo ${ZDOTDIR})
ZSHRC := $(ZDOTDIR)/.zshrc
ZSHRC_MINIMAL := $(ZSHRC).minimal
ENABLE_ZPROF := $(shell echo ${ENABLE_ZPROF})
OS := $(shell uname -s)
SHELL = zsh

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
	touch $(ZSHRC)
	[[ "$(ENABLE_ZPROF)" == "1" ]] && echo 'zmodload zsh/zprof && zprof' >> $(ZSHRC) || echo "zprof disable"
	cat ./main.zsh >> $(ZSHRC)
	cat ./zinit.zsh >> $(ZSHRC)
	echo {alias,bind,function,iab,eval}.zsh | xargs cat >> $(ZSHRC)
	[[ "$(OS)" == "Darwin" ]] && cat ./iterm2.zsh >> $(ZSHRC) || echo "ok"
	[[ "$(ENABLE_ZPROF)" == "1" ]] && echo 'type zprof &>/dev/null && zprof | less' >> $(ZSHRC) || echo "zprof disable"

.PHONY: clean
clean:
	[[ -e "$(ZSHRC)" ]] && rm $(ZSHRC) || echo "ok"

.PHONY: clean-minimal
clean-minimal:
	[[ -e "$(ZSHRC_MINIMAL)" ]] && rm $(ZSHRC_MINIMAL) || echo "ok"
