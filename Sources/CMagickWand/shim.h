//
//  shim.h
//  ImageMagick-Swift
//
//  Created by Javier Segura Perez on 31/1/21.
//

#ifndef CLIB_SWIFT_IMAGEMAGICK
#define CLIB_SWIFT_IMAGEMAGICK

#include "/usr/local/include/ImageMagick-7/MagickWand/MagickWand.h"

#define ThrowWandException(wand) \
{ \
  char \
    *description; \
 \
  ExceptionType \
    severity; \
 \
  description=MagickGetException(wand,&severity); \
  (void) fprintf(stderr,"%s %s %lu %s\n",GetMagickModule(),description); \
  description=(char *) MagickRelinquishMemory(description); \
  exit(-1); \
}

#endif /* shim.h */
