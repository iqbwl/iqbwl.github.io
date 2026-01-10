---
layout: cheatsheet
title: curl Command Cheatsheet
description: Essential curl commands for HTTP requests and API testing
---


A comprehensive reference for curl commands and HTTP operations.

## Basic Usage

### Simple Requests
```bash
curl https://example.com                 # GET request
curl -X POST https://api.example.com     # POST request
curl -X PUT https://api.example.com      # PUT request
curl -X DELETE https://api.example.com   # DELETE request
curl -X PATCH https://api.example.com    # PATCH request
curl -I https://example.com              # HEAD request (headers only)
```

### Output Options
```bash
curl -o file.html https://example.com    # Save to file
curl -O https://example.com/file.zip     # Save with remote filename
curl -s https://example.com              # Silent mode (no progress)
curl -v https://example.com              # Verbose output
curl -w "\n" https://example.com         # Add newline to output
curl https://example.com > file.html     # Redirect to file
```

## Headers

### Request Headers
```bash
curl -H "Content-Type: application/json" url              # Add header
curl -H "Authorization: Bearer token" url                 # Auth header
curl -H "User-Agent: MyApp/1.0" url                       # Custom user agent
curl -H "Accept: application/json" url                    # Accept header
curl -H "X-Custom-Header: value" url                      # Custom header
curl -A "Mozilla/5.0" url                                 # User agent shortcut
```

### Multiple Headers
```bash
curl -H "Header1: value1" \
     -H "Header2: value2" \
     -H "Header3: value3" \
     url
```

### Response Headers
```bash
curl -I url                              # Show headers only
curl -i url                              # Include headers in output
curl -D headers.txt url                  # Save headers to file
curl -s -D - url -o /dev/null            # Show only headers
```

## Request Body

### POST Data
```bash
curl -d "param1=value1&param2=value2" url                 # Form data
curl -d "name=John&age=30" url                            # URL encoded
curl --data-urlencode "text=Hello World" url              # URL encode data
curl -d @data.txt url                                     # Data from file
curl -F "file=@photo.jpg" url                             # Upload file
curl -F "name=John" -F "file=@doc.pdf" url                # Form with file
```

### JSON Data
```bash
curl -X POST url \
  -H "Content-Type: application/json" \
  -d '{"name":"John","age":30}'

curl -X POST url \
  -H "Content-Type: application/json" \
  -d @data.json                          # JSON from file
```

### Raw Data
```bash
curl --data-binary @file.bin url         # Binary data
curl --data-raw "raw text" url           # Raw text data
```

## Authentication

### Basic Auth
```bash
curl -u username:password url            # Basic authentication
curl -u username url                     # Prompt for password
curl -H "Authorization: Basic base64" url # Manual basic auth
```

### Bearer Token
```bash
curl -H "Authorization: Bearer token" url
curl -H "Authorization: Bearer $(cat token.txt)" url
```

### API Key
```bash
curl -H "X-API-Key: your-api-key" url
curl "url?api_key=your-api-key"          # Query parameter
```

### OAuth
```bash
curl -H "Authorization: OAuth oauth_token" url
```

## Cookies

### Cookie Management
```bash
curl -b cookies.txt url                  # Send cookies from file
curl -c cookies.txt url                  # Save cookies to file
curl -b "name=value" url                 # Send cookie
curl -b "session=abc123; user=john" url  # Multiple cookies
curl -b cookies.txt -c cookies.txt url   # Load and save cookies
```

## File Operations

### Download Files
```bash
curl -O url/file.zip                     # Save with original name
curl -o myfile.zip url/file.zip          # Save with custom name
curl -O url/file1.zip -O url/file2.zip   # Multiple files
curl -C - -O url/largefile.zip           # Resume download
curl -L -O url                           # Follow redirects
```

### Upload Files
```bash
curl -F "file=@document.pdf" url         # Upload file
curl -F "file=@photo.jpg;type=image/jpeg" url  # With MIME type
curl -T file.txt ftp://server/path/      # FTP upload
curl --upload-file file.txt url          # Upload with PUT
```

