//
//  ViewController2.swift
//  wkWebViewTest
//
//  Created by 김민영 on 2020/07/17.
//  Copyright © 2020 MINYOUNGKIM. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ViewController2:UIViewController, WKUIDelegate{
    
    var wv : WKWebView!
    
    override func loadView() {
        super.loadView()
        print("loadView() call")
        let webConfig = WKWebViewConfiguration()
        let userSrcipt = WKUserScript(source: "redHeader()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)

        let contentController = WKUserContentController()
        contentController.addUserScript(userSrcipt)
        webConfig.userContentController = contentController

        wv = WKWebView(frame: self.view.bounds, configuration: webConfig)
        
        self.view.addSubview(wv)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad() call")
        
        wv.uiDelegate = self
        
        wv.navigationDelegate = self
        
        wv.load(URLRequest(url: URL(string:"http://127.0.0.1:8081/")!))
        
    }
    
    
    func abc(){
        print("abc call..")
    }
}
extension ViewController2:WKNavigationDelegate{
    // AlertPanel
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        print("runJavaScriptAlertPanelWithMessage()")
        
        print("-->\(message)")
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in completionHandler()}
        alert.addAction(ok)
        
        self.present(alert,animated: true, completion: nil)
        
    }
    
    // ConfirmPanel
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("runJavaScriptConfirmPanelWithMessage()")
    }
    
    // TextInputPanel
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("runJavaScriptTextInputPanelWithPrompt()")
    }
}

extension ViewController2:WKScriptMessageHandler{

    //JS-> nativeCall
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("userContentController() call")
        
        if message.name == "callbackHandler" {
            print(message.body)
            abc()
        }
    }

}
