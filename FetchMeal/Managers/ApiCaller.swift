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

    func fetchData<T: Decodable>(for: T.Type, from endpoint: String) async throws -> T {
        guard let url = URL(string: Constants.baseURL + endpoint) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.failedToGetData
        }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)

            return result
        } catch {
            throw APIError.failedToGetData
        }
    }

    func getMealsByCategory(category: MealCategory) async throws -> [MealPreview] {
        let endpoint = Constants.endpoint.filterByCategory + category.rawValue

        do {
            let response = try await fetchData(for: FetchMealPreviewsResponse.self, from: endpoint)

            return response.meals
        } catch {
            throw error
        }
    }

    func getMealDetail(with id: String) async throws -> MealDetail {
        let endpoint = Constants.endpoint.lookUpByID + id

        do {
            let response = try await fetchData(for: FetchMealDetailResponse.self, from: endpoint)

            return response.meals[0]
        } catch {
            throw error
        }
    }
}
