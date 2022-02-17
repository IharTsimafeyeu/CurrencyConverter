import Foundation

struct ModelConverter {
    static let instance = ModelConverter()
    func convert(_ serverModel: CurrencyServerModel) -> CurrencyClientModel {
        let clientModel = CurrencyClientModel(name: serverModel.name ?? "",
                                              priceUsd: serverModel.price_usd ?? 0
        )
        return clientModel
    }
    private init() {}
}

