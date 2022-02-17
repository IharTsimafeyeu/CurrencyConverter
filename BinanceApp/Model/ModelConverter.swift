import Foundation

struct ModelConverter {
    static let instance = ModelConverter()
    
    func convert(_ serverModel: CurrencyServerModel) -> CurrencyClientModel {
        
        let castPriceDouble = serverModel.price_usd ?? 0.0
        var roundedValue = String(format: "%.1f", castPriceDouble)
        if "\(castPriceDouble)".count > 4 {
            roundedValue = String(format: "%.4f", castPriceDouble)
        }
        let clientModel = CurrencyClientModel(
            name: serverModel.name ?? "",
            priceUsd: roundedValue
        )
        return clientModel
    }
    private init() {}
}

