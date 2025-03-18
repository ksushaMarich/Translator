//
//  TranslationLabel.swift
//  Translator
//
//  Created by Ксения Маричева on 13.03.2025.
//

import UIKit

class TranslationLabel: UILabel {
    
    //MARK: - naming
    var textInsets: UIEdgeInsets

    //MARK: - init
    init(textInsets: UIEdgeInsets) {
        self.textInsets = textInsets
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    override func drawText(in rect: CGRect) {
        let insetsRect = rect.inset(by: textInsets)
        let textHeight = super.intrinsicContentSize.height // Реальная высота текста
        
        super.drawText(in: CGRect(x: insetsRect.origin.x,
                                  y: insetsRect.origin.y, // Оставляем текст у верхнего края
                                  width: insetsRect.width,
                                  height: min(textHeight, insetsRect.height)))
    }

    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let width = originalSize.width + textInsets.left + textInsets.right
        let height = originalSize.height + textInsets.top + textInsets.bottom
        return CGSize(width: width, height: height)
    }
}
