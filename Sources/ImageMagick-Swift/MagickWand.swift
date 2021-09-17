//
//  MagickWand.swift
//  
//
//  Created by Javier Segura Perez on 24/8/21.
//

import Foundation
import CMagickWand

public class MagickWand
{
    let magick_wand:OpaquePointer
    
    public init(){
        MagickWandGenesis()
        magick_wand = NewMagickWand()
    }
    
    deinit {
        DestroyMagickWand(magick_wand)
        MagickWandTerminus()
    }
}

func ThrowWandException(_ wand:OpaquePointer)
{
    var severity:ExceptionType = ExceptionType(0)
 
    let description = MagickGetException(wand, &severity)
    print("\(String(describing: description))\n")
      
//     (void) fprintf(stderr,"%s %s %lu %s\n",GetMagickModule(),description);
//     description=(char *) MagickRelinquishMemory(description);
//     exit(-1);
}
