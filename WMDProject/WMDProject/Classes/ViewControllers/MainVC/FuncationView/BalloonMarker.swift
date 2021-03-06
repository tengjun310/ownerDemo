//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import Charts

open class BalloonMarker: MarkerImage
{
    @objc open var color: UIColor
    @objc open var arrowSize = CGSize(width: 15, height: 11)
    @objc open var font: UIFont
    @objc open var textColor: UIColor
    @objc open var insets: UIEdgeInsets
    @objc open var minimumSize = CGSize()
    
    fileprivate var label: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedString.Key : AnyObject]()
    
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .left
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size

        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }

        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0

        var origin = point
        origin.x -= width / 2
        origin.y -= height

        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }

        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }

        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()

        context.setFillColor(color.cgColor)

        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }

        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        if (entry.data?.isKind(of: SeaWaterLevelInfoModel.self))! {
            let model:SeaWaterLevelInfoModel = entry.data as! SeaWaterLevelInfoModel;
            let str:NSString = CommonUtils.formatTime(CommonUtils.getFormatTime(model.forecastdate, formatStyle: "yyyy-MM-dd HH:mm:ss"), formatStyle: "MM/dd HH:mm")! as NSString
            setLabel(String(format: " %@\n %@m", str,model.tideheight))
        }
        else if (entry.data?.isKind(of: SeaDataInfoModel.self))! {
            let model:SeaDataInfoModel = entry.data as! SeaDataInfoModel;
            if model.type.isEqual("2") {
                let str:NSString = CommonUtils.formatTime(CommonUtils.getFormatTime(model.forecasttime, formatStyle: "yyyy-MM-dd HH:mm:ss"), formatStyle: "MM/dd HH:mm")! as NSString
                setLabel(String(format: " %@\n %@m %@", str,model.waveheight,model.wavedfrom))
            }
            else if model.type.isEqual("3") {
                let str:NSString = CommonUtils.formatTime(CommonUtils.getFormatTime(model.forecasttime, formatStyle: "yyyy-MM-dd HH:mm:ss"), formatStyle: "MM/dd HH:mm")! as NSString
                setLabel(String(format: " %@\n %@℃", str,model.sstdata))
            }
            else if model.type.isEqual("4") {
                let str:NSString = CommonUtils.formatTime(CommonUtils.getFormatTime(model.forecasttime, formatStyle: "yyyy-MM-dd HH:mm:ss"), formatStyle: "MM/dd HH:mm")! as NSString
                setLabel(String(format: " %@\n %@m/s %@", str,model.swspeed,model.swdirection))
            }
        }
        else if (entry.data?.isKind(of: SeaStreamInfoModel.self))! {
            let model:SeaStreamInfoModel = entry.data as! SeaStreamInfoModel;
            if model.type.isEqual("1") {
                let str:NSString = CommonUtils.formatTime(CommonUtils.getFormatTime(model.forecastdate, formatStyle: "yyyy-MM-dd HH:mm:ss"), formatStyle: "MM/dd HH:mm")! as NSString
                setLabel(String(format: " %@ \n %@m/s %@°", str,model.wavespeed,model.wavedfrom))
            }
            else if model.type.isEqual("2") {
                let str:NSString = CommonUtils.formatTime(CommonUtils.getFormatTime(model.forecastdate, formatStyle: "yyyy-MM-dd HH:mm:ss"), formatStyle: "MM/dd HH:mm")! as NSString
                setLabel(String(format: " %@\n %@", str,model.wavedfrom))
            }
        }
        else if (entry.data?.isKind(of: SpeedInfoModel.self))! {
            let model:SpeedInfoModel = entry.data as! SpeedInfoModel;
            setLabel(String(format: " %@m %.f%%", model.speed,Float(model.rate)!))
        }
        else if (entry.data?.isKind(of: DirectionInfoModel.self))! {
            let model:DirectionInfoModel = entry.data as! DirectionInfoModel;
            setLabel(String(format: " %@ %.f%%", model.direction,Float(model.rate)!*100))
        }
    }
    
    @objc open func setLabel(_ newLabel: String)
    {
        label = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}
