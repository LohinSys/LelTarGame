extends HTTPRequest

var http_request = HTTPRequest.new()
var api_url: String = "https://leltargame.tryasp.net/api/v2/"

# global variables for request contents so that it can be grabbed to other scripts' variables
var req_result: int = 0
var req_response: int = 0
var req_headers: PackedStringArray = ["Content-Type: application/json"]
var req_body

# configure http request node
func _ready() -> void:
	http_request.use_threads = true
	http_request.timeout = 30.0
	http_request.request_completed.connect(_on_request_completed)

# function just for get requests (not sure if it'll be used for anything meaningful but it's nice to have just in case)
func get_request(target:String) -> void:
	http_request.request(str(api_url+target),req_headers,HTTPClient.METHOD_GET)

# and for post requests (like logging in and submitting to leaderboards)
func post_request(target:String,data:String) -> void:
	http_request.request(str(api_url+target),req_headers,HTTPClient.METHOD_POST,data)

# and put! (for uploading save files)
func put_request(target:String,data:String) -> void:
	http_request.request(str(api_url+target),req_headers,HTTPClient.METHOD_PUT,data)

# set variables once the request finishes
func _on_request_completed(_result,_response_code,_headers,body) -> void:
	req_result = _result
	req_response = _response_code
	var json = JSON.parse_string(body.get_string_from_utf8())
	req_body = json
