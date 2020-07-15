//
//  ViewController.swift
//  wkWebViewTest
//
//  Created by 김민영 on 6/13/20.
//  Copyright © 2020 MINYOUNGKIM. All rights reserved.
//

import UIKit

import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sBar: UISearchBar!
    @IBOutlet weak var wv: WKWebView!
    @IBOutlet weak var tBar: UIToolbar!
    
    // hides when stopped
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.sBar.delegate = self
        self.wv.uiDelegate = self
        self.wv.navigationDelegate = self
        
        //제츠처 추가 ( 뒤로, 앞으로 )
        self.wv.allowsBackForwardNavigationGestures = true
        
        self.request(url: "https://801sanae.github.io")
        
        
    }

    func request(url : String){
        self.wv.load(URLRequest(url: URL(string:url)!))
    }
    
    @IBAction func backBtn(_ sender: Any) {
        if self.wv.canGoBack {
            self.wv.goBack()
            self.wv.reload()
        } else{
            print("no back page")
        }
    }
    @IBAction func forwardBtn(_ sender: Any) {
        if self.wv.canGoForward {
            self.wv.goForward()
            self.wv.reload()
        } else {
            print("no forward page")
        }
    }
    
    @IBAction func refreshBtn(_ sender: Any) {
        self.request(url: self.sBar.text!)
    }
    @IBAction func homeBtn(_ sender: Any) {
        self.request(url: "https://801sanae.github.io")
    }
    
    func alert(_ msg: String, onClick: (()-> Void)? = nil){
        let controller = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            onClick?()
        }))
        DispatchQueue.main.async {
            self.present(controller,animated: false)
        }
    }
    
}

extension ViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.request(url: self.sBar.text!)
        
        self.view.endEditing(true)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked clicked")
    }
}


extension ViewController:WKNavigationDelegate{
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
    
    /*
     * 웹페이지의 탐색 허용을 결정
     * WKNavigationAction / URLRequest
     *
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("decidePolicyFor navigationAction() call")
        print("\(navigationAction.request.url!.absoluteString)")
        
        let chkUrl : String = navigationAction.request.url!.absoluteString
        
        if chkUrl.hasPrefix("https:")||chkUrl.hasPrefix("http:") {
            if chkUrl.contains("801sanae") {
                decisionHandler(.allow)
            }
        }else{
            decisionHandler(.cancel)
        }
    }

    /*
     * 웹페이지의 탐색 허용을 결정
     * WKNavigationResponse / HTTPURLResponse
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("decidePolicyFor navigationResponse() call")
//        if navigationResponse.response is HTTPURLResponse {
            let resp = navigationResponse.response as? HTTPURLResponse
            
        if resp?.statusCode == 500 || resp?.statusCode == 404 {
            decisionHandler(.cancel)
        } else if resp?.statusCode == 200 {
            decisionHandler(.allow)
        }
    }
    /*
     * ContentMode 추가.
     * .recommand, .desktop, .mobile
     *  컨텐츠의 유형 및 로드된 결과에 적용되는 레이아웃, 렌더링 조정에 영향을 줌?..
     *  WKNavigationAction / URLRequest 유사.? 비슷? 같음?
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        print("decidePolicyFor navigationAction preferences() call")
        preferences.preferredContentMode = .recommended
        
        decisionHandler(.allow, preferences)
    }
    
    // 웹뷰가 콘텐츠 탐색을 시작할 떄 호출
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation() call")
    }
    
    // 웹뷰가 콘텐츠를 받기 시작할 때 호출
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit() call")
        // 인디케이터 뷰를 화면에 보여주기 시작
        self.spinner.startAnimating()
    }
    
    // URL, 네트워크 상태가 문제가 있을 경우 호출된다.
    // URL이 잘못되었거나, 네트워크가 정상적이지 않은 웹 페이지를 불러오는 경우
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation() call")
        print("==> \(String(describing: self.sBar.text))")
    }
    
    // 웹뷰가 콘텐츠 받기를 완료했을 때 호출
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish() call")
        
        self.sBar.text = webView.url?.absoluteString
        
        // 인디케이터 뷰를 화면에 보여주기 끝
        self.spinner.stopAnimating()
    }
    
    // 웹뷰가 콘텐츠 받기를 실패했을 때 호출
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail()")
        self.alert("상세 페이지를 읽어오지 못했습니다.")
        print("error Msg ==\(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("runJavaScriptAlertPanelWithMessage()")
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("runJavaScriptConfirmPanelWithMessage()")
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("runJavaScriptTextInputPanelWithPrompt()")
    }
    
}

extension ViewController:WKUIDelegate{
    
}

extension ViewController:WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
}

