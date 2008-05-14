# auto generated - do not edit

default: all

all:\
sdl-ttf.ali sdl-ttf.o

# -- SYSDEPS start
libs-sdl:
	@echo SYSDEPS sdl-libs run create libs-sdl 
	@(cd SYSDEPS/modules/sdl-libs && ./run)
libs-sdl-ttf:
	@echo SYSDEPS sdl-ttf-libs run create libs-sdl-ttf 
	@(cd SYSDEPS/modules/sdl-ttf-libs && ./run)


sdl-libs_clean:
	@echo SYSDEPS sdl-libs clean libs-sdl 
	@(cd SYSDEPS/modules/sdl-libs && ./clean)
sdl-ttf-libs_clean:
	@echo SYSDEPS sdl-ttf-libs clean libs-sdl-ttf 
	@(cd SYSDEPS/modules/sdl-ttf-libs && ./clean)


sysdeps_clean:\
sdl-libs_clean \
sdl-ttf-libs_clean \


# -- SYSDEPS end


ada-bind:\
conf-adabind conf-systype conf-adatype conf-adafflist flags-adasdl

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist \
	flags-adasdl

ada-link:\
conf-adalink conf-adatype conf-systype conf-aldfflist libs-adasdl libs-sdl

ada-srcmap:\
conf-adacomp conf-adatype conf-systype

ada-srcmap-all:\
ada-srcmap conf-adacomp conf-adatype conf-systype

cc-compile:\
conf-cc conf-cctype conf-systype

cc-link:\
conf-ld conf-ldtype conf-systype

cc-slib:\
conf-systype

conf-adatype:\
mk-adatype
	./mk-adatype > conf-adatype.tmp && mv conf-adatype.tmp conf-adatype

conf-cctype:\
conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld mk-ldtype
	./mk-ldtype > conf-ldtype.tmp && mv conf-ldtype.tmp conf-ldtype

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

mk-adatype:\
conf-adacomp conf-systype

mk-cctype:\
conf-cc conf-systype

mk-ctxt:\
mk-mk-ctxt
	./mk-mk-ctxt

mk-ldtype:\
conf-ld conf-systype conf-cctype

mk-mk-ctxt:\
conf-cc

mk-systype:\
conf-cc

sdl-ttf.ali:\
ada-compile sdl-ttf.ads
	./ada-compile sdl-ttf.ads

sdl-ttf.o:\
sdl-ttf.ali

clean-all: sysdeps_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f sdl-ttf.ali sdl-ttf.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