## Redirects

### Following Redirects
```bash
curl -L url                              # Follow redirects
curl -L -o file.html url                 # Follow and save
curl -L --max-redirs 5 url               # Limit redirects
curl -L -w "%{url_effective}\n" url      # Show final URL
```

## Timeouts and Retries

### Timeout Options
```bash
curl --connect-timeout 10 url            # Connection timeout (seconds)
curl --max-time 30 url                   # Maximum time for operation
curl -m 30 url                           # Max time shortcut
curl --speed-limit 1000 --speed-time 10 url  # Min speed requirement
```

### Retry Options
```bash
curl --retry 5 url                       # Retry on failure
curl --retry 5 --retry-delay 2 url       # Retry with delay
curl --retry 5 --retry-max-time 60 url   # Max retry time
curl --retry-connrefused url             # Retry on connection refused
```

## SSL/TLS

### SSL Options
```bash
curl -k url                              # Ignore SSL certificate errors
curl --insecure url                      # Same as -k
curl --cacert ca.crt url                 # Custom CA certificate
curl --cert client.crt --key client.key url  # Client certificate
curl --cert-type PEM --cert cert.pem url # Certificate type
curl -v url 2>&1 | grep "SSL"            # Show SSL info
```

### SSL Verification
```bash
curl --tlsv1.2 url                       # Force TLS 1.2
curl --tlsv1.3 url                       # Force TLS 1.3
curl --ssl-reqd url                      # Require SSL
```

## Proxy

### Proxy Configuration
```bash
curl -x proxy.example.com:8080 url       # HTTP proxy
curl -x socks5://proxy:1080 url          # SOCKS5 proxy
curl -U user:pass -x proxy:8080 url      # Proxy authentication
curl --noproxy localhost,127.0.0.1 url   # Bypass proxy
curl -x "" url                           # Disable proxy
```

## Rate Limiting

### Speed Control
```bash
curl --limit-rate 100K url               # Limit download speed
curl --limit-rate 1M url                 # 1 MB/s limit
curl --rate 10/m url                     # 10 requests per minute
```

## Output Formatting

### Custom Output
```bash
curl -w "\n" url                         # Add newline
curl -w "Status: %{http_code}\n" url     # Show status code
curl -w "Time: %{time_total}s\n" url     # Show time taken
curl -s -o /dev/null -w "%{http_code}" url  # Only status code
```

### Format Variables
```bash
%{http_code}                             # HTTP status code
%{time_total}                            # Total time
%{time_connect}                          # Connection time
%{time_starttransfer}                    # Time to first byte
%{size_download}                         # Downloaded size
%{speed_download}                        # Download speed
%{url_effective}                         # Final URL
%{content_type}                          # Content type
```

### Detailed Output
```bash
curl -w "\nStatus: %{http_code}\nTime: %{time_total}s\nSize: %{size_download} bytes\n" url
```

## Testing APIs

### REST API Examples
```bash
# GET request
curl -X GET "https://api.example.com/users" \
  -H "Accept: application/json"

# POST request
curl -X POST "https://api.example.com/users" \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com"}'

# PUT request
curl -X PUT "https://api.example.com/users/1" \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe"}'

# DELETE request
curl -X DELETE "https://api.example.com/users/1" \
  -H "Authorization: Bearer token"

# PATCH request
curl -X PATCH "https://api.example.com/users/1" \
  -H "Content-Type: application/json" \
  -d '{"email":"newemail@example.com"}'
```

### GraphQL
```bash
curl -X POST https://api.example.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"{ users { id name } }"}'
```

## Advanced Usage

### Multiple Requests
```bash
curl url1 url2 url3                      # Sequential requests
curl -Z url1 url2 url3                   # Parallel requests
curl [1-10].example.com                  # URL globbing
curl example.com/file[001-100].txt       # Range with padding
```

