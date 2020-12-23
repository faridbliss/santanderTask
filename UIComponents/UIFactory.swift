//
//  UIFactory.swift
//  UIComponents
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation
import MaterialComponents
import Resources
import AppConstants

public final class UIFactory {
    
    public static func label() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = R.font.robotoBlack(size: 16)
        label.numberOfLines = 0
        return label
    }
}
