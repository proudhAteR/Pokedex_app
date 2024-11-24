import SwiftUI

struct SplashView: View {
    // Pour faire un délai, vous pouvez utiliser l'événement onAppear et
    // exécuter un code asynchrone après X secondes en utilisant :
    //  - https://developer.apple.com/documentation/dispatch/dispatchqueue/2300020-asyncafter
	
	@Binding var isShowingLoginPage : Bool
		var body: some View {
			VStack {
				Image(.logo)
					.resizable()
					.scaledToFill()
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(
				Color.accentColor
					.ignoresSafeArea()
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
