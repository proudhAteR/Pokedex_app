//
//  TitleSectionView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct TitleSectionView : View {
	let color : Color
	let text : String
	var body : some View{
		Text(NSLocalizedString(text, comment: "section title"))
			.font(.headline)
			.foregroundColor(
				color
			)
			.padding(.bottom, 8)
	}
}

