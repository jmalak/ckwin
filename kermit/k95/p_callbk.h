/*
 * Copyright 1995 Jyrki Salmi, Online Solutions Oy (www.online.fi)
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */


/* status_func is really a variadic function and Open Watcom doesn't like it
 * when we pretend it isn't. This breaks compatibility with K&R C compilers,
 * but in practice we *never* use a K&R C compiler to target Win32 or OS/2. I'm
 * not even sure there exists a compatible K&R C compiler for these platforms. */
/*_PROTOTYP( U32 status_func, (U32, intptr_t, U32, U32, U32, intptr_t));*/

_PROTOTYP( U32 status_func, (U32, ...) );

_PROTOTYP( U32 s_open_func, (U8 **, U32 *, U32 *, U32 *,
                       U32 *, U32 *,
                       U8 *, U8 *, U8 *));
_PROTOTYP( U32 r_open_func, (U8 **, U32, U32, U32,
                       U32, U32,
                       U8, U8, U8,
                       U32 *));
_PROTOTYP( U32 close_func, (U8 **, U32, U32, U32, BOOLEAN, U32));
_PROTOTYP( U32 seek_func, (U32));
_PROTOTYP( U32 read_func, (U8 *, U32, U32 *));
_PROTOTYP( U32 write_func, (U8 *, U32));

#ifdef XYZ_DLL

#ifdef CK_ANSIC
#include <stdarg.h>
#else /* CK_ANSIC */
#include <varargs.h>
#endif /* CK_ANSIC */

#define CKXYZAPI

typedef U32 CKXYZAPI va_status_func_callback(int, va_list);
typedef U32 CKXYZAPI r_open_func_callback(U8 **, U32, U32, U32, U32, U32, U8, U8, U8, U32 *);
typedef U32 CKXYZAPI s_open_func_callback(U8 **, U32 *, U32 *, U32 *, U32 *, U32 *, U8 *, U8 *, U8 *);
typedef U32 CKXYZAPI close_func_callback(U8 **, U32, U32, U32, BOOLEAN, U32);
typedef U32 CKXYZAPI seek_func_callback(U32);
typedef U32 CKXYZAPI read_func_callback(U8 *, U32, U32 *);
typedef U32 CKXYZAPI write_func_callback(U8 *, U32);
typedef U32 CKXYZAPI exe_in_func_callback(U8 *, U32, U32 *);
typedef U32 CKXYZAPI exe_out_func_callback(U8 *, U32, U32 *);
typedef U32 CKXYZAPI exe_break_func_callback(U8);
typedef U32 CKXYZAPI exe_available_func_callback(U32 *);
typedef U32 CKXYZAPI exe_pushback_func_callback(U8 *, U32);


#pragma pack(1)                     /* Use 1 byte alignment */
typedef struct _P_CFG {
  U32 version;                      /* This structure's version, use */
  U32 attr;                         /* Configuration attributes, see */
  U32 transfer_direction;           /* Transfer direction, see DIR_* */
  U32 protocol_type;                /* Protocol to use, see PROTOCOL_* */
  U32 serial_num;                   /* Our serial number that will be sent */
  U8 *attn_seq;                     /* This is a pointer to a string that */
  U32 dev_type;                     /* Communication device type, for values */
  U8 *dev_path;                     /* Path to the communication device, */
  U8 *socket_host;                  /* Internet address of the host to be */
  U16 socket_port;                  /* Stream socket port to be used. */
  intptr_t dev_handle;              /* Handle to an already open */
  U32 inbuf_size;                   /* Size of communication input buffer */
  U32 outbuf_size;                  /* Size of communication output buffer */
  U32 blk_size;                     /* Block size if protocol is X, Y or G. */
  va_status_func_callback       *callbackp_va_status_func;
  r_open_func_callback          *callbackp_r_open_func;
  s_open_func_callback          *callbackp_s_open_func;
  close_func_callback           *callbackp_close_func;
  seek_func_callback            *callbackp_seek_func;
  read_func_callback            *callbackp_read_func;
  write_func_callback           *callbackp_write_func;
  exe_in_func_callback          *callbackp_exe_in_func;
  exe_out_func_callback         *callbackp_exe_out_func;
  exe_break_func_callback       *callbackp_exe_break_func;
  exe_available_func_callback   *callbackp_exe_available_func;
  U16                           *control_prefix_table;
  exe_pushback_func_callback    *callbackp_exe_pushback_func;
} P_CFG;
#pragma pack()                  /* Back to default alignment */

#endif
