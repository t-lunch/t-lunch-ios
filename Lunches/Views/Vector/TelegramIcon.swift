//
//  TelegramIcon.swift
//  Lunches
//
//  Created by Андрей Степанов on 14.02.2025.
//

import SwiftUI

struct TelegramIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.70442*width, y: 0.2993*height))
        path.addCurve(to: CGPoint(x: 0.70515*width, y: 0.2993*height), control1: CGPoint(x: 0.70461*width, y: 0.2993*height), control2: CGPoint(x: 0.70488*width, y: 0.2993*height))
        path.addCurve(to: CGPoint(x: 0.7238*width, y: 0.30518*height), control1: CGPoint(x: 0.71208*width, y: 0.2993*height), control2: CGPoint(x: 0.71853*width, y: 0.30146*height))
        path.addLine(to: CGPoint(x: 0.72371*width, y: 0.30511*height))
        path.addCurve(to: CGPoint(x: 0.73078*width, y: 0.31849*height), control1: CGPoint(x: 0.72756*width, y: 0.30847*height), control2: CGPoint(x: 0.73015*width, y: 0.31318*height))
        path.addLine(to: CGPoint(x: 0.73078*width, y: 0.31859*height))
        path.addCurve(to: CGPoint(x: 0.73181*width, y: 0.33204*height), control1: CGPoint(x: 0.73144*width, y: 0.32264*height), control2: CGPoint(x: 0.73181*width, y: 0.32729*height))
        path.addCurve(to: CGPoint(x: 0.73157*width, y: 0.33845*height), control1: CGPoint(x: 0.73181*width, y: 0.3342*height), control2: CGPoint(x: 0.73174*width, y: 0.33632*height))
        path.addLine(to: CGPoint(x: 0.73157*width, y: 0.33815*height))
        path.addCurve(to: CGPoint(x: 0.67523*width, y: 0.69558*height), control1: CGPoint(x: 0.7241*width, y: 0.4168*height), control2: CGPoint(x: 0.6917*width, y: 0.60754*height))
        path.addCurve(to: CGPoint(x: 0.64127*width, y: 0.74655*height), control1: CGPoint(x: 0.66826*width, y: 0.73287*height), control2: CGPoint(x: 0.65455*width, y: 0.74535*height))
        path.addCurve(to: CGPoint(x: 0.56255*width, y: 0.70916*height), control1: CGPoint(x: 0.61242*width, y: 0.74924*height), control2: CGPoint(x: 0.5905*width, y: 0.72749*height))
        path.addCurve(to: CGPoint(x: 0.45159*width, y: 0.63459*height), control1: CGPoint(x: 0.51879*width, y: 0.68044*height), control2: CGPoint(x: 0.49406*width, y: 0.66258*height))
        path.addCurve(to: CGPoint(x: 0.46228*width, y: 0.55544*height), control1: CGPoint(x: 0.40249*width, y: 0.60229*height), control2: CGPoint(x: 0.43433*width, y: 0.58446*height))
        path.addCurve(to: CGPoint(x: 0.5993*width, y: 0.42161*height), control1: CGPoint(x: 0.46962*width, y: 0.54781*height), control2: CGPoint(x: 0.59681*width, y: 0.4321*height))
        path.addCurve(to: CGPoint(x: 0.5995*width, y: 0.41956*height), control1: CGPoint(x: 0.59944*width, y: 0.42098*height), control2: CGPoint(x: 0.5995*width, y: 0.42029*height))
        path.addCurve(to: CGPoint(x: 0.59698*width, y: 0.41282*height), control1: CGPoint(x: 0.5995*width, y: 0.41697*height), control2: CGPoint(x: 0.59854*width, y: 0.41461*height))
        path.addCurve(to: CGPoint(x: 0.59084*width, y: 0.41106*height), control1: CGPoint(x: 0.59525*width, y: 0.41169*height), control2: CGPoint(x: 0.59309*width, y: 0.41106*height))
        path.addCurve(to: CGPoint(x: 0.58659*width, y: 0.41185*height), control1: CGPoint(x: 0.58934*width, y: 0.41106*height), control2: CGPoint(x: 0.58791*width, y: 0.41135*height))
        path.addLine(to: CGPoint(x: 0.58665*width, y: 0.41182*height))
        path.addCurve(to: CGPoint(x: 0.37696*width, y: 0.5504*height), control1: CGPoint(x: 0.58227*width, y: 0.41282*height), control2: CGPoint(x: 0.51237*width, y: 0.45901*height))
        path.addCurve(to: CGPoint(x: 0.32321*width, y: 0.57029*height), control1: CGPoint(x: 0.36218*width, y: 0.56205*height), control2: CGPoint(x: 0.34353*width, y: 0.56942*height))
        path.addLine(to: CGPoint(x: 0.32301*width, y: 0.57029*height))
        path.addCurve(to: CGPoint(x: 0.24329*width, y: 0.55126*height), control1: CGPoint(x: 0.29422*width, y: 0.5668*height), control2: CGPoint(x: 0.26809*width, y: 0.56039*height))
        path.addLine(to: CGPoint(x: 0.24575*width, y: 0.55206*height))
        path.addCurve(to: CGPoint(x: 0.192*width, y: 0.51936*height), control1: CGPoint(x: 0.21461*width, y: 0.5419*height), control2: CGPoint(x: 0.18987*width, y: 0.53655*height))
        path.addCurve(to: CGPoint(x: 0.22898*width, y: 0.4919*height), control1: CGPoint(x: 0.19313*width, y: 0.51041*height), control2: CGPoint(x: 0.20546*width, y: 0.50126*height))
        path.addCurve(to: CGPoint(x: 0.51892*width, y: 0.36703*height), control1: CGPoint(x: 0.37392*width, y: 0.42875*height), control2: CGPoint(x: 0.47056*width, y: 0.38713*height))
        path.addCurve(to: CGPoint(x: 0.69917*width, y: 0.3003*height), control1: CGPoint(x: 0.57228*width, y: 0.33871*height), control2: CGPoint(x: 0.63413*width, y: 0.3154*height))
        path.addLine(to: CGPoint(x: 0.70438*width, y: 0.29927*height))
        path.addLine(to: CGPoint(x: 0.70442*width, y: 0.2993*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.49884*width, y: 0))
        path.addCurve(to: CGPoint(x: 0, y: 0.5*height), control1: CGPoint(x: 0.22321*width, y: 0.00066*height), control2: CGPoint(x: 0, y: 0.22427*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: height), control1: CGPoint(x: 0, y: 0.77613*height), control2: CGPoint(x: 0.22384*width, y: height))
        path.addCurve(to: CGPoint(x: width, y: 0.5*height), control1: CGPoint(x: 0.77616*width, y: height), control2: CGPoint(x: width, y: 0.77616*height))
        path.addCurve(to: CGPoint(x: 0.50123*width, y: 0), control1: CGPoint(x: width, y: 0.22427*height), control2: CGPoint(x: 0.77679*width, y: 0.00066*height))
        path.addLine(to: CGPoint(x: 0.50116*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.49884*width, y: 0), control1: CGPoint(x: 0.50039*width, y: 0), control2: CGPoint(x: 0.49961*width, y: 0))
        path.closeSubpath()
        return path
    }
}
