state("MineRalph"){}

startup{
	settings.Add("reset", true, "Reset on Restart");
}


init{
	//set refreshrate from 60/sec to 30/sec
	refreshRate = 30;
	print("init");
	
	string logPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData); //getting path up to AppData\Local
	logPath += "Low\\Chop Chop Games\\MineRalph\\SpeedrunTools\\Progress.txt";
	print(logPath);
    try { // Wipe the log file to clear out messages from last time
		FileStream fs = new FileStream(logPath, FileMode.Open, FileAccess.Write, FileShare.ReadWrite);
		fs.SetLength(0);
		fs.Close();
	} catch {} // May fail if file doesn't exist.
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
}


update{
	while (true) {
		vars.line = vars.reader.ReadLine();
		
		if (vars.line == null || vars.line.Length < 2){
			return false;
		} else {
			print(vars.line);
			return true; 
		}
	}
}

reset{
	if(vars.line.Substring(0,3) == "1-1" || vars.line.Substring(0,5) == "reset"){
		print("reset");
		return true;
	}
}

gameTime{
	if (vars.line.Substring(4,1) == "T"){
		vars.LastTime = vars.line.Substring(5); //0.000 Format Second.milisec
		print(vars.LastTime);
		return TimeSpan.FromSeconds(System.Convert.ToDouble(vars.LastTime));
	}
}

start{
	if(vars.line.Substring(0,3) == "1-1"){
		vars.LastTime = 0.0;
		vars.CurrentTime = 0.0;
		
		current.GameTime = TimeSpan.Zero;
		print("IT WORKED!!!!");
		return true;
	}
}

split{
	if(vars.line != "1-1" && vars.line != "3-B"){
		print("ok");
		return true;
	}
}
