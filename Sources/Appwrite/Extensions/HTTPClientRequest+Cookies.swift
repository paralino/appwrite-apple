import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

extension HTTPClient.Request {
    public mutating func addDomainCookies(userDefaultsGroup: String?) {
        headers.addDomainCookies(for: url.host!, userDefaultsGroup: userDefaultsGroup)
    }
}

extension HTTPClientRequest {
    public mutating func addDomainCookies(userDefaultsGroup: String?) {
        headers.addDomainCookies(for: URL(string: url)!.host!, userDefaultsGroup: userDefaultsGroup)
    }
}

extension HTTPHeaders {
    public mutating func addDomainCookies(for domain: String, userDefaultsGroup: String?) {
        let userDefaults = (userDefaultsGroup != nil ? UserDefaults(suiteName: userDefaultsGroup) : nil) ?? UserDefaults.standard
        guard let cookies = userDefaults.stringArray(forKey: domain) else {
            return
        }
        for cookie in cookies {
            add(name: "Cookie", value: cookie)
        }
    }
}
