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
pomodoro <- function(goal,type='Work',pom=25,short=5,long=15,long_break=4,
                     filepath=r'(.\Pomodoro Records.csv)') {
  records <- read.csv(filepath)
  #Initialize values
  continue <- 'y'
  poms <- 0
  
  #Run the poms
  while (continue == 'y') {
    #Aesthetics
    print(goal)
    poms <- poms + 1
    print(paste0('Pomodoro #',poms,':'))
    
    #Initialize values
    work_begin <- Sys.time()
    start_timer(pom)
    
    #Break
    has_break <- readline(prompt = "Start break now? (y/n): ")
    work_end <- Sys.time()
    work_time <- as.numeric(difftime(work_end, work_begin, units='mins'))
    if (has_break == 'y') {
      #Calculate values
      break_begin <- Sys.time()
      
      #Start break
      if (poms %% long_break == 0) {
        start_timer(long)
        break.length <- long
      } else {
        start_timer(short)
        break.length <- short
      }
      #End break
      end_break <- readline(prompt = "Type 'y' to end break: ")
      if (end_break == 'y') {
        break_end <- Sys.time()
        break_time <- as.numeric(difftime(break_end, break_begin, units='mins'))
      }
    } else {
      break.length <- 0
      break_time <- 0
    }
    done <-  readline(prompt = "Did you get work done? (y/n): ")
    if (done == 'y') {
      print("That's great!")
    } else {
      print("Aw, that shucks. :(")
    }
    #Add record
    record <- data.frame(Pom = poms, Date = format(Sys.Date(), format="%Y-%m-%d"), 
                         Time = format(work_begin, format="%Y-%m-%d %H:%M:%S"), Type = type,
                         Goal = goal, Pom_Length=pom, Work_Time=work_time, Break_Length=break.length, 
                         Break_Time=break_time, Work_Done=done)
    records <- rbind(records,record)
    
    #Continue?
    continue <-  readline(prompt = "Continue? (y/n): ")
    change_goal <- readline(prompt = "Change Goal? (y/n): ")
    if (change_goal == 'y') {
      goal <- readline(prompt = "Input goal: ")
    }
  }
  write.csv(records,filepath,row.names = FALSE)
}

# Start a 25-minute pomodoro
pomodoro('Test',type='Test',pom = 0.05, short = 0.05)
