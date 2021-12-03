//
//  CommentManager.swift
//  NaverBlog-iOS
//
//  Created by 배은서 on 2021/12/03.
//

import Foundation
import Alamofire

class CommentManager {
    static let shared = CommentManager()
    
    func inquiryComment(postId: Int,
                        completion: @escaping (NetworkResult<Any>) -> (Void)) {
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        let dataRequest = AF.request(Const.API.getPostCommentsURL(postId: "\(postId)"),
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        responseData(dataRequest, completion)
    }
    
    private func responseData(_ dataRequest: DataRequest, _ completion: @escaping (NetworkResult<Any>) -> Void) {
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else { return }
                print(statusCode)
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let error):
                print(error)
                completion(.pathErr)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        guard let decodedData = try? JSONDecoder().decode(CommentResponse.self, from: data)
        else { return .pathErr }
        
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

}
