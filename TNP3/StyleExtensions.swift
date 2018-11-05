//
//  StyleExtensions.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/24/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import Foundation


import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var blueDark: UIColor {
        return UIColor(red: 43.0 / 255.0, green: 102.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueDefault: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 144.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var blueLight: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 144.0 / 255.0, blue: 1.0, alpha: 0.54)
    }
    
    @nonobjc class var blueFadeLight: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 144.0 / 255.0, blue: 1.0, alpha: 0.1)
    }
    
    @nonobjc class var errorDefault: UIColor {
        return UIColor(red: 1.0, green: 82.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var errorLight: UIColor {
        return UIColor(red: 1.0, green: 82.0 / 255.0, blue: 82.0 / 255.0, alpha: 0.54)
    }
    
    @nonobjc class var errorFadeLight: UIColor {
        return UIColor(red: 1.0, green: 82.0 / 255.0, blue: 82.0 / 255.0, alpha: 0.15)
    }
    
    @nonobjc class var warningDefault: UIColor {
        return UIColor(red: 1.0, green: 227.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warningLight: UIColor {
        return UIColor(red: 1.0, green: 227.0 / 255.0, blue: 82.0 / 255.0, alpha: 0.54)
    }
    
    @nonobjc class var warningFadeLight: UIColor {
        return UIColor(red: 1.0, green: 227.0 / 255.0, blue: 82.0 / 255.0, alpha: 0.15)
    }
    
    @nonobjc class var successDefault: UIColor {
        return UIColor(red: 107.0 / 255.0, green: 236.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var successLight: UIColor {
        return UIColor(red: 107.0 / 255.0, green: 236.0 / 255.0, blue: 101.0 / 255.0, alpha: 0.54)
    }
    
    @nonobjc class var successFadeLight: UIColor {
        return UIColor(red: 107.0 / 255.0, green: 236.0 / 255.0, blue: 101.0 / 255.0, alpha: 0.15)
    }
    
    @nonobjc class var blackDefault: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var blackFade: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.54)
    }
    @nonobjc class var blackFadeLight: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.15)
    }
    
    @nonobjc class var whiteDefautl: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var whiteFade: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.54)
    }
    @nonobjc class var whiteFadeLight: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.15)
    }
    
}

// Text styles

extension UIFont {
    

    class var fontBold: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .bold)
    }
    
    class var fontRegular: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .regular)
    }
    
    class var fontLight: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .light)
    }
    
}

//UIImage

extension UIImage {
    
    // colorize image with given tint color
    // this is similar to Photoshop's "Color" layer blend mode
    // this is perfect for non-greyscale source images, and images that have both highlights and shadows that should be preserved
    // white will stay white and black will stay black as the lightness of the image is preserved
    func tint(tintColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw black background - workaround to preserve color of partially transparent pixels
            context.setBlendMode(.normal)
            UIColor.black.setFill()
            context.fill(rect)
            
            // draw original image
            context.setBlendMode(.normal)
            context.draw(self.cgImage!, in: rect)
            
            // tint image (loosing alpha) - the luminosity of the original image is preserved
            context.setBlendMode(.color)
            tintColor.setFill()
            context.fill(rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    // fills the alpha channel of the source image with the given color
    // any color information except to the alpha channel will be ignored
    func fillAlpha(fillColor: UIColor) -> UIImage {
        
        return modifiedImage { context, rect in
            // draw tint color
            context.setBlendMode(.normal)
            fillColor.setFill()
            context.fill(rect)
            //            context.fillCGContextFillRect(context, rect)
            
            // mask by alpha values of original image
            context.setBlendMode(.destinationIn)
            context.draw(self.cgImage!, in: rect)
        }
    }
    
    private func modifiedImage( draw: (CGContext, CGRect) -> ()) -> UIImage {
        
        // using scale correctly preserves retina images
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        // correctly rotate image
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        draw(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
