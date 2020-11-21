//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-08-18.
//  Copyright © 2020 Banky. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of element: Element) -> Int? {
        for index in 0..<self.count {
            if element.id == self[index].id {
                return index
            }
        }
        
        return nil
    }
}
