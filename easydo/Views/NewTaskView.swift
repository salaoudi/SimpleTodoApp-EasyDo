//
//  NewTaskView.swift
//  easydo
//
//  Created by Zayn on 12/7/21.
//

import SwiftUI
//NEWTASKVIEW
struct NewTaskView: View {
    
    @ObservedObject var data: HomeViewModal
    @Environment(\.managedObjectContext) var context
    
    
    //COLORS - CARD COLORS
    let pickColor: [ColorModal] = ColorsData
    @StateObject var pickedColor = TaskColors()
    
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(data.updatedItemData == nil ? "Add A New " : "Update " )Task")
                        .font(.system(size: 65))
                        .fontWeight(.heavy)
                        .foregroundColor(pickColor[self.pickedColor.card].mainColor)
                    Spacer()
                }
                .padding()
                
                HStack {
                    TextField("Enter a task", text: $data.task)
                        .font(.system(size: 20))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 30)
                        //                        .background(pickColor[self.pickedColor.card].mainColor)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(11)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
                        .padding()
                    
                }.padding(.top, -20)
                
                if (data.updatedItemData != nil) {
                    
                } else {
                    VStack {
                        HStack {
                            Text("Card Color")
                            Spacer()
                        }.padding(.horizontal)
                        HStack {
                            
                            Picker("Card color", selection: $data.cardBackground) {
                                ForEach(data.allColors, id: \.self) { color in
                                    HStack {
                                        Text(color)
                                    }
                                    
                                }
                                
                            }.pickerStyle(SegmentedPickerStyle())
                            
                        }
                        .padding(.horizontal)
                    }
                    VStack {
                        HStack {
                            Text("Task priority")
                            Spacer()
                        }.padding(.horizontal)
                        HStack {
                            Picker("Priority", selection: $data.cardPriority) {
                                ForEach(data.allPriorities, id: \.self) { prio in
                                    Text(prio)
                                }
                                
                            }.pickerStyle(SegmentedPickerStyle())
                            
                        }
                        .padding(.horizontal)
                    }
                    
                }
                
                //                VStack {
                //                    HStack {
                //                        Text("Pick a color")
                //                            .font(.system(size: 16))
                //                            .fontWeight(.bold)
                //                            .foregroundColor(.primary)
                //                        Spacer()
                //                    }.padding(.horizontal)
                //                    HStack {
                //
                //                        ForEach(pickColor, id: \.id) { color in
                //                            Button(action: {
                //                                self.pickedColor.card = color.id
                //                                UserDefaults.standard.set(self.pickedColor.card, forKey: "ColorModal")
                //                            }){
                //
                //                                Circle()
                //                                    .fill(color.mainColor)
                //                                    .frame(width: 41, height: 41)
                //                                Spacer()
                //                            }
                //                        }
                //                    }
                //                    .padding(.horizontal)
                //                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        data.getData(context: context)
                    }){
                        Text(data.updatedItemData == nil ? "Save Task" : "Update Task")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    .frame(maxWidth: .infinity, maxHeight: 30)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(pickColor[self.pickedColor.card].mainColor)
                    //                    .background(Color.pink.opacity(0.9))
                    .cornerRadius(20)
                    .disabled(data.task == "" ? true : false)
                    .opacity(data.task == "" ? 0.4 : 1)
                }
                .padding(.vertical, 30)
                .padding(.horizontal)
                
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}
