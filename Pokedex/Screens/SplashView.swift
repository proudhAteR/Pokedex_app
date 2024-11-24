import SwiftUI

struct SplashView: View {
    // Pour faire un délai, vous pouvez utiliser l'événement onAppear et
    // exécuter un code asynchrone après X secondes en utilisant :
    //  - https://developer.apple.com/documentation/dispatch/dispatchqueue/2300020-asyncafter
	
	@Binding var isShowingLoginPage : Bool

		var body: some View {
			VStack {
				Image(.logo) // Use your asset name here
					.resizable()
					.scaledToFill() // Ensures the image scales proportionally
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(
				Color.red
					.ignoresSafeArea() // Full-screen red background
			)
			.onAppear {
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					withAnimation {
						isShowingLoginPage = true
					}
				}
			}
		}
		
		
}


#Preview {
	@Previewable @State var isShowingLoginPage : Bool = false
	SplashView(isShowingLoginPage: $isShowingLoginPage)
}
