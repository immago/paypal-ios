import SwiftUI
import PaymentButtons

struct PayPalWebDemoView: View {

    @StateObject var payPalWebViewModel = PayPalWebViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                PayPalWebCreateOrderView(payPalWebViewModel: payPalWebViewModel)
                if payPalWebViewModel.order != nil {
                    PayPalWebResultView(payPalWebViewModel: payPalWebViewModel, status: .started)
                    NavigationLink {
                        PayPalWebButtonsView(payPalWebViewModel: payPalWebViewModel)
                            .navigationTitle("Checkout with PayPal")
                    } label: {
                        Text("Checkout with PayPal")
                    }
                    .buttonStyle(RoundedBlueButtonStyle())
                    .padding()
                }
            }
        }
    }
}
