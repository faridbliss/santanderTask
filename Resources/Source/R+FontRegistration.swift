//
//  R+FontRegistration.swift
//  Resources
//
//  Created by Farid Ullah on 16/12/2020.
//

import Foundation
import CoreGraphics
import CoreText
//

public extension R {

    static func registerFonts() {
        let fonts = [
            R.file.robotoBoldTtf,
            R.file.robotoBlackTtf,
            R.file.robotoThinTtf,
            R.file.robotoLightTtf,
            R.file.robotoMediumTtf,
            R.file.robotoItalicTtf,
            R.file.robotoRegularTtf,
            R.file.robotoMediumItalicTtf,
            R.file.robotoLightItalicTtf,
            R.file.robotoBlackItalicTtf,
            R.file.robotoBoldItalicTtf,
            R.file.robotoThinItalicTtf
        ]
        fonts.map { $0.url() }
            .forEach { registerFont(url: $0) }
    }

    private static func registerFont(url: URL?) {
            guard let url = url else {
                print("UIFont+:  Failed to register font - url for resource not found.")
                return
            }

            var errorRef: Unmanaged<CFError>? = nil
            if (CTFontManagerRegisterFontsForURL(url as CFURL, .process, &errorRef) == false) {
                print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
            }
        }


}
