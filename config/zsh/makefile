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

zinit:
	[[ -e zinit.generated.zsh ]] && rm zinit.generated.zsh || echo ok
	cat ./zinit.main.zsh >> zinit.generated.zsh
	cat ./zinit.runtime.zsh >> zinit.generated.zsh
	cat ./zinit.functions.zsh >> zinit.generated.zsh
	cat ./zinit.atload.zsh >> zinit.generated.zsh
	[[ "$(shell uname -m)" == "x86_64" ]] && cat ./zinit.x86_64.zsh >> zinit.generated.zsh || echo is not x86_64
	[[ "$(shell uname -m)" != "x86_64" ]] && cat ./zinit.arm64.zsh >> zinit.generated.zsh || echo is not arm64
	cat ./zinit.common.zsh >> zinit.generated.zsh


$(ZSHRC): clean zinit
	touch $(ZSHRC)
	[[ "$(ENABLE_ZPROF)" == "1" ]] && echo 'zmodload zsh/zprof && zprof' >> $(ZSHRC) || echo "zprof disable"
	cat ./main.zsh >> $(ZSHRC)
	cat ./zinit.generated.zsh >> $(ZSHRC)
	echo {alias,bind,function,iab}.zsh | xargs cat >> $(ZSHRC)
	echo true >> $(ZSHRC)
	[[ "$(ENABLE_ZPROF)" == "1" ]] && echo 'type zprof &>/dev/null && zprof | less' >> $(ZSHRC) || echo "zprof disable"

.PHONY: clean
clean:
	[[ -e "$(ZSHRC)" ]] && rm $(ZSHRC) || echo "ok"

.PHONY: clean-minimal
clean-minimal:
	[[ -e "$(ZSHRC_MINIMAL)" ]] && rm $(ZSHRC_MINIMAL) || echo "ok"
