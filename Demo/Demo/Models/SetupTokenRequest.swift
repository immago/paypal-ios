import Foundation

struct VaultExperienceContext: Encodable {

    let returnUrl = "sdk.ios.paypal://vault/success"
    let cancelUrl = "sdk.ios.paypal://vault/cancel"

    enum CodingKeys: String, CodingKey {
        case returnUrl = "return_url"
        case cancelUrl = "cancel_url"
    }
}

struct PayPal: Encodable {

    var usageType: String
    let experienceContext = VaultExperienceContext()

    enum CodingKeys: String, CodingKey {
        case usageType = "usage_type"
        case experienceContext = "experience_context"
    }
}

enum PaymentSourceType: Encodable {
    case card
    case paypal(usageType: String)

    private enum CodingKeys: String, CodingKey {
        case card, paypal
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .card:
            try container.encode(EmptyBodyParams(), forKey: .card)
        case .paypal(let usageType):
            try container.encode(PayPal(usageType: usageType), forKey: .paypal)
        }
    }
}

struct VaultCustomer: Encodable {

    var id: String?

    private enum CodingKeys: String, CodingKey {
        case id
    }
}

struct SetupTokenRequestBody: Encodable {

    var customer: VaultCustomer?
    let paymentSource: PaymentSourceType

    enum CodingKeys: String, CodingKey {
        case paymentSource = "payment_source"
        case customer
    }
}

struct SetUpTokenRequest: Encodable {

    let customerID: String?
    let paymentSource: PaymentSourceType

    var path: String {
        "/setup_tokens/"
    }

    var method: String {
        "POST"
    }
    
    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        let requestBodyParam = SetupTokenRequestBody(customer: VaultCustomer(id: customerID), paymentSource: paymentSource)
        return try? JSONEncoder().encode(requestBodyParam)
    }
}
