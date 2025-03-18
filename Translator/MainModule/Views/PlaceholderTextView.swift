//
//  PlaceholderTextView.swift
//  Translator
//
//  Created by Ксения Маричева on 13.03.2025.
//

import UIKit

protocol PlaceholderTextViewDelegate: AnyObject {
    func didEnter(text: String)
}

class PlaceholderTextView: UITextView {
    
    weak var listener: PlaceholderTextViewDelegate?
    
    var placeholder = "Placeholder" {
        didSet {
            if inPlaceholderMode {
                text = placeholder
            }
        }
    }

    private lazy var inPlaceholderMode = true {
        didSet {
            if inPlaceholderMode {
                text = placeholder
                textColor = .gray
            } else {
                text = ""
                textColor = .black
            }
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        delegate = self
        
        inPlaceholderMode = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if inPlaceholderMode { inPlaceholderMode = false }
        
        if text == "\n" {
            listener?.didEnter(text: textView.text)
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        <#code#>
//    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if text.isEmpty { inPlaceholderMode = true }
    }
}
