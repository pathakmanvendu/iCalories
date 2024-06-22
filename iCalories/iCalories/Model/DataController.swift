//
//  DataController.swift
//  iCalories
//
//  Created by manvendu pathak  on 22/06/24.
//

import Foundation
import CoreData


//We define the class to be observableObject so that we can observe this class for any changes in it and then update accordingly.
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores(completionHandler: { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        })
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Data is saved ")
        }catch {
            print("We could not save the data")
        }
    }
    
    func addFood(name: String, calories: Double, context: NSManagedObjectContext){
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext){
        food.date = Date()
        food.name = name
        food.calories = calories
        
        save(context: context)
    }
    
}
