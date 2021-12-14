//
//  TSMBaseServerOperation.swift
//
//  Is dependent on: `TSMBaseOperationOutput`, `TSMBaseOperation`
//
//  NOTES:
//  * operation has caching turned off
//

import UIKit

class TSMBaseServerOperation: TSMBaseOperation, URLSessionDelegate {

    // MARK: - Declarations
    // urlSession - keeps strong reference to operation(as delegate), must be invalidated on appropriate times.
    private var urlSession: URLSession?
    private var sessionDataTask: URLSessionDataTask?
    
    // MARK: Dependencies
    var authenticationChallenger: AuthenticationChallenger = DefaultAuthenticationChallenger()
    
    // MARK: - Methods
    // MARK: - Overriding TSMBaseOperation
    override func cancel() {
        
        guard isCancelled == false else {
            return
        }
        
        sessionDataTask?.cancel()
        urlSession?.invalidateAndCancel()
        
        super.cancel()
    }
    
    override func startOperation() {
        
        // Generate request
        guard let url: URL = operationUrl() else {
            print("\(NSStringFromClass(type(of: self))) ERROR! Could not generate URL")
            finishOperation()
            return
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url,
                                                               cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                                               timeoutInterval: Constants.APIOperation.serverOperationTimeoutInterval)
        request.setValue(Constants.APIOperation.headerContentType, forHTTPHeaderField: "Content-Type")
        addAditionalHeaderParametersTo(urlRequest: request)
        
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = self.httpMethod()
        request.httpBody = self.httpBodyData()
        
        if let httpBody = request.httpBody {
            request.setValue(String(httpBody.count), forHTTPHeaderField: "Content-Length")
        }
        
        // Create session data task
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        sessionDataTask = urlSession?.dataTask(with: request as URLRequest,
                                               completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
                                                self?.didFinishDataTaskWith(data: data, response: response, error: error)
                                               })
        
