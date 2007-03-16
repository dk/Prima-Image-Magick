/* $Id: mag.h,v 1.1 2007/03/16 17:16:14 dk Exp $ */

#ifdef __cplusplus
extern "C" {
#endif

Image
  *SetupList(pTHX_ SV *,SV ***,ExceptionInfo *);

Image *GetList(pTHX_ SV *reference,SV ***reference_vector,long *current,
  long *last,ExceptionInfo *exception);

void
magick_croak( char * what, ExceptionInfo * exception );

#ifdef __cplusplus
}
#endif
