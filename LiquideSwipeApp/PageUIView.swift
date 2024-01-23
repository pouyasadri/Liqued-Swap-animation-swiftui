//
//  PageUIView.swift
//  LiquideSwipeApp
//
//  Created by Pouya Sadri on 23/01/2024.
//

import SwiftUI

struct PageUIView: View {
    var body: some View {
		ZStack{
			VStack(spacing:10){
				chapterTitle
				progressBar(width: 300)
				progressBar(width: 400)
				ForEach(0..<15){index in
						LineItem(index: index)
					
				}
			}
		}
    }
	//MARK: - UI Components
	private var chapterTitle : some View{
		HStack{
			Text("Chapter 01")
				.font(.system(size: 40))
				.fontWeight(.light)
			Spacer()
		}
		.padding(.horizontal)
	}
	
	private func progressBar(width : CGFloat) -> some View{
		RoundedRectangle(cornerRadius: 3)
			.frame(width: width,height: 30)
			.opacity(0.2)
	}
}

#Preview {
    PageUIView()
}

//MARK: - LineItem
struct LineItem : View {
	let index : Int
	var body: some View {
		Rectangle()
			.frame(width: 400,height: 30)
			.opacity(0.2)
			.foregroundStyle(.primary)
	}
}
