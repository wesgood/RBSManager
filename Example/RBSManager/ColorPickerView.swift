//
//  ColorPickerView.swift
//  RBSManager_Example
//
//  Created by Wes Goodhoofd on 2018-01-17.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

protocol ColorPickerDelegate {
    func didSelectColour(picker: ColorPickerView, colour: UIColor?)
}

class ColorPickerView: ModalContainerView {
    var redSlider: UISlider?
    var greenSlider: UISlider?
    var blueSlider: UISlider?
    var colourView: UIView?
    var colourDelegate: ColorPickerDelegate?
    var selectedColor: UIColor?
    
    // view info
    var viewHeight: CGFloat = 0
    
    convenience init(colour c: UIColor?) {
        self.init()
        selectedColor = c
    }
    
    override func getRightButton() -> UIButton? {
        let button = createBottomButton(title: "Go", color: ModalContainerView.greenColour)
        button.addTarget(self, action: #selector(onGoButton), for: .touchUpInside)
        return button
    }
    
    override func getLeftButton() -> UIButton? {
        return nil
    }
    
    override func getTitle() -> String? {
        return "Background colour"
    }
    
    override func getMainView(_ availableSize: CGSize) -> UIView? {
        let view = UIView()
        let viewWidth: CGFloat = availableSize.width-20
        view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: viewWidth, height: 0))
        
        // build the views in order
        colourView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: viewWidth/3.0, height: viewWidth/3.0)))
        colourView?.backgroundColor = (selectedColor != nil) ? selectedColor : UIColor.black
        colourView?.center = CGPoint(x: viewWidth/2, y: colourView!.frame.size.height/2 + 10)
        view.addSubview(colourView!)
        viewHeight += colourView!.frame.maxY + 10
        
        redSlider = createSlider("Red", view: view)
        greenSlider = createSlider("Green", view: view)
        blueSlider = createSlider("Blue", view: view)
        
        if let colourObject = selectedColor {
            let rgbColour = colourObject.cgColor
            if let rgbColours = rgbColour.components {
                redSlider?.value = Float(rgbColours[0])
                greenSlider?.value = Float(rgbColours[1])
                blueSlider?.value = Float(rgbColours[2])
            }
        }
        
        view.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: viewWidth, height: viewHeight))
        return view
    }
    
    @objc func onGoButton() {
        colourDelegate?.didSelectColour(picker: self, colour: selectedColor)
        dismiss()
    }
    
    @objc func onSliderChanged() {
        // change the color
        selectedColor = UIColor(red: CGFloat(redSlider!.value), green: CGFloat(greenSlider!.value), blue: CGFloat(blueSlider!.value), alpha: 1.0)
        colourView?.backgroundColor = selectedColor
    }
    
    func createSlider(_ text: String, view: UIView) -> UISlider {
        let margin: CGFloat = 10
        
        let label = UILabel(frame: CGRect(x: margin, y: viewHeight, width: 0, height: 0))
        label.text = text
        label.sizeToFit()
        view.addSubview(label)
        viewHeight += label.frame.size.height + margin/2
        
        let slider = UISlider(frame: CGRect(x: margin, y: viewHeight, width: view.frame.size.width-margin*2, height: 24))
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(onSliderChanged), for: .valueChanged)
        view.addSubview(slider)
        viewHeight += slider.frame.size.height + margin
        return slider
    }
}
