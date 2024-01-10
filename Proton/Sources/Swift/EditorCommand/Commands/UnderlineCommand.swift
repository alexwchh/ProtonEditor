//
//  UnderlineCommand.swift
//  Proton
//
//  Created by Rajdeep Kwatra on 23/7/21.
//  Copyright © 2021 Rajdeep Kwatra. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import UIKit

public class UnderlineCommand: EditorCommand {
    //    public init() {
    //        super.init(attributeKey: .underlineStyle,
    //                   attributeValue: NSUnderlineStyle.single,
    //                   name:CommandName("_StrikethroughCommand"))
    //
    //    }
    
    public let attributeKey:NSAttributedString.Key = .underlineStyle
    public let attributeValue = NSUnderlineStyle.single.rawValue
    public var isEnable: Bool
    public let name: CommandName
    
    public init(name: String, isEnable:Bool = true){
        self.name = CommandName(name)
        self.isEnable = isEnable
    }
    

    
    public func execute(on editor: EditorView) {
        let selectedText = editor.selectedText
        if editor.isEmpty || editor.selectedRange == .zero || selectedText.length == 0 {
            
//            if editor.typingAttributes[attributeKey] == nil {
//                editor.typingAttributes[attributeKey] = attributeValue
//            } else {
//                var typingAttributes = editor.typingAttributes
//                typingAttributes[attributeKey] = nil
//                editor.typingAttributes = typingAttributes
//            }
            if isEnable {
                editor.typingAttributes[attributeKey] = attributeValue
            } else {
                var typingAttributes = editor.typingAttributes
                typingAttributes[attributeKey] = nil
                editor.typingAttributes = typingAttributes
            }
            
            return
        }
        
//        _ = selectedText.attribute(attributeKey, at: 0, effectiveRange: nil)
     
        
        editor.attributedText.enumerateAttribute(attributeKey, in: editor.selectedRange, options: .longestEffectiveRangeNotRequired) { attrValue, range, _ in
            
//            if initAttr == nil {
            if isEnable {
                editor.addAttribute(attributeKey, value: attributeValue, at: range)
            } else {
                editor.removeAttribute(attributeKey, at: range)
            }
        }
        

        
    }
}
