# ----- General Definitions -------------------------------------------------
VERSION=ow20

.EXTENSIONS:
.EXTENSIONS: .o32 .obw .obn .ob9 .obo .cpp

# ----- DOS extender compiler options ---------------------------------------
D32_CPP=wpp386
D32_LINK=wlink
D32_LIBRARIAN=wlib
D32_CPP_OPTS=/bt=dos
D32_LINK_OPTS=SYSTEM dos4g OP stack=20000
D32_LIB_OPTS=-p=64

# --- Use the next line for UI_GRAPHICS_DISPLAY ---
#D32_OBJS=
#D32_LIBS=,d32_zil,d32_gfx,wc_32gfx
# --- Use the next line for UI_WCC_DISPLAY ---
D32_OBJS=
D32_LIBS=,d32_zil,d32_wcc

# ----- Windows compiler options --------------------------------------------
WIN_CPP=wpp
WIN_LINK=wlink
WIN_LIBRARIAN=wlib
WIN_RC=wrc
WIN_LIB_OPTS=/p=64
WIN_CPP_OPTS= -zW -oaxt -w4 -ml
WIN_LINK_OPTS=SYS windows OP heapsize=16k OP stack=30k
WIN_RC_OPTS=/bt=windows
WIN_OBJS=
WIN_LIBS=,windows,win_zil

# ----- Windows NT (and WIN32s) compiler options ----------------------------
WNT_CPP=wpp386
WNT_LINK=wlink
WNT_LIBRARIAN=wlib
WNT_RC=wrc

WNT_CPP_OPTS=/bt=nt
WNT_RC_OPTS=/bt=nt
WNT_LINK_OPTS=SYS nt_win
WNT_LIB_OPTS=/p=32

WNT_OBJS=
WNT_LIBS=,nt,wnt_zil

# ----- Windows 32 bit compiler options -------------------------------------
W32_CPP=wpp386
W32_LINK=wlink
W32_LIBRARIAN=wlib
W32_RC=wrc

W32_CPP_OPTS=/bt=nt -DZIL_WIN32
W32_RC_OPTS=/bt=nt
W32_LINK_OPTS=SYS nt_win
W32_LIB_OPTS=/p=32

W32_OBJS=
W32_LIBS=,nt,w32_zil

# ----- OS/2 compiler options -----------------------------------------------
OS2_CPP=wpp386
OS2_LINK=wlink
OS2_LIBRARIAN=wlib
OS2_RC=rc
OS2_CPP_OPTS=/bt=OS2
OS2_LINK_OPTS=SYSTEM os2v2_pm OP ST=96000
OS2_LIB_OPTS=/p=64
OS2_RC_OPTS=
OS2_OBJS=
OS2_LIBS=,os2_zil

.cpp.o32:
	$(D32_CPP) $(D32_CPP_OPTS) -fo=$[*.o32 $<

.cpp.obw:
	$(WIN_CPP) $(WIN_CPP_OPTS) -fo=$[*.obw $<

.cpp.obn:
	$(WNT_CPP) $(WNT_CPP_OPTS) -fo=$[*.obn $<

.cpp.ob9:
	$(W32_CPP) $(W32_CPP_OPTS) -fo=$[*.ob9 $<

.cpp.obo:
	$(OS2_CPP) $(OS2_CPP_OPTS) -fo=$[*.obo $<

# ----- Clean ---------------------------------------------------------------
clean: .SYMBOLIC
	z_clean

# ----- DOS extender --------------------------------------------------------
dos32: test.exe .SYMBOLIC

test.exe: main.o32 service.lib
	%create d32_zil.rsp
	@%append d32_zil.rsp $(D32_LINK_OPTS)
	@%append d32_zil.rsp N test
	@%append d32_zil.rsp F main.o32
	@%append d32_zil.rsp L service.lib$(D32_LIBS)
	$(D32_LINK) @d32_zil.rsp
	del d32_zil.rsp

service.lib : service.o32
	-@del service.lib
	$(D32_LIBRARIAN) $(D32_LIB_OPTS) $* +service.o32

	copy service.hpp ..\..\include
	copy service.lib ..\..\lib\$(VERSION)
	copy p_servic.dat ..\..\bin\p_servic.znc

# ----- Windows -------------------------------------------------------------
windows: wtest.exe .SYMBOLIC

wtest.exe: main.obw wservice.lib
	%create win_zil.rsp
	@%append win_zil.rsp $(WIN_LINK_OPTS)
	@%append win_zil.rsp N wtest
	@%append win_zil.rsp F main.obw
	@%append win_zil.rsp L wservice.lib$(WIN_LIBS)
	$(WIN_LINK) @win_zil.rsp
	del win_zil.rsp

wservice.lib : service.obw
	-@del wservice.lib
	$(WIN_LIBRARIAN) $(WIN_LIB_OPTS) $* +service.obw

	copy service.hpp ..\..\include
	copy wservice.lib ..\..\lib\$(VERSION)
	copy p_servic.dat ..\..\bin\p_servic.znc

# ----- Windows NT (and WIN32s) ---------------------------------------------
winnt: ntest.exe .SYMBOLIC

ntest.exe: main.obn nservice.lib
	%create wnt_zil.rsp
	@%append wnt_zil.rsp $(WNT_LINK_OPTS)
	@%append wnt_zil.rsp N ntest
	@%append wnt_zil.rsp F main.obn
	@%append wnt_zil.rsp L nservice.lib$(WNT_LIBS)
	$(WNT_LINK) @wnt_zil.rsp
	del wnt_zil.rsp

nservice.lib : service.obn
	-@del nservice.lib
	$(WNT_LIBRARIAN) $(WNT_LIB_OPTS) $* +service.obn

	copy service.hpp ..\..\include
	copy nservice.lib ..\..\lib\$(VERSION)
	copy p_servic.dat ..\..\bin\p_servic.znc

# ----- 32 bit Windows ------------------------------------------------------
win32: 9test.exe .SYMBOLIC

9test.exe: main.ob9 9service.lib
	%create w32_zil.rsp
	@%append w32_zil.rsp $(W32_LINK_OPTS)
	@%append w32_zil.rsp N 9test
	@%append w32_zil.rsp F main.ob9
	@%append w32_zil.rsp L 9service.lib$(W32_LIBS)
	$(W32_LINK) @w32_zil.rsp
	del w32_zil.rsp

9service.lib : service.ob9
	-@del 9service.lib
	$(W32_LIBRARIAN) $(W32_LIB_OPTS) $* +service.ob9

	copy service.hpp ..\..\include
	copy 9service.lib ..\..\lib\$(VERSION)
	copy p_servic.dat ..\..\bin\p_servic.znc

# ----- OS/2 ----------------------------------------------------------------
os2: otest.exe .SYMBOLIC

otest.exe: main.obo oservice.lib
	%create os2_zil.rsp
	@%append os2_zil.rsp $(OS2_LINK_OPTS)
	@%append os2_zil.rsp N otest
	@%append os2_zil.rsp F main.obo
	@%append os2_zil.rsp L oservice.lib$(OS2_LIBS)
	$(OS2_LINK) @os2_zil.rsp
	del os2_zil.rsp

oservice.lib : service.obo
	-@del oservice.lib
	$(OS2_LIBRARIAN) $(OS2_LIB_OPTS) $* +service.obo

	copy service.hpp ..\..\include
	copy oservice.lib ..\..\lib\$(VERSION)
	copy p_servic.dat ..\..\bin\p_servic.znc
