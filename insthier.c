#include "ctxt.h"
#include "install.h"

struct install_item insthier[] = {
  {INST_MKDIR, 0, 0, ctxt_bindir, 0, 0, 0755},
  {INST_MKDIR, 0, 0, ctxt_incdir, 0, 0, 0755},
  {INST_MKDIR, 0, 0, ctxt_dlibdir, 0, 0, 0755},
  {INST_MKDIR, 0, 0, ctxt_slibdir, 0, 0, 0755},
  {INST_MKDIR, 0, 0, ctxt_repos, 0, 0, 0755},
  {INST_COPY, "sdl-ttf-ada-conf.c", 0, ctxt_repos, 0, 0, 0644},
  {INST_COPY, "sdl-ttf.ads", 0, ctxt_repos, 0, 0, 0644},
  {INST_COPY, "sdl-ttf.ads", 0, ctxt_incdir, 0, 0, 0644},
  {INST_COPY, "sdl-ttf.adb", 0, ctxt_repos, 0, 0, 0644},
  {INST_COPY, "sdl-ttf.adb", 0, ctxt_incdir, 0, 0, 0644},
  {INST_COPY, "sdl-ttf.ali", 0, ctxt_repos, 0, 0, 0644},
  {INST_COPY, "sdl-ttf.ali", 0, ctxt_incdir, 0, 0, 0444},
  {INST_COPY, "sdl-ttf-ada.sld", 0, ctxt_repos, 0, 0, 0644},
  {INST_COPY, "sdl-ttf-ada.a", "libsdl-ttf-ada.a", ctxt_slibdir, 0, 0, 0644},
  {INST_COPY, "sdl-ttf-ada-conf.ld", 0, ctxt_repos, 0, 0, 0644},
  {INST_COPY_EXEC, "sdl-ttf-ada-conf", 0, ctxt_bindir, 0, 0, 0755},
};
unsigned long insthier_len = sizeof(insthier) / sizeof(struct install_item);
