//
//  FileManager-DocumentsDirectory.swift
//  Project 14
//
//  Created by Gabriel Marmen on 2022-09-12.
//

import Foundation


extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
