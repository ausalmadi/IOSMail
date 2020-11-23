//
//  String.swift
//  iosMail
//
//  Created by David Crispin on 2020-11-23.
//

import Foundation
import UIKit

extension String {
	func htmlAttributedString(size: Float, color: UIColor) -> NSAttributedString? {
		let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                color: \(color.hexString!);
                font-family: -apple-system;
                font-size: \(size)px;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

		guard let data = htmlTemplate.data(using: .utf8) else {
			return nil
		}

		guard let attributedString = try? NSAttributedString(
			data: data,
			options: [.documentType: NSAttributedString.DocumentType.html],
			documentAttributes: nil
		) else {
			return nil
		}

		return attributedString
	}
}

extension UIColor {
	var hexString:String? {
		if let components = self.cgColor.components {
			let r = components[0]
			let g = components[1]
			let b = components[2]
			return  String(format: "#%02x%02x%02x", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
		}
		return nil
	}
}
