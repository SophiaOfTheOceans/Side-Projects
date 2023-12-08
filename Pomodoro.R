# Function to play a beep sound
beep <- function() {
  system("rundll32 user32.dll,MessageBeep -1")
}

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

#Function to run the Pomodoro
pomodoro <- function(goal,type='Work',pom=25,short=5,long=15,long_break=4) {
  
  #Initialize values
  continue <- 'y'
  poms <- 0
  
  #Run the poms
  while (continue == 'y') {
    #Aesthetics
    print(goal)
    print(paste0('Pomodoro #',poms,':'))
    
    #Initialize values
    poms <- poms + 1
    work_begin <- Sys.time()
    start_timer(pom)
    
    #Break
    has_break <- readline(prompt = "Start break now? (y/n): ")
    if (has_break == 'y') {
      #Calculate values
      work_end <- Sys.time()
      work_time <- work_end - work_begin
      break_begin <- Sys.time()
      
      #Start break
      if (poms %% long_break == 0) {
        start_timer(long)
      } else {
        start_timer(short)
      }
      #End break
      end_break <- readline(prompt = "End break now? (y/n): ")
      if (end_break == 'y') {
        break_end <- Sys.time()
        break_time <- break_end - break_begin
      }
    }
    #Add record
    record <- data.frame(Date = Sys.Date(), Time = work_begin, Type = type,
                         Goal = goal, 
                         Work_Time=work_time, Break_Time=break_time)
    records <- rbind(records,record)
    
    #Continue?
    continue <-  readline(prompt = "Continue? (y/n): ")
    change_goal <- readline(prompt = "Change Goal? (y/n): ")
    if (change_goal == 'y') {
      goal <- readline(prompt = "Input goal: ")
    }
  }
  done <-  readline(prompt = "Did you get work done? (y/n): ")
  if (done == 'y') {
    print("That's great!")
  } else {
    print("Aw, that shucks. :(")
  }
}
#Initialize Records
records <- read.csv(r'.\Pomodoro Records.csv)')

# Start a 25-minute pomodoro
pomodoro()
