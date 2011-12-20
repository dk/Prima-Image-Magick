/* $Id: prima.c,v 1.2 2011/12/20 08:15:24 dk Exp $ */
#ifdef __cplusplus
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "prima.h"
#include <apricot.h>
#include <Image.h>
#include <img_conv.h>

void
read_prima_image_data( SV * input, pim_image * pim)
{
	PImage i = ( PImage) gimme_the_mate( input);
	if ( i == NULL) croak("Cannot read Prima::Image data");

	pim-> data      = i-> data;
	pim-> line_size = i-> lineSize;
	pim-> width     = i-> w;
	pim-> height    = i-> h;
	pim-> bpp       = i-> type & imBPP;
	pim-> colors    = i-> palSize;
	pim-> palette   = (unsigned char*) i-> palette;
	pim-> category  = 0; 
	if ( i-> type & imGrayScale)
		pim-> category  |= IS_GRAY;
	if ( i-> type & imComplexNumber) {
		pim-> category  |= ( pim-> bpp == 16 * sizeof( float)) ? IS_FLOAT : IS_DOUBLE;
		pim-> category  |= IS_COMPLEX;
	} else if ( i-> type & imRealNumber) {
		pim-> category  |= ( pim-> bpp ==  8 * sizeof( float)) ? IS_FLOAT : IS_DOUBLE;
	}

}


void bytecopy  (void *s,void *d,int w,unsigned char *p) { memcpy          ( d, s, w); }
void bitexp    (void *s,void *d,int w,unsigned char *p) { bc_mono_graybyte( s, d, w, (PRGBColor)p); }
void nibbleexp (void *s,void *d,int w,unsigned char *p) { bc_nibble_graybyte( s, d, w, (PRGBColor)p); }
void bitrgb    (void *s,void *d,int w,unsigned char *p) { bc_mono_rgb     ( s, d, w, (PRGBColor)p); }
void nibblergb (void *s,void *d,int w,unsigned char *p) { bc_nibble_rgb   ( s, d, w, (PRGBColor)p); }
void bytergb   (void *s,void *d,int w,unsigned char *p) { bc_byte_rgb     ( s, d, w, (PRGBColor)p); }

BitCopyProc *
get_prima_bitcopy_proc( int bpp_from, int bpp_to )
{
	switch( bpp_to) {
	case 24:
		switch ( bpp_from) {
		case 1:
			return bitrgb;
		case 4:
			return nibblergb;
		case 8:
			return bytergb;
		}
		break;
	default:
		switch ( bpp_from) {
		case 1:
			return bitexp;
		case 4:
			return nibbleexp;
		}
	}

	return bytecopy;
}

void
allocate_prima_image( SV * input, int width, int height, int rgb)
{
	PImage i = ( PImage) gimme_the_mate( input);
	if ( i == NULL) croak("Cannot read Prima::Image data");
	i-> self-> create_empty(( Handle) i, width, height, rgb ? imRGB : imByte);
}


#ifdef __cplusplus
}
#endif
