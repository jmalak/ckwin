# ZINCAPP example makefile

#    wmake -f ow20.mak dos32       (makes the DOS zincapp tutorial)
#    wmake -f ow20.mak windows     (makes the Windows zincapp tutorial)
#    wmake -f ow20.mak winnt       (makes the Windows NT zincapp tutorial)
#    wmake -f ow20.mak win32       (makes the Windows NT zincapp tutorial)
#    wmake -f ow20.mak os2         (makes the OS/2 zincapp tutorial)

# Be sure to set the LIB and INCLUDE environment variables for Zinc, e.g.:
# DOS:
#    set INCLUDE=.;C:\WATCOM\H;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB386\DOS;C:\WATCOM\LIB386;C:\ZINC\LIB\ow20
# WINDOWS:
#    set INCLUDE=.;C:\WATCOM\H;C:\WATCOM\H\WIN;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB286\WIN;C:\WATCOM\LIB286;C:\ZINC\LIB\ow20
# WIN NT:
#    set INCLUDE=.;C:\WATCOM\H;C:\WATCOM\H\NT;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB386\NT;C:\WATCOM\LIB386;C:\ZINC\LIB\ow20
# OS/2:
#    set INCLUDE=.;C:\WATCOM\H;C:\WATCOM\H\OS2;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB386\OS2;C:\WATCOM\LIB386;C:\ZINC\LIB\ow20

.EXTENSIONS:
.EXTENSIONS: .o32 .obw .obn .ob9 .obo .cpp .c

# Compiler and linker: (Add -d2 to CPP_OPTS and DEBUG ALL to LINK_OPTS for debug.)

# ----- DOS extender compiler options ---------------------------------------
D32_CPP=wpp386
D32_LINK=wlink
D32_CPP_OPTS=/bt=dos
D32_LINK_OPTS=SYSTEM dos4g OP stack=20000 DISA 1124

# --- Use the next line for UI_GRAPHICS_DISPLAY ---
#D32_OBJS=
#D32_LIBS=d32_zil,d32_gfx,wc_32gfx
# --- Use the next line for UI_WCC_DISPLAY ---
D32_OBJS=
D32_LIBS=d32_zil,d32_wcc

# ----- Windows compiler options --------------------------------------------
WIN_CPP=wpp
WIN_LINK=wlink
WIN_RC=wrc
WIN_CPP_OPTS= -zW -zc -oas -w4 -ml
WIN_LINK_OPTS=SYS windows OP heapsize=16k OP stack=24k
WIN_RC_OPTS=/bt=windows
WIN_OBJS=
WIN_LIBS=windows,win_zil

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
WNT_LIBS=nt,wnt_zil

