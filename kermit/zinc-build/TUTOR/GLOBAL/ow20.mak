# INTERPOL example makefile

#    wmake -f ow20.mak dos32       (makes the DOS intrpol tutorial)
#    wmake -f ow20.mak windows     (makes the Windows intrpol tutorial)
#    wmake -f ow20.mak winnt       (makes the Windows NT intrpol tutorial)
#    wmake -f ow20.mak win32       (makes the Windows 95 intrpol tutorial)
#    wmake -f ow20.mak os2         (makes the OS/2 intrpol tutorial)

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

.c.o32:
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
dos32: intrpol1.exe intrpol2.exe .SYMBOLIC

intrpol1.exe: intrpol1.o32 ipolwin1.o32
	$(D32_LINK) $(D32_LINK_OPTS) N intrpol1.exe F intrpol1.o32,ipolwin1.o32 $(D32_OBJS) L $(D32_LIBS)

intrpol2.exe: intrpol2.o32 ipolwin2.o32
	$(D32_LINK) $(D32_LINK_OPTS) N intrpol2.exe F intrpol2.o32,ipolwin2.o32 $(D32_OBJS) L $(D32_LIBS)

# ----- Windows -------------------------------------------------------------
windows: wintrpo1.exe wintrpo2.exe .SYMBOLIC

wintrpo1.exe: intrpol1.obw ipolwin1.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wintrpo1 F intrpol1.obw,ipolwin1.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wintrpo2.exe: intrpol2.obw ipolwin2.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wintrpo2 F intrpol2.obw,ipolwin2.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe


# ----- Windows NT (and WIN32s) ---------------------------------------------
winnt: nintrpo1.exe nintrpo2.exe .SYMBOLIC

nintrpo1.exe: intrpol1.obn ipolwin1.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nintrpo1 F intrpol1.obn,ipolwin1.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nintrpo1 nintrpo1

nintrpo2.exe: intrpol2.obn ipolwin2.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nintrpo2 F intrpol2.obn,ipolwin2.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nintrpo2 nintrpo2

# ----- 32 bit Windows ------------------------------------------------------
win32: 9intrpo1.exe 9intrpo2.exe .SYMBOLIC

9intrpo1.exe: intrpol1.ob9 ipolwin1.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9intrpo1 F intrpol1.ob9,ipolwin1.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9intrpo1 9intrpo1

9intrpo2.exe: intrpol2.ob9 ipolwin2.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9intrpo2 F intrpol2.ob9,ipolwin2.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9intrpo2 9intrpo2

# ----- OS/2 ----------------------------------------------------------------
os2: ointrpo1.exe ointrpo2.exe .SYMBOLIC

ointrpo1.exe: intrpol1.obo ipolwin1.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N ointrpo1.exe F intrpol1.obo,ipolwin1.obo $(OS2_OBJS) L $(OS2_LIBS)

ointrpo2.exe: intrpol2.obo ipolwin2.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N ointrpo2.exe F intrpol2.obo,ipolwin2.obo $(OS2_OBJS) L $(OS2_LIBS)