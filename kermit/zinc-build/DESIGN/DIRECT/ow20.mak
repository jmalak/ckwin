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

test.exe: main.o32 direct.lib
	%create d32_zil.rsp
	@%append d32_zil.rsp $(D32_LINK_OPTS)
	@%append d32_zil.rsp N test
	@%append d32_zil.rsp F main.o32
	@%append d32_zil.rsp L direct.lib,service.lib$(D32_LIBS)
	$(D32_LINK) @d32_zil.rsp
	del d32_zil.rsp

direct.lib : d_direct.o32
	-@del direct.lib
	$(D32_LIBRARIAN) $(D32_LIB_OPTS) $* +d_direct.o32

	copy direct.hpp ..\..\include
	copy direct.lib ..\..\lib\$(VERSION)
	copy p_direct.dat ..\..\bin\p_direct.znc

# ----- Windows -------------------------------------------------------------
windows: wtest.exe .SYMBOLIC

wtest.exe: main.obw wdirect.lib
	%create win_zil.rsp
	@%append win_zil.rsp $(WIN_LINK_OPTS)
	@%append win_zil.rsp N wtest
	@%append win_zil.rsp F main.obw
	@%append win_zil.rsp L wdirect.lib,wservice.lib$(WIN_LIBS)
	$(WIN_LINK) @win_zil.rsp
	del win_zil.rsp

wdirect.lib : w_direct.obw
	-@del wdirect.lib
	$(WIN_LIBRARIAN) $(WIN_LIB_OPTS) $* +w_direct.obw

	copy direct.hpp ..\..\include
	copy wdirect.lib ..\..\lib\$(VERSION)
	copy p_direct.dat ..\..\bin\p_direct.znc

# ----- Windows NT (and WIN32s) ---------------------------------------------
winnt: ntest.exe .SYMBOLIC

ntest.exe: main.obn ndirect.lib
	%create wnt_zil.rsp
	@%append wnt_zil.rsp $(WNT_LINK_OPTS)
	@%append wnt_zil.rsp N ntest
	@%append wnt_zil.rsp F main.obn
	@%append wnt_zil.rsp L ndirect.lib,nservice.lib$(WNT_LIBS)
	$(WNT_LINK) @wnt_zil.rsp
	del wnt_zil.rsp

ndirect.lib : w_direct.obn
	-@del ndirect.lib
	$(WNT_LIBRARIAN) $(WNT_LIB_OPTS) $* +w_direct.obn

	copy direct.hpp ..\..\include
	copy ndirect.lib ..\..\lib\$(VERSION)
	copy p_direct.dat ..\..\bin\p_direct.znc

# ----- Windows 32 (and WIN32s) ---------------------------------------------
win32: 9test.exe .SYMBOLIC

9test.exe: mai9.ob9 9direct.lib
	%create w32_zil.rsp
	@%appe9d w32_zil.rsp $(W32_LINK_OPTS)
	@%appe9d w32_zil.rsp N 9test
	@%appe9d w32_zil.rsp F mai9.ob9
	@%appe9d w32_zil.rsp L 9direct.lib,9service.lib$(W32_LIBS)
	$(W32_LINK) @w32_zil.rsp
	del w32_zil.rsp

9direct.lib : w_direct.ob9
	-@del 9direct.lib
	$(W32_LIBRARIAN) $(W32_LIB_OPTS) $* +w_direct.ob9

	copy direct.hpp ..\..\include
	copy 9direct.lib ..\..\lib\$(VERSION)
	copy p_direct.dat ..\..\bin\p_direct.znc

# ----- OS/2 ----------------------------------------------------------------
os2: otest.exe .SYMBOLIC

otest.exe: main.obo odirect.lib
	%create os2_zil.rsp
	@%append os2_zil.rsp $(OS2_LINK_OPTS)
	@%append os2_zil.rsp N otest
	@%append os2_zil.rsp F main.obo
	@%append os2_zil.rsp L odirect.lib,oservice.lib$(OS2_LIBS)
	$(OS2_LINK) @os2_zil.rsp
	del os2_zil.rsp

odirect.lib : o_direct.obo
	-@del odirect.lib
	$(OS2_LIBRARIAN) $(OS2_LIB_OPTS) $* +o_direct.obo

	copy direct.hpp ..\..\include
	copy odirect.lib ..\..\lib\$(VERSION)
	copy p_direct.dat ..\..\bin\p_direct.znc
