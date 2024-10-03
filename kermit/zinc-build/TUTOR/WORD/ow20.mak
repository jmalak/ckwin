# WORD example makefile

#    wmake -f ow20.mak dos32       (makes the DOS word tutorial)
#    wmake -f ow20.mak windows     (makes the Windows word tutorial)
#    wmake -f ow20.mak winnt       (makes the Windows NT word tutorial)
#    wmake -f ow20.mak win32       (makes the Windows NT word tutorial)
#    wmake -f ow20.mak os2         (makes the OS/2 word tutorial)

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
dos32: word2.exe word3.exe .SYMBOLIC

word2.exe: word2.o32
	$(D32_LINK) $(D32_LINK_OPTS) N word2.exe F word2.o32 $(D32_OBJS) L $(D32_LIBS)

word3.exe: word3.o32 word_win.o32
	$(D32_LINK) $(D32_LINK_OPTS) N word3.exe F word3.o32,word_win.o32 $(D32_OBJS) L $(D32_LIBS)

# ----- Windows -------------------------------------------------------------
windows: wword2.exe wword3.exe .SYMBOLIC

wword2.exe: word2.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wword2 F word2.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wword3.exe: word3.obw word_win.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wword3 F word3.obw,word_win.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe


# ----- Windows NT (and WIN32s) ---------------------------------------------
winnt: nword2.exe nword3.exe .SYMBOLIC

nword2.exe: word2.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nword2 F word2.obn$(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nword2 nword2

nword3.exe: word3.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nword3 F word3.obn$(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nword3 nword3

# ----- Windows 32 (and WIN32s) ---------------------------------------------
win32: 9word2.exe 9word3.exe .SYMBOLIC

9word2.exe: word2.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9word2 F word2.ob9$(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9word2 9word2

9word3.exe: word3.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9word3 F word3.ob9$(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9word3 9word3

# ----- OS/2 ----------------------------------------------------------------
os2: oword2.exe oword3.exe .SYMBOLIC

oword2.exe: word2.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N oword2.exe F word2.obo $(OS2_OBJS) L $(OS2_LIBS)

oword3.exe: word3.obo word_win.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N oword3.exe F word3.obo,word_win.obo $(OS2_OBJS) L $(OS2_LIBS)
