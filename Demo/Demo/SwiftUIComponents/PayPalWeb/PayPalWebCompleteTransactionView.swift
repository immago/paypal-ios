import SwiftUI

struct PayPalWebCompleteTransactionView: View {

    @ObservedObject var payPalWebViewModel: PayPalWebViewModel

    var body: some View {
        VStack {
            PayPalWebResultView(payPalWebViewModel: payPalWebViewModel, status: .approved)
            ZStack {
                Button("\(payPalWebViewModel.intent.rawValue)") {
                    Task {
                        do {
                            try await payPalWebViewModel.completeOrder()
                        } catch {
                            print("Error capturing order: \(error.localizedDescription)")
                        }
                    }
                }
                .buttonStyle(RoundedBlueButtonStyle())
                .padding()
                if payPalWebViewModel.state == .loading {
                    CircularProgressView()
                }
            }

            if payPalWebViewModel.state == .success {
                PayPalWebResultView(payPalWebViewModel: payPalWebViewModel, status: .completed)
            }
        }
    }
}
