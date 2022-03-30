//
//  HomeView.swift
//  easydo
//
//  Created by Zayn on 12/7/21.


import SwiftUI
import CoreData
//HOMEVIEWMODAL
struct HomeView: View {
	
	@StateObject var control = HomeViewModal()
	@FetchRequest(entity: AllAppData.entity(), sortDescriptors:[], animation: .default)
	var currentData : FetchedResults<AllAppData>
	@Environment(\.managedObjectContext) var context
	
	let layout = [GridItem(.flexible())]
	
	//THEME
	let pickColor: [ColorModal] = ColorsData
	@StateObject var pickedColor = TaskColors()
	
	
	var body: some View {
		ZStack {
			VStack {
				
				HStack {
					Text("Tasks")
						.foregroundColor(pickColor[self.pickedColor.card].mainColor)
						.font(.system(size: 55))
						.fontWeight(.heavy)
						.foregroundColor(.black)
					Spacer()
					
					Button(action: {
						control.showSettingsView.toggle()
					}){
						Image(systemName: "hexagon")
							.font(.system(size: 25))
							.foregroundColor(pickColor[self.pickedColor.card].mainColor)
							.overlay(
								Image(systemName: "hexagon.fill")
									.font(.system(size: 15))
									.foregroundColor(pickColor[self.pickedColor.card].mainColor)
							)
						
					}
					.sheet(isPresented: $control.showSettingsView ) {
						SettingsView()
					}
				}
				.padding()
				.padding(.bottom, -20)
				//show an empty view when there is no tasks
				if currentData.isEmpty {
					
					VStack {
						Spacer()
						Image(systemName: "hand.thumbsup")
							.font(.system(size: 100))
							.padding()
						VStack {
							Text("You're all cought up")
								.fontWeight(.heavy)
								.font(.system(size: 20))
						}
						
						
						Spacer()
						Spacer()
					}
					.foregroundColor(pickColor[self.pickedColor.card].mainColor)
					
				} else {
					ScrollView(.vertical) {
						LazyVGrid(columns: layout) {
							ForEach(currentData, id:\.self) { showData in
								
								
								HStack {
									
									RoundedRectangle(cornerRadius: 100, style: .continuous)
										.foregroundColor(control.cardColor(cardPriority: showData.cardPriority ?? "Normal"))
										.padding(.vertical, 15)
										.frame(width: 5)
									
									VStack {
										
										HStack {
											
											
											Text("\(showData.task ?? "")")
												.foregroundColor(Color.white)
												.font(.system(size: 20, weight: .bold, design: .rounded))
											Spacer()
											
											
											VStack {
												Button(action: {
													context.delete(showData)
													try! context.save()
												}){
													Image(systemName: "trash.circle")
														.font(.system(size: 25))
														.foregroundColor(Color.white)
												}
												.padding(0)
												
												Spacer(minLength: 5)
												Button(action: {
													control.updateItem(item: showData)
													try! context.save()
												}){
													Image(systemName: "pencil.circle")
														.font(.system(size: 25))
														.foregroundColor(Color.white)
												}
												.padding(0)
												
											}
											.padding(.vertical, 5)
											.foregroundColor(Color.primary)
											.padding(.vertical, 0)
											.padding(.horizontal, 5)
											.background(Color.gray.opacity(0.5))
											.cornerRadius(15)
											.shadow(color: Color.black.opacity(0.8), radius: 5, x: 0, y: 0)
										}
										.padding(.vertical, 5)
										.padding(.leading, 25)
										.padding(.trailing, 7)
										
									}
									.frame(maxWidth: .infinity)
									.padding(0)
									.background(control.cardBGColor(cardBackground: showData.cardBackground ?? ""))
									.cornerRadius(21)
									.padding(8)
									.shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 0)
									
								}
								
							}
							
						}.padding()
						
					}
					
				}
				
			}
			
			ZStack {
				Button(action: {
					control.addedData.toggle()
					
				}){
					Image(systemName: "plus")
				}
				.frame(width: 30, height: 30)
				.font(.system(size: 30))
				.padding()
				.foregroundColor(Color.white)
				//                .background(Color.pink)
				.background(pickColor[self.pickedColor.card].mainColor)
				.cornerRadius(100)
				.padding()
				.shadow(color: Color.pink.opacity(0.2), radius: 20, x: 0, y: 0)
				.sheet(isPresented: $control.addedData) {
					NewTaskView(data: control)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
		}.edgesIgnoringSafeArea(.bottom)
	}
}
