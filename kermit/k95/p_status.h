/*
  File p_status.h
  Declare status arguments structure and related macros for use with C-Kermit.
*/
/*
  Author: Jiri Malak (malak.jiri@gmail.com)

  Copyright (C) 2024,
    All rights reserved.  See the C-Kermit COPYING.TXT file or the
    copyright text in the ckcmai.c module for disclaimer and permissions.
*/


#ifndef _STATUSDEFS_H_
#define _STATUSDEFS_H_

typedef union tag_stvalue {
    U32     val;
    void    *ptr;
} stvalue;

typedef struct tag_status_args {
    U32         arg0;
    U32         arg1;
    U32         arg2;
    U32         arg3;
    stvalue     arg4;
} status_args;

#define STVAL(x)    (U32)(x)
#define ST(x)       ((status_args *)(x))

#define STPTR(x)    (void *)(x)

#endif