.cpp.obn:
	$(WNT_CPP) $(WNT_CPP_OPTS) -fo=$[*.obn $<

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
W32_LIBS=nt,w32_zil

.cpp.ob9:
	$(W32_CPP) $(W32_CPP_OPTS) -fo=$[*.ob9 $<

# ----- OS/2 compiler options -----------------------------------------------
OS2_CPP=wpp386
OS2_LINK=wlink
OS2_RC=wrc
OS2_CPP_OPTS=/bt=OS2
OS2_LINK_OPTS=SYSTEM os2v2_pm OP ST=96000
OS2_RC_OPTS=
OS2_OBJS=
OS2_LIBS=os2_zil

.cpp.o32:
	$(D32_CPP) $(D32_CPP_OPTS) -fo=$[*.o32 $<

.cpp.obw:
	$(WIN_CPP) $(WIN_CPP_OPTS) -fo=$[*.obw $<

.cpp.obo:
	$(OS2_CPP) $(OS2_CPP_OPTS) -fo=$[*.obo $<

# ----- Usage --------------------------------------------------------------
usage: .SYMBOLIC
	@echo ...........
	@echo ...........
	@echo To make this Zinc example for Watcom C++ type:
	@echo wmake -f ow20.mak dos32
	@echo wmake -f ow20.mak os2
	@echo wmake -f ow20.mak windows
	@echo wmake -f ow20.mak winnt
	@echo wmake -f ow20.mak win32
	@echo ...........
	@echo ...........

# ----- Clean ---------------------------------------------------------------
clean: .SYMBOLIC
	z_clean

# ----- DOS extender --------------------------------------------------------
dos32: zincapp.exe .SYMBOLIC

zincapp.exe: zincapp.o32 control.o32 display.o32 window.o32 event.o32 help.o32 support.o32
	%create d32_zil.rsp
	@%append d32_zil.rsp $(D32_LINK_OPTS)
	@%append d32_zil.rsp N zincapp
	@%append d32_zil.rsp F zincapp.o32, control.o32, display.o32, window.o32, event.o32, help.o32, support.o32 $(D32_OBJS)
	@%append d32_zil.rsp L $(D32_LIBS)
	$(D32_LINK) @d32_zil.rsp
	del d32_zil.rsp

# ----- Windows -------------------------------------------------------------
windows: wzincapp.exe .SYMBOLIC

wzincapp.exe: zincapp.obw control.obw display.obw window.obw event.obw help.obw support.obw
	%create win_zil.rsp
	@%append win_zil.rsp $(WIN_LINK_OPTS)
	@%append win_zil.rsp N wzincapp
	@%append win_zil.rsp F zincapp.obw,control.obw,display.obw,window.obw,event.obw,help.obw,support.obw $(WIN_OBJS)
	@%append win_zil.rsp L $(WIN_LIBS)
	$(WIN_LINK) @win_zil.rsp
	del win_zil.rsp
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

# ----- Windows NT (and WIN32s) ---------------------------------------------
winnt: nzincapp.exe .SYMBOLIC

nzincapp.exe: zincapp.obn control.obn display.obn window.obn event.obn help.obn support.obn
	%create wnt_zil.rsp
	@%append wnt_zil.rsp $(WNT_LINK_OPTS)
	@%append wnt_zil.rsp N nzincapp
	@%append wnt_zil.rsp F zincapp.obn,control.obn,display.obn,window.obn,event.obn,help.obn,support.obn$(WNT_OBJS)
	@%append wnt_zil.rsp L $(WNT_LIBS)
	$(WIN_LINK) @wnt_zil.rsp
	del wnt_zil.rsp
#	wrc $(WNT_RC_OPTS) nzincapp nzincapp

# ----- 32 bit Windows ------------------------------------------------------
win32: 9zincapp.exe .SYMBOLIC

9zincapp.exe: zincapp.ob9 control.ob9 display.ob9 window.ob9 event.ob9 help.ob9 support.ob9
	%create w32_zil.rsp
	@%append w32_zil.rsp $(W32_LINK_OPTS)
	@%append w32_zil.rsp N 9zincapp
	@%append w32_zil.rsp F zincapp.ob9,control.ob9,display.ob9,window.ob9,event.ob9,help.ob9,support.ob9$(W32_OBJS)
	@%append w32_zil.rsp L $(W32_LIBS)
	$(WIN_LINK) @w32_zil.rsp
	del w32_zil.rsp
#	wrc $(W32_RC_OPTS) 9zincapp 9zincapp

# ----- OS/2 ----------------------------------------------------------------
os2: ozincapp.exe .SYMBOLIC

ozincapp.exe: zincapp.obo control.obo display.obo window.obo event.obo help.obo support.obo
	%create os2_zil.rsp
	@%append os2_zil.rsp $(OS2_LINK_OPTS)
	@%append os2_zil.rsp N ozincapp
	@%append os2_zil.rsp F zincapp.obo,control.obo,display.obo,window.obo,event.obo,help.obo,support.obo $(OS2_OBJS)
	@%append os2_zil.rsp L $(OS2_LIBS)
	$(OS2_LINK) @os2_zil.rsp
	del os2_zil.rsp
	$(OS2_RC) $(OS2_RC_OPTS) $*.exe