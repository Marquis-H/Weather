//
//  SpringAnimation.swift
//  Weather
//
//  Created by Marquis on 16/1/31.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import UIKit

class SpringAnimation: UIView {
    var duration = 0.7
    var delay = 0.0
    var damping = 0.7
    var velocity = 0.7
}

extension SpringAnimation{
    
    func spring(duration: NSTimeInterval, animations: (() -> Void)!){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options:[], animations: {
            animations()
            }, completion: { finished in })
    }
    
    func springWithDelay(duration: NSTimeInterval, delay: NSTimeInterval, animations: (() -> Void)!){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping:  0.7, initialSpringVelocity: 0.8, options: [], animations: {
            animations()
            }, completion: { finished in })
    }
    
    func slideUp(duration: NSTimeInterval, animations: (() -> Void)!){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options:[], animations: {
            animations()
        }, completion: nil)
    }
    
    func springWithCompletion(duration: NSTimeInterval, animations: (() -> Void)!, completion: ((Bool) -> Void)!){
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options:[], animations: {
            animations()
            }, completion: { finished in
                completion(true)
        })
    }
    
    func springScaleFrom(view: UIView, x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat){
        let initTranslationScale = self.initTranslationScale(x, y: y, scaleX: scaleX, scaleY: scaleY)
        view.transform = CGAffineTransformConcat(initTranslationScale["translation"]!, initTranslationScale["scale"]!)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            let initTranslationScale = self.initTranslationScale(0,y: 0,scaleX: 1,scaleY: 1)
            view.transform = CGAffineTransformConcat(initTranslationScale["translation"]!, initTranslationScale["scale"]!)
        }, completion: nil)
    }
    
    func springScaleTo(view: UIView, x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat){
        let initTranslationScale = self.initTranslationScale(0,y: 0,scaleX: 1,scaleY: 1)
        view.transform = CGAffineTransformConcat(initTranslationScale["translation"]!, initTranslationScale["scale"]!)
        
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
            let initTranslationScale = self.initTranslationScale(x, y: y, scaleX: scaleX, scaleY: scaleY)
            view.transform = CGAffineTransformConcat(initTranslationScale["translation"]!, initTranslationScale["scale"]!)
        }, completion: nil)
    }
    
    func popoverTopRight(view: UIView){
        view.hidden = false
        let initTranslationScale = self.initTranslationScale(200, y: -200, scaleX: 0.3, scaleY: 0.3)
        view.alpha = 0
        view.transform = CGAffineTransformConcat(initTranslationScale["translation"]!, initTranslationScale["scale"]!)
        
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [],animations: {
            let initTranslationScale = self.initTranslationScale(0,y: 0,scaleX: 1,scaleY: 1)
            view.transform = CGAffineTransformConcat(initTranslationScale["translation"]!, initTranslationScale["scale"]!)
            view.alpha = 1
        }, completion: nil)
    }
    
    func initTranslationScale(x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat) -> Dictionary<String, CGAffineTransform>{
        return ["translation": CGAffineTransformMakeTranslation(x, y), "scale": CGAffineTransformMakeScale(scaleX, scaleY)]
    }
}