### Request Ranges
```bash
curl -r 0-999 url                        # Download first 1000 bytes
curl -r 1000-1999 url                    # Download bytes 1000-1999
curl -r -500 url                         # Download last 500 bytes
curl -C - -r 1000- url                   # Resume from byte 1000
```

### Compression
```bash
curl --compressed url                    # Request compressed response
curl -H "Accept-Encoding: gzip" url      # Request gzip
```

### Custom Methods
```bash
curl -X CUSTOM url                       # Custom HTTP method
curl --request CUSTOM url                # Same as above
```

## Debugging

### Verbose Output
```bash
curl -v url                              # Verbose mode
curl -vv url                             # More verbose
curl --trace trace.txt url               # Full trace to file
curl --trace-ascii trace.txt url         # ASCII trace
curl --trace-time url                    # Include timestamps
```

### Show Request
```bash
curl -v url 2>&1 | grep "^>"            # Show request headers
curl -v url 2>&1 | grep "^<"            # Show response headers
```

## Configuration

### Config File
```bash
curl -K config.txt url                   # Use config file
curl --config config.txt url             # Same as above

# config.txt example:
# url = "https://example.com"
# output = "file.html"
# user-agent = "MyApp/1.0"
# header = "Accept: application/json"
```

### Environment Variables
```bash
export http_proxy=http://proxy:8080
export https_proxy=https://proxy:8080
export no_proxy=localhost,127.0.0.1
```

## Useful Patterns

### Check if URL is Alive
```bash
curl -Is url | head -1                   # Check status
curl -o /dev/null -s -w "%{http_code}\n" url  # Get status code
```

### Download with Progress Bar
```bash
curl -# -O url                           # Progress bar instead of meter
curl --progress-bar -O url               # Same as above
```

### POST JSON and Parse Response
```bash
curl -X POST url \
  -H "Content-Type: application/json" \
  -d '{"key":"value"}' | jq '.'          # With jq for formatting
```

### Benchmark API
```bash
curl -w "@curl-format.txt" -o /dev/null -s url

# curl-format.txt:
#     time_namelookup:  %{time_namelookup}\n
#        time_connect:  %{time_connect}\n
#     time_appconnect:  %{time_appconnect}\n
#       time_redirect:  %{time_redirect}\n
#  time_pretransfer:  %{time_pretransfer}\n
#      time_starttransfer:  %{time_starttransfer}\n
#                          ----------\n
#          time_total:  %{time_total}\n
```

## Common Use Cases

### Health Check
```bash
curl -f url || echo "Failed"             # Fail silently on HTTP errors
curl --fail url                          # Same as above
```

### Follow Redirects and Save
```bash
curl -L -o output.html url               # Follow redirects and save
```

### POST Form Data
```bash
curl -X POST url \
  -F "username=john" \
  -F "password=secret" \
  -F "file=@document.pdf"
```

### API with Pagination
```bash
for i in {1..10}; do
  curl "https://api.example.com/items?page=$i"
done
```

## Best Practices

1. **Use -f/--fail** to catch HTTP errors in scripts
2. **Use -s/--silent** in scripts to avoid progress output
3. **Always use -L** to follow redirects
4. **Set timeouts** to avoid hanging
5. **Use -v** for debugging
6. **Store sensitive data** in files, not command line
7. **Use config files** for complex requests
8. **Check exit codes** in scripts: `$?`
9. **Use --retry** for unreliable connections
10. **Validate SSL** certificates in production

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | Unsupported protocol |
| 3 | URL malformed |
| 6 | Couldn't resolve host |
| 7 | Failed to connect |
| 22 | HTTP error (with -f) |
| 28 | Timeout |
| 35 | SSL connection error |
| 52 | Empty reply from server |
| 56 | Failure in receiving network data |

## Resources

- Official Documentation: https://curl.se/docs/
- Manual Page: https://curl.se/docs/manpage.html
- Everything curl: https://everything.curl.dev/
- curl Cookbook: https://catonmat.net/cookbooks/curl
