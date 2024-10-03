# Zinc Application Framework 4.0 library makefile
# Uses OpenWatcom C/C++ 1.9 with Watcom WMAKE.EXE
#
# Compiles Zinc for 32 bit DOS (using DOS4GW), 16 bit Windows, Windows NT
#  (including WIN32s), OS2 2.x, DESQview/X (using Motif toolkit), QNX (Motif).
#    wmake -f wccpp.mak dos32
#    wmake -f wccpp.mak windows
#    wmake -f wccpp.mak win32
#    wmake -f wccpp.mak winnt
#    wmake -f wccpp.mak os2
#
# Be sure to set the LIB and INCLUDE environment variables for Zinc, e.g.:
# DOS:
#    set INCLUDE=.;C:\WATCOM\H;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB386\DOS;C:\WATCOM\LIB386;C:\ZINC\LIB\WCCPP
# WINDOWS:
#    set INCLUDE=.;C:\WATCOM\H;C:\WATCOM\H\WIN;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB286\WIN;C:\WATCOM\LIB286;C:\ZINC\LIB\WCCPP
# WIN NT:
#    set INCLUDE=.;C:\WATCOM\H;C:\WATCOM\H\NT;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB386\NT;C:\WATCOM\LIB386;C:\ZINC\LIB\WCCPP
# OS/2:
#    set INCLUDE=.;C:\WATCOM\H;C:\WATCOM\H\OS2;C:\ZINC\INCLUDE
#    set LIB=.;C:\WATCOM\LIB386\OS2;C:\WATCOM\LIB386;C:\ZINC\LIB\WCCPP
#
# ----- General Definitions -------------------------------------------------
VERSION=ow20

.EXTENSIONS:
.EXTENSIONS: .o32 .obw .obn .ob9 .obo .cpp .c

# ----- DOS 32 bit (DOS4GW extender) compiler options -----------------------
D32_CPP=wpp386
D32_LINK=wlink
D32_LIBRARIAN=wlib

D32_CPP_OPTS=/bt=dos /dDOS386 /zq 
D32_LINK_OPTS=SYSTEM dos4g OP stack=20000 DISA 1124
D32_LIB_OPTS=-p=64 -q

# --- Use the next line for UI_GRAPHICS_DISPLAY ---
#D32_OBJS=
#D32_LIBS=d32_zil,d32_gfx,wc_32gfx
# --- Use the next line for UI_WCC_DISPLAY ---
D32_OBJS=
D32_LIBS=d32_zil,d32_wcc

