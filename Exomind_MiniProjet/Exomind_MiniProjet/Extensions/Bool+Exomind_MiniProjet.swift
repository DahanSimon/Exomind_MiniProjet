//
//  Bool+Exomind_MiniProjet.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 25/03/2023.
//

import Foundation

extension Optional {
    func notNil() -> Bool {
        if self != nil {
            return true
        }
        return false
    }
}
