//
//  TitleSectionView.swift
//  Pokedex
//
//  Created by Christian Boleku on 2024-11-28.
//

import SwiftUI

struct TitleSectionView : View {
	let color : Color
	let title : String
	var subtitle : String = ""
	var body : some View{
		VStack(alignment: .leading, spacing: 8){
			Text(NSLocalizedString(title, comment: "section title"))
				.font(.headline)
				.foregroundColor(
					color
				)
			if !subtitle.isEmpty{
				Text(NSLocalizedString(subtitle, comment: "section subtitle"))
					.font(.body)
					.foregroundStyle(.secondary)
			}
		}
		.padding(.bottom, 2)
	}
}

