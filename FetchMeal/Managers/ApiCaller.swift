//
//  ApiCaller.swift
//  FetchMeal
//
//  Created by Fernando Brito on 12/08/23.
//

import Foundation

struct Constants {
    static let baseURL = "https://themealdb.com/api/json/v1/1"

    enum endpoint {
        static let filterByCategory = "/filter.php?c="
        static let lookUpByID = "/lookup.php?i="
    }
}

enum MealCategory: String {
    case dessert = "Dessert"
}

enum APIError: Error {
    case invalidURL
    case failedToGetData
}

struct ApiCaller {
    static let shared = ApiCaller()

    func getMealsByCategory(category: MealCategory, completion: @escaping (Result<[MealPreview], APIError>) -> Void) {
        let endpoint = Constants.baseURL + Constants.endpoint.filterByCategory + category.rawValue
        guard let url = URL(string: endpoint) else {
            return completion(.failure(.invalidURL))
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200, error == nil
            else {
                return completion(.failure(.failedToGetData))
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(FetchMealPreviewsResponse.self, from: data)

                completion(.success(result.meals))
            } catch {
                return completion(.failure(.failedToGetData))
            }
        })

        task.resume()
    }

    func getMealDetail(with id: String, completion: @escaping (Result<MealDetail, APIError>) -> Void) {
        let endpoint = Constants.baseURL + Constants.endpoint.lookUpByID + id
        guard let url = URL(string: endpoint) else {
            return completion(.failure(.invalidURL))
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200, error == nil
            else {
                return completion(.failure(.failedToGetData))
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(FetchMealDetailResponse.self, from: data)

                completion(.success(result.meals[0]))
            } catch {
                return completion(.failure(.failedToGetData))
            }
        })

        task.resume()
    }
}
