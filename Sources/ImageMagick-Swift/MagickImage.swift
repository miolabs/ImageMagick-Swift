//
//  File.swift
//  
//
//  Created by Javier Segura Perez on 24/8/21.
//

import Foundation

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
