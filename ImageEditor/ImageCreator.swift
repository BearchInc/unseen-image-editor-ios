//
//  ImageCreator.swift
//  ImageEditor
//
//  Created by Fernando Heck on 1/6/15.
//  Copyright (c) 2015 Heck. All rights reserved.
//

import Foundation

class ImageCreator {
    
    
    
    func createImage(image : UIImage, labels : Array<IQLabelView>, container : UIView) -> UIImage {
        
        UIGraphicsBeginImageContext(image.size);
        
        let bigView = createBigView(image, labels: labels, container: container)
        image.drawInRect(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        bigView.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext();
        return viewImage
    }
    
    func createBigView(image : UIImage, labels : Array<IQLabelView>, container : UIView) -> UIView {
        var bigView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let scalefactor = getScaleFactor(container.frame.size, imageSize: image.size)

        for label in labels {
            addViewToSuperView(label, superView: bigView, scaleFactor: scalefactor)
        }
        
        return bigView
    }
    
    func addViewToSuperView(view : UIView, superView : UIView, scaleFactor : CGFloat) {
        let originalFrame = view.frame
        view.frame = CGRect(x: CGRectGetMinX(originalFrame) * scaleFactor, y: CGRectGetMinY(originalFrame) * scaleFactor, width: CGRectGetWidth(originalFrame) * scaleFactor, height: CGRectGetHeight(originalFrame) * scaleFactor)
        view.removeFromSuperview()
        superView.addSubview(view)
    }
    
    func addLabelToImage(image : UIImage, labels : Array<IQLabelView>, container : UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(image.size, true, 0.0)
        var context = UIGraphicsGetCurrentContext()
        
        
        
//        CGContextTranslateCTM(context, 0, 0)
//        CGContextScaleCTM(context, 1, -1)
        
        image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
        for label in labels {

            var rotateTransform = CGAffineTransformMakeRotation(-label.rotationAngle)
            
            
//            CGContextRotateCTM(context, label.rotationAngle)
            
            var labelText = label.textView.text as NSString
            labelText.drawInRect(getViewDrawRect(label, containerSize: container.frame.size, imageSize: image.size), withAttributes: getLabelAttributes(label))
            
            let minus = CGFloat(-1)

//            CGContextRotateCTM(context, -label.rotationAngle)
        }
        
//        CGContextSaveGState(context);
//        CGContextRestoreGState(context)
//        CGContextScaleCTM(context, 1, -1)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
//        return createImage(image, labels: labels, container: container)
    }
    
    
//    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(M_PI/ 4);
//    CGContextSaveGState(context);
//    CGContextConcatCTM(context, rotateTransform);
//    [[NSString stringWithFormat:@"Score: %d", score] drawAtPoint:textPoint withFont:smallFont];
//    CGContextRestoreGState(context);
    
    private func getViewDrawRect(view : UIView, containerSize : CGSize, imageSize : CGSize) -> CGRect {
        let scaleFactor = getScaleFactor(containerSize, imageSize: imageSize)
        let viewFrame = view.frame
        return CGRect(x: CGRectGetMinX(viewFrame) * scaleFactor, y: CGRectGetMinY(viewFrame) * scaleFactor, width: CGRectGetWidth(viewFrame) * scaleFactor, height: CGRectGetHeight(viewFrame) * scaleFactor)
    }
    
    private func getScaleFactor(viewSize : CGSize, imageSize : CGSize) -> CGFloat {
        return imageSize.width / viewSize.width
    }
    
    private func getLabelAttributes(label : IQLabelView) -> [NSString : NSObject] {
        
        return [
            NSFontAttributeName: label.textView.font,
            NSForegroundColorAttributeName: label.textView.textColor,
        ]
    }
    
    
}