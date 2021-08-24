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
            print("ThrowWandException(magick_wand)")
        }
    }
    
    public func writeImage(toPath path:String) throws {
        MagickWriteImage(magick_wand, path.cString(using: .utf8))
    }

    public func readImage(fromData data:Data) throws {
        var status = MagickFalse
        
        data.withUnsafeBytes { bytes in
            status = MagickReadImageBlob(magick_wand, bytes.baseAddress!, data.count)
        }
                
        if (status == MagickFalse) {
            print("ThrowWandException(magick_wand)")
        }
    }
    
    public func imageData(format:String) throws -> Data? {
        MagickSetImageFormat(magick_wand, format.cString(using: .utf8))
        MagickResetIterator(magick_wand)
        
        var len:Int = 0
        let bytes = MagickGetImageBlob(magick_wand, &len)!
        let data = Data(bytes: bytes, count: len)

        // TODO: Check this
//        MagickRelinquishMemory(magick_wand)
        
        return data
    }
    
    public func resize(width:Int, height:Int, filterType: MagickImageFilterType) throws {
        let ft = CMagickWand.FilterType(rawValue: filterType.rawValue)
        MagickResizeImage(magick_wand, width, height, ft)
    }
}
