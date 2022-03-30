//
//  SettingsView.swift
//  easydo
//
//  Created by Zayn on 12/23/21.
//

import SwiftUI
//SETTINGS VIEW
struct SettingsView: View {
    
    let pickColor: [ColorModal] = ColorsData
    @StateObject var pickedColor = TaskColors()
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .foregroundColor(pickColor[self.pickedColor.card].mainColor)
                    .font(.system(size: 55))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .padding(.bottom, -20)
            
            VStack {
                HStack {
                    Text("App theme")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("| selected")
                    Circle()
                        .fill(pickColor[self.pickedColor.card].mainColor)
                        .frame(width: 20, height: 20)
                    Spacer()
                }.padding(.horizontal)
                HStack {
                    
                    ForEach(pickColor, id: \.id) { color in
                        Button(action: {
                            self.pickedColor.card = color.id
                            UserDefaults.standard.set(self.pickedColor.card, forKey: "ColorModal")
                        }){
                            
                            Circle()
                                .fill(color.mainColor)
                                .frame(width: 41, height: 41)
                            Spacer()
                        }
                    }
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)
            }
            
            .padding(.top, 40)
            
            
            Spacer()
        }
    }
}
