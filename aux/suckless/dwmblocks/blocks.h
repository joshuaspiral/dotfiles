static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {" 🐐 ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g", 30, 0},
    {" ", "acpi -b | awk '{if ($3 == \"Discharging,\") {printf \"🔋 %s %s\", $4, $5} else {printf \"🔌 %s %s\", $4, $5}}'", 30, 0},
    {" ", "pamixer --get-volume-human | awk '{if ($1 == \"muted\") {printf \"🔇 Muted\"} else {printf \"🔊 %s\", $1}}'", 1, 0},
    {" 🌞 ", "light", 1, 0},
    {" 📅 ", "date '+%b %d (%a) %H:%M:%S'", 1, 0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;

