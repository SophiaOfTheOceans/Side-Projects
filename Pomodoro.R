# Function to start the timer
start_timer <- function(minutes) {
  # Convert minutes to seconds
  seconds <- minutes * 60
  
  # Start the timer
  for (i in seconds:0) {
    # Calculate minutes and seconds
    mins <- floor(i / 60)
    secs <- i %% 60
    
    # Print the time
    cat(sprintf("\r%02d:%02d", mins, secs))
    
    # Wait for 1 second
    Sys.sleep(1)
  }
  
  # Play a sound when the timer ends
  beep()
}

# Function to play a beep sound
beep <- function() {
  system("rundll32 user32.dll,MessageBeep -1")
}

# Start a 25-minute pomodoro
start_timer(0.5)