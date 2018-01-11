//
//  SetCardButton.swift
//  Set
//
//  Created by Tatiana Kornilova on 12/31/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit

@IBDesignable class SetCardButton: BorderButton {
   
    var colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    var alphas:[CGFloat] = [1.0, 0.40, 0.15]
    var strokeWidths:[CGFloat] = [ -8, 8, -8]
    var symbols = ["●", "▲", "■"]
    
    var setCard: SetCard? { didSet{updateButton()}}
    
    private func updateButton () {
        if let card = setCard {
            //-------- number & shape -------
            let symbol = symbols [card.shape.idx]
            switch verticalSizeClass {
            case .regular:
                switch card.number {
                case .v1: symbolsString = "\(symbol)"
                case .v2: symbolsString = "\(symbol)\n\(symbol)"
                case .v3: symbolsString = "\(symbol)\n\(symbol)\n\(symbol)"
                }
            case .compact:
                switch card.number {
                case .v1: symbolsString = "\(symbol)"
                case .v2: symbolsString = "\(symbol)\(symbol)"
                case .v3: symbolsString = "\(symbol)\(symbol)\(symbol)"
                }
            case .unspecified: break
            }
            //------ attributes: color & fill-------
            attributes = [
                .strokeColor: colors[card.color.idx],
                .strokeWidth: strokeWidths[card.fill.idx],
                .foregroundColor: colors[card.color.idx].withAlphaComponent(alphas[card.fill.idx])
            ]
            let attrString = NSAttributedString(string: symbolsString, attributes: attributes)
            //---------------------------------------
            setAttributedTitle(attrString, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            isEnabled = true
        } else {
            setAttributedTitle(nil, for: .normal)
            setTitle(nil, for: .normal)
            backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            borderColor =   #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            isEnabled = false
        }
    }
    
    func setBorderColor (color: UIColor) {
        borderColor =  color
        borderWidth = Constants.borderWidth
    }
    
    private var symbolsString = ""
    private var attributes = [NSAttributedStringKey : Any]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    var verticalSizeClass: UIUserInterfaceSizeClass =
                                        UIScreen.main.traitCollection.verticalSizeClass
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if let vsc = previousTraitCollection?.verticalSizeClass {
            switch  vsc {
            case .regular: verticalSizeClass = .compact
                           updateButton()
            case .compact: verticalSizeClass = .regular
                           updateButton()
            case .unspecified: break
            }
        }
    }
    
    private func configure () {
        cornerRadius = Constants.cornerRadius
        titleLabel?.numberOfLines = 0
        borderColor =   Constants.borderColor
        borderWidth = -Constants.borderWidth
    }
    
    //-------------------Constants--------------
    private struct Constants {
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 5.0
        static let borderColor: UIColor   = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
}
