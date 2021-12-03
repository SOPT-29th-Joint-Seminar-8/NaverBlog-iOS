//
//  FeedNetworkManager.swift
//  NaverBlog-iOS
//
//  Created by Noah on 2021/12/03.
//

import Alamofire

enum ServiceType {
	case RequestFeed
	case SendLikeToServer
}

struct FeedNetworkManager {
	static let shared = FeedNetworkManager()
	
	private init() {}
	
	func requestGetFeed(completion: @escaping (NetworkResult<Any>) -> Void) {
		let url = Const.API.getMainFeedURL
		let header: HTTPHeaders = [
			"Content-Type": "application/json",
		]
		
		let dataRequest = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: header)
		
		dataRequest.responseData { dataResponse in
			switch dataResponse.result {
			case .success:
				guard let statusCode = dataResponse.response?.statusCode,
					  let value = dataResponse.value else { return }
				
				let networkResult = self.judgeStatusCode(by: statusCode, value, serviceType: .RequestFeed)
				completion(networkResult)
			case .failure:
				completion(.networkFail)
			}
		}
	}
	
	private func judgeStatusCode(by statusCode: Int, _ value: Data, serviceType: ServiceType) -> NetworkResult<Any> {
		switch statusCode {
		case 200: return isValidData(value, serviceType)
		case 400: return .pathErr
		case 500: return .serverErr
		default: return .networkFail
		}
	}
	
	private func isValidData(_ data: Data, _ serviceType: ServiceType) -> NetworkResult<Any> {
		let decoder = JSONDecoder()
		do {
			switch serviceType {
			case .RequestFeed:
				let decodedData = try decoder.decode(FeedNetworkModel.self, from: data)
				return .success(decodedData)
			case .SendLikeToServer:
				let decodedData = try decoder.decode(FeedNetworkModel.self, from: data)
				return .success(decodedData)
			}
		} catch {
			return .requestErr(error)
		}
	}
	
}
