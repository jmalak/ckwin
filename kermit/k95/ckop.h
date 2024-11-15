/*****************************************************************************/
/*             Copyright (c) 1994 by Jyrki Salmi <jytasa@jyu.fi>             */
/*        You may modify, recompile and distribute this file freely.         */
/*****************************************************************************/


#ifdef XYZ_DLL

#ifdef XYZ_DLL_CALLCONV
#define CKXYZAPI            XYZ_DLL_CALLCONV
#else
#define CKXYZAPI
#endif /* CKXYZAPI */

typedef U32 CKXYZDLLENTRY p_transfer_dllentry(P_CFG *);
#ifdef XYZ_DLL_CLIENT
extern p_transfer_dllentry * p_transfer;
#else /* XYZ_DLL_CLIENT */
extern p_transfer_dllentry p_transfer;
#endif /* XYZ_DLL_CLIENT */
#else /* XYZ_DLL */
extern p_transfer_dllentry p_transfer;
#endif /* XYZ_DLL */
extern int load_p_dll(void);
extern int unload_p_dll(void);
extern int p(int sstate);
