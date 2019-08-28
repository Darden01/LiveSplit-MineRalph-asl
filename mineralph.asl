state("MineRalph"){}

startup{}


init{ 
	//set refreshrate from 60/sec to 30/sec
	refreshRate = 30;
	print("init");
	vars.found = null;

	vars.levels = "1-1 ;1-2 ;1-3 ;1-4 ;1-5 ;1-6 ;1-7 ;1-8 ;1-9 ;1-10;1-B ;2-1 ;2-2 ;2-3 ;2-4 ;2-5 ;2-6 ;2-7 ;2-8 ;2-9 ;2-10;2-B ;3-1 ;3-2 ;3-3 ;3-4 ;3-5 ;3-6 ;3-7 ;3-8 ;3-9 ;3-10;3-B ;end ";
	
	print("Level list loaded");
	
	string logPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData); //getting path up to AppData\Local
	logPath += "Low\\Chop Chop Games\\MineRalph\\SpeedrunTools\\Progress.txt";
	print("Logpath: " + logPath);
    try { // Wipe the log file to clear out messages from last time
		FileStream fs = new FileStream(logPath, FileMode.Open, FileAccess.Write, FileShare.ReadWrite);
		fs.SetLength(0);
		fs.Close();
	} catch {print("not able to empty file...");} // May fail if file doesn't exist.
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
	print("Filereader ready");
	print("Initialisation complete");
}


update{
	
	while (true) {
		vars.line = vars.reader.ReadLine();
		
		if (vars.line == null || vars.line.Length < 2){
			return false;
		} else {
			print("found line: " + vars.line);
			return true;  
		}
	}
}

reset{
	if(vars.line.Substring(0,5) == "reset"){
		print("Run reset"); 
		return true;
	}
}

gameTime{
	if (vars.line.Substring(4,1) == "T" && vars.line.Substring(5).Length > 0){
		vars.LastTime = vars.line.Substring(5); //0.000 Format Second.milisec
		print(vars.LastTime);
		return TimeSpan.FromSeconds(System.Convert.ToDouble(vars.LastTime));
	}
}

start{
	if(vars.line.Substring(0,3) == "1-1"){
		vars.LastTime = "0.0";
		current.GameTime = TimeSpan.Zero;
		print("event Start: game started");
		return true;
	}
}

split{
	if(vars.line != "1-1"){
		if(vars.levels.Contains(vars.line.Substring(0,4)) ){
			print("split");
			return true;
		}
	}
}
