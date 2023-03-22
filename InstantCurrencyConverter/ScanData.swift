//
//  ScanData.swift
//  InstantCurrencyConverter
//
//  Created by KADIR ISMAILI on 17.3.23.
//

import Foundation


struct ScanData: Identifiable {
    var id = UUID()
    let content: String
    
    
    init(content: String) {
        self.content = content
    }
}
