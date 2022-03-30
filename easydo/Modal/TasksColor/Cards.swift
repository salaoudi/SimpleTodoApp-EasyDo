//
//  Cards.swift
//  easydo
//
//  Created by Zayn on 12/23/21.
//

import SwiftUI
//CARDS ROW
class TaskColors: ObservableObject {
    @Published var card: Int = UserDefaults.standard.integer(forKey: "ColorModal") {
        
        didSet {
            UserDefaults.standard.setValue(self.card, forKey: "ColorModal")
        }
        
    }
    
    
    
}
