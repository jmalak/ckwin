# MOVIE example makefile

#    wmake -f ow20.mak dos32       (makes the DOS movie tutorial)
#    wmake -f ow20.mak windows     (makes the Windows movie tutorial)
#    wmake -f ow20.mak winnt       (makes the Windows NT movie tutorial)
#    wmake -f ow20.mak win32       (makes the Windows NT movie tutorial)
#    wmake -f ow20.mak os2         (makes the OS/2 movie tutorial)

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
dos32: movie.exe movie1.exe movie2.exe movie3.exe movie4.exe movie5.exe movie6.exe movie7.exe .SYMBOLIC

movie.exe: movie.o32 p_movie.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie.exe F movie.o32,p_movie.o32 $(D32_OBJS) L $(D32_LIBS)

movie1.exe: movie1.o32 p_movie1.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie1.exe F movie1.o32,p_movie1.o32 $(D32_OBJS) L $(D32_LIBS)

movie2.exe: movie2.o32 p_movie2.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie2.exe F movie2.o32,p_movie2.o32 $(D32_OBJS) L $(D32_LIBS)

movie3.exe: movie3.o32 p_movie3.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie3.exe F movie3.o32,p_movie3.o32 $(D32_OBJS) L $(D32_LIBS)

movie4.exe: movie4.o32 p_movie4.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie4.exe F movie4.o32,p_movie4.o32 $(D32_OBJS) L $(D32_LIBS)

movie5.exe: movie5.o32 p_movie5.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie5.exe F movie5.o32,p_movie5.o32 $(D32_OBJS) L $(D32_LIBS)

movie6.exe: movie6.o32 p_movie6.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie6.exe F movie6.o32,p_movie6.o32 $(D32_OBJS) L $(D32_LIBS)

movie7.exe: movie7.o32 p_movie7.o32
	$(D32_LINK) $(D32_LINK_OPTS) N movie7.exe F movie7.o32,p_movie7.o32 $(D32_OBJS) L $(D32_LIBS)

# ----- Windows -------------------------------------------------------------
windows: wmovie.exe wmovie1.exe wmovie2.exe wmovie3.exe wmovie4.exe wmovie5.exe wmovie6.exe wmovie7.exe .SYMBOLIC

wmovie.exe: movie.obw p_movie.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie F movie.obw,p_movie.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wmovie1.exe: movie1.obw p_movie1.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie1 F movie1.obw,p_movie1.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wmovie2.exe: movie2.obw p_movie2.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie2 F movie2.obw,p_movie2.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wmovie3.exe: movie3.obw p_movie3.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie3 F movie3.obw,p_movie3.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wmovie4.exe: movie4.obw p_movie4.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie4 F movie4.obw,p_movie4.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wmovie5.exe: movie5.obw p_movie5.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie5 F movie5.obw,p_movie5.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wmovie6.exe: movie6.obw p_movie6.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie6 F movie6.obw,p_movie6.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe

wmovie7.exe: movie7.obw p_movie7.obw
	$(WIN_LINK) $(WIN_LINK_OPTS) N wmovie7 F movie7.obw,p_movie7.obw $(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) $*.rc $*.exe


# ----- Windows NT (and WIN32s) ---------------------------------------------
winnt: nmovie.exe nmovie1.exe nmovie2.exe nmovie3.exe nmovie4.exe nmovie5.exe nmovie6.exe nmovie7.exe .SYMBOLIC

nmovie.exe: movie.obn p_movie.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie F movie.obn,p_movie.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie nmovie

nmovie1.exe: movie1.obn p_movie1.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie1 F movie1.obn,p_movie1.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie1 nmovie1

nmovie2.exe: movie2.obn p_movie2.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie2 F movie2.obn,p_movie2.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie2 nmovie2

nmovie3.exe: movie3.obn p_movie3.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie3 F movie3.obn,p_movie3.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie3 nmovie3

nmovie4.exe: movie4.obn p_movie4.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie4 F movie4.obn,p_movie4.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie4 nmovie4

nmovie5.exe: movie5.obn p_movie5.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie5 F movie5.obn,p_movie5.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie5 nmovie5

nmovie6.exe: movie6.obn p_movie6.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie6 F movie6.obn,p_movie6.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie6 nmovie6

nmovie7.exe: movie7.obn p_movie7.obn
	$(WNT_LINK) $(WNT_LINK_OPTS) N nmovie7 F movie7.obn,p_movie7.obn $(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) nmovie7 nmovie7

# ----- 32 bit Windows ------------------------------------------------------
win32: 9movie.exe 9movie1.exe 9movie2.exe 9movie3.exe 9movie4.exe 9movie5.exe 9movie6.exe 9movie7.exe .SYMBOLIC

9movie.exe: movie.ob9 p_movie.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie F movie.ob9,p_movie.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie 9movie

9movie1.exe: movie1.ob9 p_movie1.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie1 F movie1.ob9,p_movie1.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie1 9movie1

9movie2.exe: movie2.ob9 p_movie2.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie2 F movie2.ob9,p_movie2.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie2 9movie2

9movie3.exe: movie3.ob9 p_movie3.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie3 F movie3.ob9,p_movie3.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie3 9movie3

9movie4.exe: movie4.ob9 p_movie4.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie4 F movie4.ob9,p_movie4.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie4 9movie4

9movie5.exe: movie5.ob9 p_movie5.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie5 F movie5.ob9,p_movie5.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie5 9movie5

9movie6.exe: movie6.ob9 p_movie6.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie6 F movie6.ob9,p_movie6.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie6 9movie6

9movie7.exe: movie7.ob9 p_movie7.ob9
	$(W32_LINK) $(W32_LINK_OPTS) N 9movie7 F movie7.ob9,p_movie7.ob9 $(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9movie7 9movie7

# ----- OS/2 ----------------------------------------------------------------
os2: omovie.exe omovie1.exe omovie2.exe omovie3.exe omovie4.exe omovie5.exe omovie6.exe omovie7.exe .SYMBOLIC

omovie.exe: movie.obo p_movie.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie.exe F movie.obo,p_movie.obo $(OS2_OBJS) L $(OS2_LIBS)

omovie1.exe: movie1.obo p_movie1.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie1.exe F movie1.obo,p_movie1.obo $(OS2_OBJS) L $(OS2_LIBS)

omovie2.exe: movie2.obo p_movie2.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie2.exe F movie2.obo,p_movie2.obo $(OS2_OBJS) L $(OS2_LIBS)

omovie3.exe: movie3.obo p_movie3.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie3.exe F movie3.obo,p_movie3.obo $(OS2_OBJS) L $(OS2_LIBS)

omovie4.exe: movie4.obo p_movie4.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie4.exe F movie4.obo,p_movie4.obo $(OS2_OBJS) L $(OS2_LIBS)

omovie5.exe: movie5.obo p_movie5.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie5.exe F movie5.obo,p_movie5.obo $(OS2_OBJS) L $(OS2_LIBS)

omovie6.exe: movie6.obo p_movie6.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie6.exe F movie6.obo,p_movie6.obo $(OS2_OBJS) L $(OS2_LIBS)

omovie7.exe: movie7.obo p_movie7.obo
	$(OS2_LINK) $(OS2_LINK_OPTS) N omovie7.exe F movie7.obo,p_movie7.obo $(OS2_OBJS) L $(OS2_LIBS)
