//
//  ContentView.swift
//  LiquideSwipeApp
//
//  Created by Pouya Sadri on 23/01/2024.
//

import SwiftUI
//MARK: - Content View
struct ContentView: View {
    var body: some View {
		ZStack{
			SwipeView()
		}
    }
}

#Preview {
    ContentView()
}
//MARK: - Swipe view
struct SwipeView : View {
	@State private var offset : CGSize = .zero
	@State private var showMainView = false
	var body: some View {
		ZStack{
			backgroundGradient
				.overlay(swipeContent)
				.clipShape(LiquidSwipe(Offset: offset))
				.ignoresSafeArea()
				.overlay(swipeButton,alignment: .topTrailing)
				.padding(.trailing)
			
			if showMainView {
				PageUIView()
					.onTapGesture {
						withAnimation(.spring){
							offset = .zero
							showMainView.toggle()
						}
					}
			}
		}
	}
	
	//MARK: - UI Components
	private var backgroundGradient : some View{
		RadialGradient(gradient: Gradient(colors: [.orange,.red]), center: .center, startRadius: 2, endRadius: 650)
	}
	
	private var swipeContent : some View{
		VStack(alignment: .leading,spacing: 5){
			SwipeImage(name: "the", width: 200, height: 80, xOffset: 80, yOffset: 10)
			SwipeImage(name: "ti", width: 350, height: 100, xOffset: 70, yOffset: 10)
			SwipeText(text: "By Pouya Sadri", xOffset: 250)
			SwipeImage(name: "spartan", width: 480, height: 350, xOffset: 20, yOffset: 180)
		}
		.foregroundStyle(.red)
		.shadow(color: .red, radius: 1)
		.padding(.horizontal,30)
		.offset(x: -15)
	}
	private var swipeButton : some View{
		Text("01")
			.font(.largeTitle)
			.fontWeight(.medium)
			.frame(width: 50,height: 50)
			.contentShape(Rectangle())
			.gesture(
				DragGesture().onChanged(handleSwipeChange).onEnded(handleSwipeEnd)
			)
			.offset(x:15, y: 58)
			.opacity(offset == .zero ? 1 : 0)
	}
	
	private func handleSwipeChange(_ value: DragGesture.Value){
		withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6,blendDuration: 0.6)){
			offset = value.translation
		}
	}
	
	private func handleSwipeEnd(_ value: DragGesture.Value){
		let screen = UIScreen.main.bounds
		withAnimation(.spring()){
			if -offset.width > screen.width / 2 {
				offset.width = -screen.height
				showMainView.toggle()
			}else{
				offset = .zero
			}
		}
	}
}

//MARK: - Liquid Swipe Shape
struct LiquidSwipe: Shape{
	var Offset : CGSize
	
	var animatableData: CGSize.AnimatableData{
		get{Offset.animatableData}
		set{Offset.animatableData = newValue}
	}
	
	func path(in rect: CGRect) -> Path {
		Path {
			path in
			let width = rect.width + (-Offset.width > 0 ? Offset.width : 0)
			path.move(to: CGPoint(x: 0, y: 0))
			path.addLine(to: CGPoint(x: rect.width, y: 0))
			path.addLine(to: CGPoint(x: rect.width, y: rect.height))
			path.addLine(to: CGPoint(x: 0, y: rect.height))
			
			let from = 80 + (Offset.width)
			path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
			
			var to = 180 + (Offset.height) + (-Offset.width)
			
			to = to < 180 ? 180 : to
			
			let midpoint : CGFloat = 80 + ((to - 80) / 2)
			path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: midpoint), control2: CGPoint(x: width - 50, y: midpoint))
		}
	}
}

//MARK: - Swipe Images and Swipe Text
struct SwipeImage: View {
	let name : String
	let width : CGFloat
	let height : CGFloat
	let xOffset : CGFloat
	let yOffset : CGFloat
	
	var body: some View {
		Image(name)
			.resizable()
			.scaledToFit()
			.frame(width: width,height: height)
			.opacity(0.9)
			.offset(x: xOffset, y: yOffset)
		
	}
}

struct SwipeText : View {
	let text : String
	let xOffset : CGFloat
	
	var body: some View {
		Text(text)
			.font(.title)
			.fontWeight(.light)
			.foregroundStyle(.white)
			.offset(x: xOffset)
	}
}