        if let sessionDataTask = sessionDataTask {
            sessionDataTask.resume()
        } else {
            print("WARING! Could not create sessionDataTask")
            finishOperation()
        }
    }
    
    override func finishOperation() {
        urlSession?.finishTasksAndInvalidate()
        
        super.finishOperation()
    }
    
    // MARK: - Methods for overriding
    func urlMethodName() -> String {
        // Overriding method should provide "method name" which will be added at the end of serverUrl
        
        print("\(NSStringFromClass(type(of: self))) WARNING! not overriden method - \(#function)")
        return ""
    }
    
    func httpMethod() -> String {
        // Overriding class should provide httpMethod (GET, POST, etc.)
        
        print("\(NSStringFromClass(type(of: self))) WARNING! not overriden method - \(#function)")
        return ""
    }
    
    func additionalUrlParametersDictionary() -> [String: String]? {
        // will be used in url, as "key=value&key2=value2"
        return nil
    }
    
    func additionalHeaderParametersDictionary() -> [String: String]? {
        // will be used in header, as "accessToken=aaaBbbbCcccDddd"
        return nil
    }
    
    func addAditionalHeaderParametersTo(urlRequest: NSMutableURLRequest) {
        guard let headersParametersDictionary: [String: String] = additionalHeaderParametersDictionary() else {
            return
        }
        
        for dict in headersParametersDictionary {
            urlRequest.setValue(dict.value, forHTTPHeaderField: dict.key)
        }
    }
    
    func additionalBodyDictionary() -> [String: Any]? {
        // Overriding class should provide additional values passed with request
        return nil
    }
    
    func isSuccessfulOnEmptyResponse() -> Bool {
        //
        // Override to return `true`, if operation may be considered successful, when http is [200-299]
        // and response data is nil (0 bytes).
        //
        // This is used to identify cases, when operation is considered successful only if there is data to parse.
        //
        return false
    }
    
    func parseResponseDict(_ responseDict: [String: Any]) {
        // Overriding class is responsible to:
        // * implement any kind of parsing
        // * UPDATING `output.isSuccessful` to proper state
        
        output.isSuccessful = true
    }
    
    func parseErrorData(_ data: Data?, withFailedResponse response: HTTPURLResponse) {
        //
        // Is called when http status code does not belong to 200-299 range.
        //
        // Overriding class, may implement any specific/error `data` parsing in case
        // server provides data with error codes.
        //
        // NOTE: usually it is error JSON parsing (when status code is: 400-499) which is identical in whole app.
        //       So implementation could be provided here, as long as this class is not intended to be reused
        //       in other projects.
        //
        // By default: does nothing
        //
    }
    
    // MARK: - URLSessionDelegate
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        
        authenticationChallenger.urlSession(session,
                                            didReceive: challenge,
                                            completionHandler: completionHandler)
    }
    
    // MARK: - Response Handling
    private func didFinishDataTaskWith(data: Data?, response: URLResponse?, error: Error?) {
        
        if response == nil {
            // On timeout response might be nil. Must properly restore session state.
            // Otherwise, might end up in scenario, when all requests start timeouting.
            if let urlSession = urlSession {
                urlSession.invalidateAndCancel()
                urlSession.reset(completionHandler: { [weak self] in
                    self?.finishOperation()
                })
            } else {
                finishOperation()
            }
        } else {
            // response != nil
            // NOTE: parsing must also properly update `output.isSuccessful`
            parseRetrievedData(data, withResponse: response, withError: error)
            finishOperation()
        }
    }
    
    private func parseRetrievedData(_ data: Data?, withResponse response: URLResponse?, withError error: Error?) {
        //
        // Do:
        // * check error
        // * check http status code
        // * convert into Dictionary (JSDON data)
        // * check JSON for error
        // * provide JSON for parsing
        //
        
        guard error == nil else {
            print("\(NSStringFromClass(type(of: self))) ERROR! operation failed with error: \(String(describing: error))")
            output.isSuccessful = false
            return
        }
        
        guard let response = response else {
            print("\(NSStringFromClass(type(of: self))) ERROR! response is nil")
            output.isSuccessful = false
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("\(NSStringFromClass(type(of: self))) ERROR! unexpected response \(response)")
            output.isSuccessful = false
            return
        }
        
        guard (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300) else {
            print("\(NSStringFromClass(type(of: self))) ERROR! unexpected status code \(httpResponse.statusCode)")
            parseErrorData(data, withFailedResponse: httpResponse)
            output?.isSuccessful = false
            return
        }
        
        //
        // If reached this line - http status code is ok (in 2xx range)
        // Check data for parsing.
        //
        guard let data = data, data.isEmpty == false  else {
            if isSuccessfulOnEmptyResponse() {
                output.isSuccessful = true
            } else {
                output.isSuccessful = false
            }
            return
        }
        
        var dictionaryToParse: [String: Any]!
        do {
            guard let responseDict: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]  else {
                print("\(NSStringFromClass(type(of: self))) ERROR! unexpected jsonDict structure: \(String(describing: String(data: data, encoding: .utf8)))")
                output.isSuccessful = false
                return
            }
            
            dictionaryToParse = responseDict
        } catch {
            print("\(NSStringFromClass(type(of: self))) ERROR! \(error) could not make jsonObject from data \(String(describing: String(data: data, encoding: .utf8)))")
            output.isSuccessful = false
            return
        }
        
        //
        // If reached this line, we have proper `dictionaryToParse` ([String: Any])
        // Might implement any additional steps, e.g. to check for generic error cases,
        // before stepping into successful response data parsing
        //
        
        // Trigger actual parsing (overriding class is responsible to implement it)
        parseResponseDict(dictionaryToParse)
    }
    
    // MARK: - Helpers
    private func operationUrl() -> URL? {
        //
        // Combines:
        // * server url
        // * method name
        // * additional GET parameters (version, language, etc.)
        //
        
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.APIOperation.serverScheme
        urlComponents.host = Constants.APIOperation.serverHost
        urlComponents.path = Constants.APIOperation.serverCommonPathStart + urlMethodName()
        urlComponents.queryItems = urlParametersQueryItemsList()
        
        // url parameters
        return urlComponents.url
    }
    
    private func urlParametersQueryItemsList() -> [URLQueryItem]? {
        //
        // Returns full list of parameters to be used in URL query
        // Is made out of 2 parts:
        // 1. common
        // 2. custom - provided by overriding operation
        //
        
        var parametersDict: [String: String] = [:]
        
        // 1. Common values
        let commonDict = commonUrlParametersDictionary()
        
        if let commonDict = commonDict {
            for (key, value) in commonDict {
                parametersDict.updateValue(value, forKey: key as String)
            }
        }
        
        // 2. Additional values
        let additionalDict = additionalUrlParametersDictionary()
        
        if let additionalDict = additionalDict {
            // add or replace values (in case keys are duplicate)
            for (key, value) in additionalDict {
                parametersDict.updateValue(value, forKey: key as String)
            }
        }
        
        // 3. Generate list of URLQueryItems
        guard parametersDict.isEmpty == false else {
            return nil
        }
        
        var queryItemsList: [URLQueryItem] = []
        for (key, value) in parametersDict {
            queryItemsList.append(URLQueryItem(name: key, value: value))
        }
        
        return queryItemsList
    }
    
    private func commonUrlParametersDictionary() -> [String: String]? {
        //  SAMPLE:
        //
        //  var commonDict: [String: String] = [:]
        //
        //  commonDict["v"] = String(kServerAPIVersion)
        //  commonDict["lang"] = GenericTools.usedLanguageCode()
        //
        //  return commonDict
        return nil
    }
    
    private func httpBodyData() -> Data? {
        //
        // Body data is generated form 2 parts:
        // 1. Common values - provided by BaseOperation
        // 2. Values provided by overriding class
        //
        
        var bodyDict: [String: Any] = [:]
        
        // 1. Common values
        let commonDict = commonBodyDictionary()
        
        if let commonDict = commonDict {
            for (key, value) in commonDict {
                bodyDict.updateValue(value, forKey: key as String)
            }
        }
        
        // 2. Additional values
        let additionalDict = additionalBodyDictionary()
        
        if let additionalDict = additionalDict {
            // add or replace values
            for (key, value) in additionalDict {
                bodyDict.updateValue(value, forKey: key as String)
            }
        }
        
        guard bodyDict.isEmpty == false else {
            return nil
        }
        
        // 3. Generate NSData
        let jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: bodyDict, options: [])
        } catch {
            print("\(NSStringFromClass(type(of: self))) WARNING! could not generate jsonData \(error.localizedDescription) from dictionary: \(bodyDict)")
            return nil
        }
        
        return jsonData
    }
    
    private func commonBodyDictionary() -> [String: String]? {
        //
        // Returns values, which are expected to be common for all requests.
        //
        return nil
    }
}
