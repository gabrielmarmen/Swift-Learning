//
//  StringExtensions.swift
//  Project 10
//
//  Created by Gabriel Marmen on 2022-08-28.
//

import Foundation

extension String {
  var isBlank: Bool {
    return allSatisfy({ $0.isWhitespace })
  }
}
