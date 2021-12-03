//
//  MyPageDetailService.swift
//  NaverBlog-iOS
//
//  Created by soyeon on 2021/12/03.
//

import Foundation
import Alamofire

struct APIIndex {
  var index: Index
  
  enum Index {
    case id(Int)
    
    func getIndex() -> String {
      switch self {
      case .id(let index):
        return "/\(index)"
      }
    }
  }
}

struct MyPageDetailService {
    static let shared = MyPageDetailService()
    
    func getMyPageDetailInfo(id: Int,
                        completion : @escaping (NetworkResult<Any>) -> Void) {
        let url =  Const.API.baseURL + "/comment" + APIIndex.init(index: .id(id)).index.getIndex()
        print(url)
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { dataResponse in
            print("서버 결과")
            switch dataResponse.result {
            case .success:
                print("성공")
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure:
                print("실패")
                completion(.pathErr)
            }
        }
        
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return isValidData(data: data)
        case 400:
            return .pathErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(MyPageDetailResponseModel.self, from: data) else { return .pathErr }
        return .success(decodedData)
    }
}
