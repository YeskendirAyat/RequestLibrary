//
//  NetworkManager.swift
//  RequestLibrary
//
//  Created by  Yeskendir Ayat on 28.07.2022.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<RequestService> { get }
    
    
//    func fetchPopularMovies(completion: @escaping (Result<MovieResponse, Error>) -> ())
//    func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> ())
//    func fetchSearchResult(query: String, completion: @escaping (Result<SearchResponse, Error>) -> ())
}
class NetworkManager: Networkable {
    var provider = MoyaProvider<RequestService>(plugins: [NetworkLoggerPlugin()])

//    func fetchPopularMovies(completion: @escaping (Result<MovieResponse, Error>) -> ()) {
//        request(target: .popular, completion: completion)
//    }
//
//    func fetchMovieDetail(movieId: String, completion: @escaping (Result<MovieDetailResponse, Error>) -> ()) {
//        request(target: .movie(movieId: movieId), completion: completion)
//    }
//
//    func fetchSearchResult(query: String, completion: @escaping (Result<SearchResponse, Error>) -> ()) {
//        request(target: .search(query: query), completion: completion)
//    }
}

//private extension NetworkManager {
//    private func request<T: Decodable>(target: RequestService, completion: @escaping (Result<T, Error>) -> ()) {
//        provider.request(target) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let results = try JSONDecoder().decode(T.self, from: response.data)
//                    completion(.success(results))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
//let headers = [
//    "X-RapidAPI-Key": "8ef7fa1f19msh338ffaf38ed27a3p1b25f4jsn38a0c56725a6",
//    "X-RapidAPI-Host": "shazam.p.rapidapi.com"
//]
//
//let request = NSMutableURLRequest(url: NSURL(string: "https://shazam.p.rapidapi.com/songs/list-artist-top-tracks?id=40008598&locale=en-US")! as URL,
//                                        cachePolicy: .useProtocolCachePolicy,
//                                    timeoutInterval: 10.0)
//request.httpMethod = "GET"
//request.allHTTPHeaderFields = headers
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//    if (error != nil) {
//        print(error)
//    } else {
//        let httpResponse = response as? HTTPURLResponse
//        print(httpResponse)
//    }
//})
//
//dataTask.resume()


struct Movie{
    var id: Int
//    var artist: String
//    var name: String
//    var time: String
}
extension Movie:  Decodable{
    enum SongCodingKeys: String, CodingKey{
        case id
//        case artist = "artist"
//        case name = "name"
//        case time = "time"
    }
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: SongCodingKeys.self)
        id  = try container.decode(Int.self, forKey: .id)
//        name  = try container.decode(String.self, forKey: .name)
//        artistName  = try container.decode(String.self, forKey: .artistName)
//        artworkURL  = try container.decode(String.self, forKey: .artworkURL)
    }
}
