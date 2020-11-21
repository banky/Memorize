//
//  Array+Only.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-11-21.
//  Copyright © 2020 Banky. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
