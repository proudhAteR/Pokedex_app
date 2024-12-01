// Nous allons revoir ceci au prochain cours
import SwiftUI
import AVFoundation

struct ScannerViewRepresentable : UIViewControllerRepresentable{
	typealias UIViewControllerType = ScannerViewController
	@Binding var scanningRes : String
	func makeUIViewController(context: Context) -> ScannerViewController {
		let scannerVC = ScannerViewController(scannedCode: $scanningRes)
		return scannerVC
	}

	func updateUIViewController(
		_ uiViewController: ScannerViewController,
		context: Context
	) {
		
	}
}

