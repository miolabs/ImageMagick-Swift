//
//  File.swift
//  
//
//  Created by Javier Segura Perez on 24/8/21.
//

import Foundation
import CMagickWand

public enum MagickImageFilterType: UInt32
{
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

extension MagickWand
{
    public func readImage(fromPath path:String) throws {
        let status = MagickReadImage(magick_wand, path.cString(using: .utf8))
        if (status == MagickFalse) {
            ThrowWandException(magick_wand)
//            print("ThrowWandException(magick_wand)")
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
            ThrowWandException(magick_wand)
//            print("ThrowWandException(magick_wand)")
        }
    }
        
    public func imageData(format:String? = nil) throws -> Data? {
        if format != nil { setImageFormat(format: format!) }
        MagickResetIterator(magick_wand)
        
        var len:Int = 0
        let bytes = MagickGetImageBlob(magick_wand, &len)!
        let data = Data(bytes: bytes, count: len)

        // TODO: Check this
//        MagickRelinquishMemory(magick_wand)
        
        return data
    }
    
    // MARK: Image format
    
    public func setImageFormat(format:String) {
        MagickSetImageFormat(magick_wand, format.cString(using: .utf8))
    }
        
    /// Returns the format of a particular image in a sequence
    ///
    /// -returns: String Image format. Example png, jpg, etc
    
    public func imageFormat() -> String? {
        let format = MagickGetImageFormat(magick_wand)
        return String(cString: format!, encoding: .utf8)
    }
    
    // MARK: -
    
    /// Scales an image to the desired dimensions with one of these filters:
    ///     Bessel,
    ///     Blackman,
    ///     Box,
    ///     Catrom,
    ///     CubicGaussian,
    ///     Hanning,
    ///     Hermite,
    ///     Lanczos,
    ///     Mitchell,
    ///     PointQuandratic,
    ///     Sinc,
    ///     Triangle
    ///
    /// - parameter columns: The number of columns in the scaled image.
    /// - parameter rows: The number of columns in the scaled image.
    /// - parameter filterType: Image filter to use.
    ///
    
    public func resize(columns:Int, rows:Int, filterType: MagickImageFilterType) {
        let ft = CMagickWand.FilterType(rawValue: filterType.rawValue)
        MagickResizeImage(magick_wand, columns, rows, ft)
    }
    
    /// Extracts a region of the image.
    ///
    /// - parameter width: the region width.
    /// - paremeter height: the region height.
    /// - paremeter x: the region x-offset.
    /// - paremeter y: the region y-offset.

    public func crop(width:Int, height:Int, x:Int, y:Int) {
        MagickCropImage(magick_wand, width, height, x, y)
    }
    
}