.cpp.o32:
	$(D32_CPP) $(D32_CPP_OPTS) -fo=$[*.o32 $<

# ----- 16 bit Windows compiler options -------------------------------------
WIN_CPP=wpp
WIN_LINK=wlink
WIN_LIBRARIAN=wlib
WIN_RC=wrc

WIN_CPP_OPTS= -zW -zc -oas -w4 -ml /zq 
WIN_RC_OPTS=/bt=windows
WIN_LINK_OPTS=SYS windows OP heapsize=16k OP stack=24k
WIN_LIB_OPTS=/p=64

WIN_OBJS=
WIN_LIBS=windows,win_zil

.cpp.obw:
	$(WIN_CPP) $(WIN_CPP_OPTS) -fo=$[*.obw $<

# ----- Windows NT (and WIN32s) compiler options ----------------------------
WNT_CPP=wpp386
WNT_LINK=wlink
WNT_LIBRARIAN=wlib
WNT_RC=wrc

WNT_CPP_OPTS=/bt=nt /zq 
WNT_RC_OPTS=/bt=nt
WNT_LINK_OPTS=SYS nt_win libpath .
WNT_LIB_OPTS=/p=128

WNT_OBJS=
WNT_LIBS=nt,wnt_zil

.cpp.obn:
	$(WNT_CPP) $(WNT_CPP_OPTS) -fo=$[*.obn $<

# ----- 32 bit Windows compiler options -------------------------------------
W32_CPP=wpp386
W32_LINK=wlink
W32_LIBRARIAN=wlib
W32_RC=wrc

W32_CPP_OPTS=/bt=nt -DZIL_WIN32 /zq 
W32_RC_OPTS=/bt=nt
W32_LINK_OPTS=SYS nt_win libpath .
W32_LIB_OPTS=/p=128

W32_OBJS=
W32_LIBS=nt,w32_zil

.cpp.ob9:
	$(W32_CPP) $(W32_CPP_OPTS) -fo=$[*.ob9 $<

# ----- OS/2 2.x compiler options -------------------------------------------
OS2_CPP=wpp386
OS2_LINK=wlink
OS2_LIBRARIAN=wlib
OS2_RC=rc

OS2_CPP_OPTS=/bt=OS2 /zq 
OS2_LINK_OPTS=SYSTEM os2v2_pm OP ST=96000
OS2_LIB_OPTS=/p=64
OS2_RC_OPTS=

OS2_OBJS=
OS2_LIBS=os2_zil,os2386

.cpp.obo:
	$(OS2_CPP) $(OS2_CPP_OPTS) -fo=$[*.obo $<
# ----- Usage --------------------------------------------------------------
usage: .SYMBOLIC
	@echo ...........
	@echo ...........
	@echo To generate the library modules for specific environments type:
	@echo wmake -f wccpp.mak dos32
	@echo wmake -f wccpp.mak windows
	@echo wmake -f wccpp.mak win32
	@echo wmake -f wccpp.mak winnt
	@echo wmake -f wccpp.mak os2
	@echo ...........
	@echo ...........

# ----- Clean ---------------------------------------------------------------
clean: .SYMBOLIC
	z_clean.bat

# ----- Copy files ----------------------------------------------------------
copy: .SYMBOLIC
	copy ui_*.hpp ..\include
	copy z_clean.* ..\bin

commCopy: .SYMBOLIC
	copy z_comctl.h ..\include

gfx_copy: .SYMBOLIC
	copy gfx\source\gfx.h ..\include
	copy gfx\source\gfx_pro.h ..\include

# ----- DOS 32 bit (DOS4GW extender) Libraries and Programs -----------------
#dos32: copy gfx_copy d32_gfx.lib d32_wcc.lib wc_32gfx.lib test32.exe .SYMBOLIC
dos32: copy d32_wcc.lib test32.exe .SYMBOLIC

#test32.exe: test.o32 d32_zil.lib

test32.exe: test.o32 d32_zil.lib
	$(D32_LINK) $(D32_LINK_OPTS) N $* F test.o32 $(D32_OBJS) L $(D32_LIBS)

d32_zil.lib : &
	d_bnum.o32 &
	d_border.o32 &
	d_button.o32 &
	d_combo.o32 &
	d_cursor.o32 &
	d_date.o32 &
	d_error.o32 &
	d_error1.o32 &
	d_event.o32 &
	d_fmtstr.o32 &
	d_group.o32 &
	d_hlist.o32 &
	d_icon.o32 &
	d_image.o32 &
	d_int.o32 &
	d_intl.o32 &
	d_keybrd.o32 &
	d_max.o32 &
	d_min.o32 &
	d_mouse.o32 &
	d_notebk.o32 &
	d_plldn.o32 &
	d_plldn1.o32 &
	d_popup.o32 &
	d_popup1.o32 &
	d_prompt.o32 &
	d_real.o32 &
	d_sbar.o32 &
	d_scroll.o32 &
	d_spin.o32 &
	d_string.o32 &
	d_sys.o32 &
	d_table.o32 &
	d_table1.o32 &
	d_table2.o32 &
	d_tbar.o32 &
	d_tdsp.o32 &
	d_text.o32 &
	d_time.o32 &
	d_title.o32 &
	d_vlist.o32 &
	d_win.o32 &
	d_win1.o32 &
	d_win2.o32 &
	z_bnum.o32 &
	z_bnum1.o32 &
	z_bnum2.o32 &
	z_border.o32 &
	z_button.o32 &
	z_combo.o32 &
	z_cursor.o32 &
	z_date.o32 &
	z_date1.o32 &
	z_decor.o32 &
	z_device.o32 &
	z_dialog.o32 &
	z_dsp.o32 &
	z_error.o32 &
	z_error1.o32 &
	z_event.o32 &
	z_file.o32 &
	z_fmtstr.o32 &
	z_gmgr.o32 &
	z_gmgr1.o32 &
	z_gmgr2.o32 &
	z_gmgr3.o32 &
	z_group.o32 &
	z_help.o32 &
	z_help1.o32 &
	z_hlist.o32 &
	z_icon.o32 &
	z_image.o32 &
	z_i18n.o32 &
	z_int.o32 &
	z_intl.o32 &
	z_lang.o32 &
	z_list.o32 &
	z_list1.o32 &
	z_locale.o32 &
	z_map1.o32 &
	z_map2.o32 &
	z_max.o32 &
	z_min.o32 &
	z_msgwin.o32 &
	z_notebk.o32 &
	z_path.o32 &
	z_plldn.o32 &
	z_plldn1.o32 &
	z_popup.o32 &
	z_popup1.o32 &
	z_printf.o32 &
	z_prompt.o32 &
	z_real.o32 &
	z_region.o32 &
	z_sbar.o32 &
	z_scanf.o32 &
	z_scroll.o32 &
	z_spin.o32 &
	z_stdarg.o32 &
	z_stored.o32 &
	z_storer.o32 &
	z_storew.o32 &
	z_string.o32 &
	z_sys.o32 &
	z_table.o32 &
	z_table1.o32 &
	z_table2.o32 &
	z_tbar.o32 &
	z_text.o32 &
	z_time.o32 &
	z_time1.o32 &
	z_timer.o32 &
	z_title.o32 &
	z_utils.o32 &
	z_utime.o32 &
	z_utime1.o32 &
	z_vlist.o32 &
	z_win.o32 &
	z_win1.o32 &
	z_win2.o32 &
	z_win3.o32 &
	z_win4.o32 &
	g_dsp.o32 &
	g_event.o32 &
	g_evt.o32 &
	g_gen.o32 &
	g_i18n.o32 &
	g_jump.o32 &
	g_lang.o32 &
	g_lang1.o32 &
	g_loc.o32 &
	g_loc1.o32 &
	g_mach.o32 &
	g_pnorm.o32 &
	g_win.o32 &
	i_file.o32 &
	i_map.o32 &
	i_str1.o32 &
	i_str2.o32 &
	i_str3.o32 &
	i_str4.o32 &
	i_str5.o32 &
	i_type.o32 &
	i_wccat.o32
	-@del d32_zil.lib
	$(D32_LIBRARIAN) $(D32_LIB_OPTS) @d32_zil.wcc
	-@md ..\lib\$(VERSION)
	copy d32_zil.lib ..\lib\$(VERSION)

d32_wcc.lib : d_wccdsp.o32 d_wccprn.o32 z_appwcc.o32
	-@del d32_wcc.lib
	$(D32_LIBRARIAN) $(D32_LIB_OPTS) $* +d_wccdsp.o32 +d_wccprn.o32 +z_appwcc.o32
	-@md ..\lib\$(VERSION)
	copy d32_wcc.lib ..\lib\$(VERSION)

d32_gfx.lib : d_gfxdsp.o32 d_gfxprn.o32 i_gfx.o32 z_appgfx.o32 &
	ISO_smal.o32 ISO_dial.o32 ISO_syst.o32 &
	OEM_smal.o32 OEM_dial.o32 OEM_syst.o32
	-@del d32_gfx.lib
	$(D32_LIBRARIAN) $(D32_LIB_OPTS) $*  +d_gfxdsp.o32 +d_gfxprn.o32 +i_gfx.o32 +z_appgfx.o32
	$(D32_LIBRARIAN) $(D32_LIB_OPTS) $* +ISO_smal.o32 +ISO_dial.o32 +ISO_syst.o32
	$(D32_LIBRARIAN) $(D32_LIB_OPTS) $* +OEM_smal.o32 +OEM_dial.o32 +OEM_syst.o32
	-@md ..\lib\$(VERSION)
	copy d32_gfx.lib ..\lib\$(VERSION)

wc_32gfx.lib : .SYMBOLIC
	@cd gfx\source
	wmake -f wccpp.mak dos32
	@cd ..\..

# ----- Windows 16 bit Libraries and Programs -------------------------------
windows: copy wtest.exe .SYMBOLIC

wtest.exe: test.obw win_zil.lib
	$(WIN_LINK) $(WIN_LINK_OPTS) N wtest F test.obw$(WIN_OBJS) L $(WIN_LIBS)
#	wrc $(WIN_RC_OPTS) wtest wtest

win_zil.lib : &
	w_bnum.obw &
	w_border.obw &
	w_button.obw &
	w_combo.obw &
	w_cursor.obw &
	w_date.obw &
	w_dsp.obw &
	w_error.obw &
	w_error1.obw &
	w_event.obw &
	w_fmtstr.obw &
	w_group.obw &
	w_hlist.obw &
	w_icon.obw &
	w_image.obw &
	w_int.obw &
	w_intl.obw &
	w_keybrd.obw &
	w_max.obw &
	w_min.obw &
	w_mouse.obw &
	w_notebk.obw &
	w_plldn.obw &
	w_plldn1.obw &
	w_popup.obw &
	w_popup1.obw &
	w_print.obw &
	w_prompt.obw &
	w_real.obw &
	w_sbar.obw &
	w_scroll.obw &
	w_spin.obw &
	w_string.obw &
	w_sys.obw &
	w_table.obw &
	w_table1.obw &
	w_table2.obw &
	w_tbar.obw &
	w_text.obw &
	w_time.obw &
	w_title.obw &
	w_vlist.obw &
	w_win.obw &
	w_win1.obw &
	w_win2.obw &
	z_app.obw &
	z_bnum.obw &
	z_bnum1.obw &
	z_bnum2.obw &
	z_border.obw &
	z_button.obw &
	z_combo.obw &
	z_cursor.obw &
	z_date.obw &
	z_date1.obw &
	z_decor.obw &
	z_device.obw &
	z_dialog.obw &
	z_dsp.obw &
	z_error.obw &
	z_error1.obw &
	z_event.obw &
	z_file.obw &
	z_fmtstr.obw &
	z_gmgr.obw &
	z_gmgr1.obw &
	z_gmgr2.obw &
	z_gmgr3.obw &
	z_group.obw &
	z_help.obw &
	z_help1.obw &
	z_hlist.obw &
	z_icon.obw &
	z_image.obw &
	z_i18n.obw &
	z_int.obw &
	z_intl.obw &
	z_lang.obw &
	z_list.obw &
	z_list1.obw &
	z_locale.obw &
	z_map1.obw &
	z_map2.obw &
	z_max.obw &
	z_min.obw &
	z_msgwin.obw &
	z_notebk.obw &
	z_path.obw &
	z_plldn.obw &
	z_plldn1.obw &
	z_popup.obw &
	z_popup1.obw &
	z_printf.obw &
	z_prompt.obw &
	z_real.obw &
	z_region.obw &
	z_sbar.obw &
	z_scanf.obw &
	z_scroll.obw &
	z_spin.obw &
	z_stdarg.obw &
	z_stored.obw &
	z_storer.obw &
	z_storew.obw &
	z_string.obw &
	z_sys.obw &
	z_table.obw &
	z_table1.obw &
	z_table2.obw &
	z_tbar.obw &
	z_text.obw &
	z_time.obw &
	z_time1.obw &
	z_timer.obw &
	z_title.obw &
	z_utils.obw &
	z_utime.obw &
	z_utime1.obw &
	z_vlist.obw &
	z_win.obw &
	z_win1.obw &
	z_win2.obw &
	z_win3.obw &
	z_win4.obw &
	g_dsp.obw &
	g_event.obw &
	g_evt.obw &
	g_gen.obw &
	g_i18n.obw &
	g_jump.obw &
	g_lang.obw &
	g_lang1.obw &
	g_loc.obw &
	g_loc1.obw &
	g_mach.obw &
	g_pnorm.obw &
	g_win.obw &
	i_file.obw &
	i_map.obw &
	i_str1.obw &
	i_str2.obw &
	i_str3.obw &
	i_str4.obw &
	i_str5.obw &
	i_type.obw
	-@del win_zil.lib
	$(WIN_LIBRARIAN) $(WIN_LIB_OPTS) @win_zil.wcc
	-@md ..\lib\$(VERSION)
	copy win_zil.lib ..\lib\$(VERSION)


# ----- Windows NT (and WIN32s) Libraries and Programs ----------------------
winnt: copy ntest.exe .SYMBOLIC

ntest.exe: test.obn wnt_zil.lib
	$(WNT_LINK) $(WNT_LINK_OPTS) N ntest F test.obn$(WNT_OBJS) L $(WNT_LIBS)
#	wrc $(WNT_RC_OPTS) ntest ntest

wnt_zil.lib : &
	3_bnum.obn &
	3_border.obn &
	3_button.obn &
	3_combo.obn &
	3_cursor.obn &
	3_date.obn &
	3_dsp.obn &
	3_error.obn &
	3_error1.obn &
	3_event.obn &
	3_fmtstr.obn &
	3_group.obn &
	3_hlist.obn &
	3_icon.obn &
	3_image.obn &
	3_int.obn &
	3_intl.obn &
	3_keybrd.obn &
	3_max.obn &
	3_min.obn &
	3_mouse.obn &
	3_notebk.obn &
	3_plldn.obn &
	3_plldn1.obn &
	3_popup.obn &
	3_popup1.obn &
	3_print.obn &
	3_prompt.obn &
	3_real.obn &
	3_sbar.obn &
	3_scroll.obn &
	3_spin.obn &
	3_string.obn &
	3_sys.obn &
	3_table.obn &
	3_table1.obn &
	3_table2.obn &
	3_tbar.obn &
	3_text.obn &
	3_time.obn &
	3_title.obn &
	3_vlist.obn &
	3_win.obn &
	3_win1.obn &
	3_win2.obn &
	z_app.obn &
	z_bnum.obn &
	z_bnum1.obn &
	z_bnum2.obn &
	z_border.obn &
	z_button.obn &
	z_combo.obn &
	z_cursor.obn &
	z_date.obn &
	z_date1.obn &
	z_decor.obn &
	z_device.obn &
	z_dialog.obn &
	z_dsp.obn &
	z_error.obn &
	z_error1.obn &
	z_event.obn &
	z_file.obn &
	z_fmtstr.obn &
	z_gmgr.obn &
	z_gmgr1.obn &
	z_gmgr2.obn &
	z_gmgr3.obn &
	z_group.obn &
	z_help.obn &
	z_help1.obn &
	z_hlist.obn &
	z_icon.obn &
	z_image.obn &
	z_i18n.obn &
	z_int.obn &
	z_intl.obn &
	z_lang.obn &
	z_list.obn &
	z_list1.obn &
	z_locale.obn &
	z_map1.obn &
	z_map2.obn &
	z_max.obn &
	z_min.obn &
	z_msgwin.obn &
	z_notebk.obn &
	z_path.obn &
	z_plldn.obn &
	z_plldn1.obn &
	z_popup.obn &
	z_popup1.obn &
	z_printf.obn &
	z_prompt.obn &
	z_real.obn &
	z_region.obn &
	z_sbar.obn &
	z_scanf.obn &
	z_scroll.obn &
	z_spin.obn &
	z_stdarg.obn &
	z_stored.obn &
	z_storer.obn &
	z_storew.obn &
	z_string.obn &
	z_sys.obn &
	z_table.obn &
	z_table1.obn &
	z_table2.obn &
	z_tbar.obn &
	z_text.obn &
	z_time.obn &
	z_time1.obn &
	z_timer.obn &
	z_title.obn &
	z_utils.obn &
	z_utime.obn &
	z_utime1.obn &
	z_vlist.obn &
	z_win.obn &
	z_win1.obn &
	z_win2.obn &
	z_win3.obn &
	z_win4.obn &
	g_dsp.obn &
	g_event.obn &
	g_evt.obn &
	g_gen.obn &
	g_i18n.obn &
	g_jump.obn &
	g_lang.obn &
	g_lang1.obn &
	g_loc.obn &
	g_loc1.obn &
	g_mach.obn &
	g_pnorm.obn &
	g_win.obn &
	i_file.obn &
	i_map.obn &
	i_str1.obn &
	i_str2.obn &
	i_str3.obn &
	i_str4.obn &
	i_str5.obn &
	i_type.obn
	-@del wnt_zil.lib
	$(WNT_LIBRARIAN) $(WNT_LIB_OPTS) @wnt_zil.wcc
	-@md ..\lib\$(VERSION)
	copy wnt_zil.lib ..\lib\$(VERSION)


# ----- Windows 32 bit Libraries and Programs -------------------------------
win32: copy commCopy 9test.exe .SYMBOLIC

9test.exe: test.ob9 w32_zil.lib
	$(W32_LINK) $(W32_LINK_OPTS) N 9test F test.ob9$(W32_OBJS) L $(W32_LIBS)
#	wrc $(W32_RC_OPTS) 9test 9test

w32_zil.lib : &
	9_bnum.ob9 &
	9_border.ob9 &
	9_button.ob9 &
	9_combo.ob9 &
	9_comctl.ob9 &
	9_cursor.ob9 &
	9_date.ob9 &
	9_dsp.ob9 &
	9_error.ob9 &
	9_error1.ob9 &
	9_event.ob9 &
	9_fmtstr.ob9 &
	9_group.ob9 &
	9_hlist.ob9 &
	9_icon.ob9 &
	9_image.ob9 &
	9_int.ob9 &
	9_intl.ob9 &
	9_keybrd.ob9 &
	9_max.ob9 &
	9_min.ob9 &
	9_mouse.ob9 &
	9_notebk.ob9 &
	9_plldn.ob9 &
	9_plldn1.ob9 &
	9_popup.ob9 &
	9_popup1.ob9 &
	9_print.ob9 &
	9_prompt.ob9 &
	9_real.ob9 &
	9_sbar.ob9 &
	9_scroll.ob9 &
	9_spin.ob9 &
	9_string.ob9 &
	9_sys.ob9 &
	9_table.ob9 &
	9_table1.ob9 &
	9_table2.ob9 &
	9_tbar.ob9 &
	9_text.ob9 &
	9_time.ob9 &
	9_title.ob9 &
	9_vlist.ob9 &
	9_win.ob9 &
	9_win1.ob9 &
	9_win2.ob9 &
	z_app.ob9 &
	z_bnum.ob9 &
	z_bnum1.ob9 &
	z_bnum2.ob9 &
	z_border.ob9 &
	z_button.ob9 &
	z_combo.ob9 &
	z_cursor.ob9 &
	z_date.ob9 &
	z_date1.ob9 &
	z_decor.ob9 &
	z_device.ob9 &
	z_dialog.ob9 &
	z_dsp.ob9 &
	z_error.ob9 &
	z_error1.ob9 &
	z_event.ob9 &
	z_file.ob9 &
	z_fmtstr.ob9 &
	z_gmgr.ob9 &
	z_gmgr1.ob9 &
	z_gmgr2.ob9 &
	z_gmgr3.ob9 &
	z_group.ob9 &
	z_help.ob9 &
	z_help1.ob9 &
	z_hlist.ob9 &
	z_icon.ob9 &
	z_image.ob9 &
	z_i18n.ob9 &
	z_int.ob9 &
	z_intl.ob9 &
	z_lang.ob9 &
	z_list.ob9 &
	z_list1.ob9 &
	z_locale.ob9 &
	z_map1.ob9 &
	z_map2.ob9 &
	z_max.ob9 &
	z_min.ob9 &
	z_msgwin.ob9 &
	z_notebk.ob9 &
	z_path.ob9 &
	z_plldn.ob9 &
	z_plldn1.ob9 &
	z_popup.ob9 &
	z_popup1.ob9 &
	z_printf.ob9 &
	z_prompt.ob9 &
	z_real.ob9 &
	z_region.ob9 &
	z_sbar.ob9 &
	z_scanf.ob9 &
	z_scroll.ob9 &
	z_spin.ob9 &
	z_stdarg.ob9 &
	z_stored.ob9 &
	z_storer.ob9 &
	z_storew.ob9 &
	z_string.ob9 &
	z_sys.ob9 &
	z_table.ob9 &
	z_table1.ob9 &
	z_table2.ob9 &
	z_tbar.ob9 &
	z_text.ob9 &
	z_time.ob9 &
	z_time1.ob9 &
	z_timer.ob9 &
	z_title.ob9 &
	z_utils.ob9 &
	z_utime.ob9 &
	z_utime1.ob9 &
	z_vlist.ob9 &
	z_win.ob9 &
	z_win1.ob9 &
	z_win2.ob9 &
	z_win3.ob9 &
	z_win4.ob9 &
	g_dsp.ob9 &
	g_event.ob9 &
	g_evt.ob9 &
	g_gen.ob9 &
	g_i18n.ob9 &
	g_jump.ob9 &
	g_lang.ob9 &
	g_lang1.ob9 &
	g_loc.ob9 &
	g_loc1.ob9 &
	g_mach.ob9 &
	g_pnorm.ob9 &
	g_win.ob9 &
	i_file.ob9 &
	i_map.ob9 &
	i_str1.ob9 &
	i_str2.ob9 &
	i_str3.ob9 &
	i_str4.ob9 &
	i_str5.ob9 &
	i_type.ob9
	-@del w32_zil.lib
	$(W32_LIBRARIAN) $(W32_LIB_OPTS) @w32_zil.wcc
	-@md ..\lib\$(VERSION)
	copy w32_zil.lib ..\lib\$(VERSION)


# ----- OS/2 2.x Libraries and Programs -------------------------------------
os2: copy otest.exe .SYMBOLIC

otest.exe: test.obo os2_zil.lib
	$(OS2_LINK) $(OS2_LINK_OPTS) N otest.exe F test.obo $(OS2_OBJS) L $(OS2_LIBS)

os2_zil.lib : &
	o_bnum.obo &
	o_border.obo &
	o_button.obo &
	o_combo.obo &
	o_cursor.obo &
	o_date.obo &
	o_dsp.obo &
	o_error.obo &
	o_error1.obo &
	o_event.obo &
	o_fmtstr.obo &
	o_group.obo &
	o_hlist.obo &
	o_icon.obo &
	o_image.obo &
	o_int.obo &
	o_intl.obo &
	o_keybrd.obo &
	o_max.obo &
	o_min.obo &
	o_mouse.obo &
	o_notebk.obo &
	o_plldn.obo &
	o_plldn1.obo &
	o_popup.obo &
	o_popup1.obo &
	o_print.obo &
	o_prompt.obo &
	o_real.obo &
	o_sbar.obo &
	o_scroll.obo &
	o_spin.obo &
	o_string.obo &
	o_sys.obo &
	o_table.obo &
	o_table1.obo &
	o_table2.obo &
	o_tbar.obo &
	o_text.obo &
	o_time.obo &
	o_title.obo &
	o_vlist.obo &
	o_win.obo &
	o_win1.obo &
	o_win2.obo &
	z_app.obo &
	z_bnum.obo &
	z_bnum1.obo &
	z_bnum2.obo &
	z_border.obo &
	z_button.obo &
	z_combo.obo &
	z_cursor.obo &
	z_date.obo &
	z_date1.obo &
	z_decor.obo &
	z_device.obo &
	z_dialog.obo &
	z_dsp.obo &
	z_error.obo &
	z_error1.obo &
	z_event.obo &
	z_file.obo &
	z_fmtstr.obo &
	z_gmgr.obo &
	z_gmgr1.obo &
	z_gmgr2.obo &
	z_gmgr3.obo &
	z_group.obo &
	z_help.obo &
	z_help1.obo &
	z_hlist.obo &
	z_icon.obo &
	z_image.obo &
	z_i18n.obo &
	z_int.obo &
	z_intl.obo &
	z_lang.obo &
	z_list.obo &
	z_list1.obo &
	z_locale.obo &
	z_map1.obo &
	z_map2.obo &
	z_max.obo &
	z_min.obo &
	z_msgwin.obo &
	z_path.obo &
	z_plldn.obo &
	z_plldn1.obo &
	z_popup.obo &
	z_popup1.obo &
	z_printf.obo &
	z_prompt.obo &
	z_real.obo &
	z_region.obo &
	z_sbar.obo &
	z_scanf.obo &
	z_scroll.obo &
	z_spin.obo &
	z_stdarg.obo &
	z_stored.obo &
	z_storer.obo &
	z_storew.obo &
	z_string.obo &
	z_sys.obo &
	z_table.obo &
	z_table1.obo &
	z_table2.obo &
	z_tbar.obo &
	z_text.obo &
	z_time.obo &
	z_time1.obo &
	z_timer.obo &
	z_title.obo &
	z_utils.obo &
	z_utime.obo &
	z_utime1.obo &
	z_vlist.obo &
	z_win.obo &
	z_win1.obo &
	z_win2.obo &
	z_win3.obo &
	z_win4.obo &
	g_dsp.obo &
	g_event.obo &
	g_evt.obo &
	g_gen.obo &
	g_i18n.obo &
	g_jump.obo &
	g_lang.obo &
	g_lang1.obo &
	g_loc.obo &
	g_loc1.obo &
	g_mach.obo &
	g_pnorm.obo &
	g_win.obo &
	i_file.obo &
	i_map.obo &
	i_str1.obo &
	i_str2.obo &
	i_str3.obo &
	i_str4.obo &
	i_str5.obo &
	i_type.obo
	-@del os2_zil.lib
	$(OS2_LIBRARIAN) $(OS2_LIB_OPTS) @os2_zil.wcc
	-@md ..\lib\$(VERSION)
	copy os2_zil.lib ..\lib\$(VERSION)

# --- Done with libraries ----------------------------------------------------

z_appwcc.o32: z_app.cpp
	$(D32_CPP) /dWCC $(D32_CPP_OPTS) -fo=$@ $?

z_appgfx.o32: z_app.cpp
	$(D32_CPP) /dGFX $(D32_CPP_OPTS) -fo=$@ $?

z_apptxt.o32: z_app.cpp
	$(D32_CPP) /dTEXT $(D32_CPP_OPTS) -fo=$@ $?

d_wccprn.o32: d_print.cpp
	$(D32_CPP) /dWCC $(D32_CPP_OPTS) -fo=$@ $?

d_gfxprn.o32: d_print.cpp
	$(D32_CPP) /dGFX $(D32_CPP_OPTS) -fo=$@ $?

OEM_dial.cpp: gfx\OEM_dial.cpp
	copy gfx\OEM_dial.cpp

OEM_smal.cpp: gfx\OEM_smal.cpp
	copy gfx\OEM_smal.cpp

OEM_syst.cpp: gfx\OEM_syst.cpp
	copy gfx\OEM_syst.cpp

ISO_dial.cpp: gfx\ISO_dial.cpp
	copy gfx\ISO_dial.cpp

ISO_smal.cpp: gfx\ISO_smal.cpp
	copy gfx\ISO_smal.cpp

ISO_syst.cpp: gfx\ISO_syst.cpp
	copy gfx\ISO_syst.cpp
