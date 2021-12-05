//
//  File.swift
//  
//
//  Created by alip on 05/12/21.
//

import Combine
import GGGamingCore

public class RepositoryMock<Request, Response>: Repository {
  private var isError = false
  private var data: Response

  public init(data: Response) {
    self.data = data
  }

  public func execute(request: Request?) -> AnyPublisher<Response, Error> {
    return Future<Response, Error> { [self] completion in
      if self.isError {
        completion(.failure(URLError.operationFailed))
      } else {
        completion(.success(self.data))
      }
    }
    .eraseToAnyPublisher()
  }

  public func setError(to isError: Bool) {
    self.isError = isError
  }

  public func setData(data: Response) {
    self.data = data
  }
}
