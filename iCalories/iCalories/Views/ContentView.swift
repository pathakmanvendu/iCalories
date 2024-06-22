//
//  ContentView.swift
//  iCalories
//
//  Created by manvendu pathak  on 22/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    @State private var showingAdView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("\(totalCaloriesToday()) Kcal (Today)")
                    .foregroundStyle(.gray)
                    .padding(.horizontal)
                List{
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food))
                        {
                            HStack{
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    
                                    Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                                }
                                Spacer()
                                
                                Text(calcTimeSince(date: food.date!))
                                    .foregroundStyle(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
                
            }
            .navigationTitle("iCalories")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAdView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAdView, content: {
                AddFoodView()
            })
        
        }
    
    }
        
    private func deleteFood(offsets: IndexSet){
        withAnimation{
            offsets.map{food[$0]}.forEach(managedObjectContext.delete(_:))
            DataController().save(context: managedObjectContext)
        }
    }
    
    private func totalCaloriesToday() -> Int {
        var caloriesToday: Double = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                caloriesToday += item.calories
            }
        }
        return Int(caloriesToday)
    }
}

#Preview {
    ContentView()
}
