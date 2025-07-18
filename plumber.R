
library(plumber)
library(logger)
library(jsonlite) 
library(digest)

# Initialize logger
logger::log_appender(appender_file('/path/to/logs/plumber.log'))


#* API endpoint
#* @post / 
function(req,res) {
  
  payload <- jsonlite::fromJSON(req$postBody)
  branch <- payload$ref
  load_dot_env()
  
  payload_raw <- req$postBody
  signature <- req$HTTP_X_HUB_SIGNATURE_256 # extract the sha256 signature from GitHub
  computed_signature <- paste0("sha256=", hmac(secret, payload_raw, algo = "sha256")) # construct the sha256 signature using the secret value 
  
  # Extract the IP address of the incoming request
  request_ip <- req$REMOTE_ADDR
  
  log_info("Payload received from branch {branch} sent by ip: {request_ip}")
  
  if (signature != computed_signature) { # check if the local and remote sha256 signatures match
    
    res$status <- 403
    res$body <- "Forbidden!!"
    log_info('Request sent by forbidden ip: {request_ip}')
    return(res$body)
    
  } else{
    
    if(grepl('refs/heads/main',branch)){
      
      log_info('Main branch detected...invoking bashscript')
      system('sudo bash /path/to/refresh_dashboards.sh', intern = TRUE)
      log_info('Bash script executed')
      res$status <- 200
      res$body <- "Bash script executed"
      return(res$body)
      
    } else{  
      
      log_info('Payload not invoked by main branch') 
      res$status <- 200
      res$body <- "Payload not triggered by main branch."
      return(res$body)
    }

  } 

}
