//
//  AddFoodView.swift
//  iCalories
//
//  Created by manvendu pathak  on 22/06/24.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    var body: some View {
        Form {
            Section {
                
                TextField("Food", text: $name)
                
                VStack{
                    Text("Calores \(Int(calories))")
                    Slider(value: $calories, in: 0...2000, step: 5)
                }
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().addFood(name: name, calories: calories, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    AddFoodView()
}
