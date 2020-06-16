# wkWebViewTest

* **WKNavigationDelegate**

 - webView:decidePolicyForNavigationAction:decisionHandler:
	<br>
	탐색을 허용할지 또는 취소할지 여부를 결정합니다
	
   ```swift
   func webView(_ webView: WKWebView, 
   		decidePolicyFor navigationAction:WKNavigationAction, 
   		decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
   }
   ```
 - webView:decidePolicyForNavigationResponse:decisionHandler:
   <br>
   응답이 알려진 후 탐색을 허용할지 아니면 취소할지 결정합니다.
   
   ```swift
    func webView(_ webView: WKWebView, 
    	decidePolicyFor navigationResponse: WKNavigationResponse, 
    	decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    }
   ```   
 - webView:decidePolicyForNavigationAction:preferences:decisionHandler:
   <br>

   ```swift
    func webView(_ webView: WKWebView,
     	decidePolicyFor navigationAction: WKNavigationAction,
     	 preferences: WKWebpagePreferences, 
     	 decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
    }
   ```   
 - webViewWebContentProcessDidTerminate
   <br>웹뷰의 웹 콘텐츠 프로세스가 종료 될 때 호출됩니다.
 - didStartProvisionalNavigation
   <br>웹뷰가 콘텐츠 탐색을 시작할 떄 호출됩니다.
 - didCommit
   <br>웹뷰가 콘텐츠를 받기 시작할 때 호출됩니다.
 - didFailProvisionalNavigation
   <br>URL이 잘못되었거나, 네트워크가 정상적이지 않은 웹 페이지를 불러오는 경우 호출됩니다.
 - didFinish
    <br>웹뷰가 콘텐츠 받기를 완료했을 때 호출됩니다.
 - didFail
    <br>웹뷰가 콘텐츠 받기를 실패했을 때 호출됩니다.

-


 
* **WKWebView**
	- canGoBack
	
	- goBack
	  
	- canGoForward
	
	- goForward
	
	- allowsBackForwardNavigationGestures 
	
	```
	// 제스처 뒤로가기, 앞으로가기 가능
	self.webView.allow.allowsBackForwardNavigationGestures = true
	// 제스처 뒤로가기, 앞으로가기 불가능	
	self.webView.allow.allowsBackForwardNavigationGestures = true
	```
	
	
	
	
	# 참고 사이트
	
	 * [https://zeddios.tistory.com/330](https://zeddios.tistory.com/330)
	 * [https://verypurple.tistory.com/10](https://verypurple.tistory.com/10)
	 * [https://littleshark.tistory.com/56](https://littleshark.tistory.com/56)
	 * [http://blog.naver.com/PostView.nhn?blogId=xodhks_0113&logNo=220925597541&parentCategoryNo=&categoryNo=29&viewDate=&isShowPopularPosts=false&from=postView](http://blog.naver.com/PostView.nhn?blogId=xodhks_0113&logNo=220925597541&parentCategoryNo=&categoryNo=29&viewDate=&isShowPopularPosts=false&from=postView)
	