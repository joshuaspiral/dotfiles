//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" RAM: ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{"BAT: ", "acpi | awk '{ print $4 }' | tr -d ','",                  	30,		0},

	{"STATUS: ", "acpi | awk '{ print $3 }' | tr -d ','",                 30,		0},

	{"VOL: ", "/home/joshua/.src/dwmblocks/scripts/volume.sh",					                            1,		0},

	{"", "date '+%b %d (%a) %H:%M:%S'",				                    	      1,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
