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
    public enum FilterType: UInt32 {
      
        case undefinedFilter
        case pointFilter
        case boxFilter
        case triangleFilter
        case hermiteFilter
        case hannFilter
        case hammingFilter
        case blackmanFilter
        case gaussianFilter
        case quadraticFilter
        case cubicFilter
        case catromFilter
        case mitchellFilter
        case jincFilter
        case sincFilter
        case sincFastFilter
        case kaiserFilter
        case welchFilter
        case parzenFilter
        case bohmanFilter
        case bartlettFilter
        case lagrangeFilter
        case lanczosFilter
        case lanczosSharpFilter
        case lanczos2Filter
        case lanczos2SharpFilter
        case robidouxFilter
        case robidouxSharpFilter
        case cosineFilter
        case splineFilter
        case lanczosRadiusFilter
        case cubicSplineFilter
        case sentinelFilter  /* a count of all the filters, not a real filter */
    }
    
    let magick_wand:OpaquePointer
    
    init(){
        MagickWandGenesis()
        magick_wand = NewMagickWand()
    }
    
    deinit {
        DestroyMagickWand(magick_wand)
        MagickWandTerminus()
    }
    
    public func readImage(fromPath path:String) throws {
        let status = MagickReadImage(magick_wand, path.cString(using: .utf8))
        if (status == MagickFalse) {
            //ThrowWandException(magick_wand);
        }
    }
    
    public func writeImage(toPath path:String) throws {
        MagickWriteImage(magick_wand, path.cString(using: .utf8))
    }
    
    public func resize(width:Int, height:Int, filterType: FilterType) throws {
        let ft = CMagickWand.FilterType(rawValue: filterType.rawValue)
        MagickResizeImage(magick_wand, width, height, ft)
    }
}
