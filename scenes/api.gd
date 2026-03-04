extends HTTPRequest

var http_request = HTTPRequest.new()
var api_url: String = "https://leltargame.tryasp.net/api/v2/"

var req_result: int = 0
var req_response: int = 0
var req_headers: PackedStringArray = ["Content-Type: application/json"]
var req_body

func _ready() -> void:
	http_request.use_threads = true
	http_request.timeout = 30.0
	http_request.request_completed.connect(_on_request_completed)
	get_request("accMgmt/view/5")
	#post_request("auth/login",str('{"username": "fucking", "password": "motherfucker"}'))
	await http_request.request_completed
	print(req_body)

func get_request(target:String) -> void:
	http_request.request(str(api_url+target),req_headers,HTTPClient.METHOD_GET)

func post_request(target:String,_data:String) -> void:
	http_request.request(str(api_url+target),req_headers,HTTPClient.METHOD_POST,_data)

func _on_request_completed(_result,_response_code,_headers,body) -> void:
	req_result = _result
	req_response = _response_code
	var json = JSON.parse_string(body.get_string_from_utf8())
	req_body = json
