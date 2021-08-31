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
