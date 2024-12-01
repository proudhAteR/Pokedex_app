import SwiftUI
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
	let captureSession = AVCaptureSession()
	var preview = AVCaptureVideoPreviewLayer()
	let metadataOutput = AVCaptureMetadataOutput()
	var scannedCodeBinding: Binding<String>?
	
	init(scannedCode: Binding<String>) {
		   self.scannedCodeBinding = scannedCode
		   super.init(nibName: nil, bundle: nil)
	   }

	   required init?(coder: NSCoder) {
		   fatalError("init(coder:) has not been implemented")
	   }
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.black

		guard let device = AVCaptureDevice.default(for: .video) else {
			failed()
			return
		}

		var videoInput: AVCaptureDeviceInput

		do {
			videoInput = try AVCaptureDeviceInput(device: device)
		} catch {
			failed()
			return
		}

		if captureSession.canAddInput(videoInput) {
			captureSession.addInput(videoInput)
		} else {
			failed()
			return
		}
		preview = AVCaptureVideoPreviewLayer(session: captureSession)
		preview.frame = view.layer.bounds
		preview.videoGravity = .resizeAspectFill
		view.layer.addSublayer(preview)
		if captureSession.canAddOutput(metadataOutput) {
				captureSession.addOutput(metadataOutput)
				metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
				metadataOutput.metadataObjectTypes = [.qr]

					let squareSize: CGFloat = 200 // Fixed size for the square
					let visibleRect = CGRect(
						x: (view.bounds.width - squareSize) / 2,  // Center horizontally
						y: (view.bounds.height - squareSize) / 2, // Center vertically
						width: squareSize,
						height: squareSize
					)

				// Convert to normalized coordinates for rectOfInterest
				let rectOfInterest = preview.metadataOutputRectConverted(fromLayerRect: visibleRect)
				metadataOutput.rectOfInterest = rectOfInterest

				// Add a visible overlay for the scanning area
				let rectLayer = CALayer()
				rectLayer.frame = visibleRect
				rectLayer.borderColor = UIColor.white.cgColor
				rectLayer.borderWidth = 2
				rectLayer.cornerRadius = 12
				view.layer.addSublayer(rectLayer)
			} else {
				failed()
				return
			}



		captureSession.startRunning()
	}

	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		if let metadataObject = metadataObjects.first {
			guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
			guard let stringValue = readableObject.stringValue else { return }
			AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
			found(code: stringValue)
			captureSession.stopRunning()
		}
		
	}

	func found(code: String) {
		scannedCodeBinding?.wrappedValue = code 
		self.dismiss(animated: true)
	}

	func failed() {
		let ac = UIAlertController(title: "Scanning not supported",
								   message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
								   preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK", style: .default))
		present(ac, animated: true)
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait
	}
}
