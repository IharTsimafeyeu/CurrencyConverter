import Alamofire

struct APIManager {
    static let instance = APIManager()
    
    enum Constants {
        static let baseURL = "https://rest.coinapi.io/v1"
    }
    
    enum EndPoint {
        static let assets = "/assets"
    }
    
    private let header: HTTPHeaders = [
        "X-CoinAPI-Key": "25D7A788-FA38-4E04-A459-D666F04A757D",
    ]
    func getAssets(completion: @escaping(([CurrencyClientModel]) -> Void)) {
        AF.request(
            Constants.baseURL + EndPoint.assets,
            method: .get,
            parameters: [:],
            headers: header
        ).responseDecodable(of: [CurrencyServerModel].self) { response in
            switch response.result {
            case .success(let data):
                let converteredModels = data.map(ModelConverter.instance.convert)
                completion(converteredModels)
            case .failure(let error): print(error)
            }
        }
    }
    private init() { }
}
