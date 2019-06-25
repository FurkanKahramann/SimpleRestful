//
//  ViewController.swift
//  SimpleRestful
//
//  Created by fkahraman on 25.06.2019.
//  Copyright © 2019 fkahraman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        post(parameter: "Xcode") { (HandleMessage) in
            print(HandleMessage)
        }
    }
    func post(parameter: String, completion: @escaping (_ isSuccess: String)->() )
    {
        
        let parameters = [
                        "Parameter1": parameter,
                        "Param": "parameter",
                        "3": "parameter",
                        "ter3": "1"
            ] as [String : Any]

        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        let request = NSMutableURLRequest(url: NSURL(string:"www.apple.com")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 30.0)
        
        request.httpMethod = "POST"
        var headers  = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"]="application/json"
        
        request.allHTTPHeaderFields = headers
        request.httpBody = postData

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                print("Error")
            }
            else
            {
                _ = response as? HTTPURLResponse
                
                if let data = data,
                let utf8Representation = String(data: data, encoding: .utf8)
                {
                    print("Response: \(utf8Representation)")
                    
                    do{
                        print("Parse Area")
                    }
                    catch{
                        print("Parse Error")
                    }
                    completion("Return Message")
                }
                else
                {
                    completion("Return Message")
                }
            }
        }
        )
        dataTask.resume()
    }

}

