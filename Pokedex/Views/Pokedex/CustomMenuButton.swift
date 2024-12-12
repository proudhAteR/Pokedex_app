import SwiftUI

struct CustomMenuButton: View {
	let action: () -> Void
	let label: String
	let image: String
	
	var body: some View {
		Button(action: action) {
			HStack {
				Text(label)
				Spacer()
				Image(systemName: image)
			}
			.padding()
			.cornerRadius(8)
		}
	}
}
#Preview {
	CustomMenuButton(action: {
		print("abana")
	}, label: "Bonjour", image: "cat.fill")
}
