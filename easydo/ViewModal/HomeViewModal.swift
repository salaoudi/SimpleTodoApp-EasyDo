//
//  HomeViewModal.swift
//  easydo
//
//  Created by Zayn on 12/7/21.
//
//HOMEVIEWMODAL
import SwiftUI
import CoreData

// -------- MVVM PATTERN -----------//

// ALL MAIN FUNCTIONS AND CONTROL ARE LOCATED HERE
// --- USER INPUTS INCLUDING (TASKS, COLORS, UPDATING AND DELETING ITEMS)
// --- ALL STORED VARIBLES ARE CONNECTED TO THIS CLASS.

class HomeViewModal: ObservableObject {
    

    @Published var task = ""
    @Published var addedData = false
    @Published var showSettingsView = false
    @Published var updatedItemData: AllAppData!
    
    //CARD PRIORITY
    @Published var cardPriority: String = "Normal"
    @Published var allPriorities = ["Low", "Normal", "High"]
    //CARD COLOR
    @Published var cardBackground: String = "gray"
    @Published var allColors = ["Blue", "Yellow", "Red", "Pink", "Orange", "Purple"]
    
   
    
   // UPDATE AND SAVE INTO COREDATA
    func getData(context: NSManagedObjectContext) {
        
        //UPDATED ITEMS
        if updatedItemData != nil {
            updatedItemData.task = task
            
            try! context.save()
            
            updatedItemData = nil
            addedData.toggle()
            task = ""
            
            return
        }
        
        // SAVE TO CORE DATA
        let newTask = AllAppData(context: context)
        newTask.task = task
        newTask.cardPriority = cardPriority
        newTask.cardBackground = cardBackground
        
     
        do {
            try context.save()
            addedData.toggle()
            task = ""
        } catch {
            print("Error saving data")
        }
        
    }
    
    //UPDATE ITEM
    func updateItem(item: AllAppData) {
        updatedItemData = item
        task = item.task!
        addedData.toggle()
    }
    
    //THIS FUNCTION CONVERTS STRING TO TYPE COLOR -> FOR PRIORITY
    func cardColor(cardPriority: String) -> Color {
        
        switch cardPriority {
        case "Low":
            return Color.blue
        case "Normal":
            return Color.yellow
        case "High":
            return Color.pink
        default:
            return Color.gray
        }
        
    }
    
    //THIS FUNCTION CONVERTS STRING TO TYPE COLOR -> FOR CARD BACKGROUND COLOR
    func cardBGColor(cardBackground: String) -> Color {
        
        switch cardBackground {
        case "Blue":
            return Color.blue
        case "Yellow":
            return Color.yellow
        case "Red":
            return Color.red
        case "Pink":
            return Color.pink
        case "Orange":
            return Color.orange
        case "Purple":
            return Color.purple
        default:
            return Color.gray
            
        }
    }
    
   
 
}


