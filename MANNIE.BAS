DECLARE SUB F1Help ()
DECLARE SUB Check (arow%, acol%)
DEFINT A-Z
RANDOMIZE TIMER
VIEW PRINT
WIDTH 40, 25
VIEW PRINT
COLOR 11, 1
CLS

ON KEY(1) GOSUB Help
KEY(1) ON

TYPE me
   status AS INTEGER
END TYPE

DIM SHARED row, col
DIM SHARED hrtattack
DIM SHARED current
DIM SHARED Spade, e
DIM SHARED heart, h
DIM SHARED diamond, i
DIM SHARED club, c
DIM SHARED o
DIM SHARED square(25, 40) AS me
DIM guy(11) AS STRING
DIM mscore(11) AS DOUBLE
DIM score AS DOUBLE
DIM SHARED up AS STRING
DIM SHARED left AS STRING
DIM SHARED right AS STRING
DIM SHARED down AS STRING
DIM SHARED pageup AS STRING
DIM SHARED pagedown AS STRING
DIM SHARED enter AS STRING
DIM SHARED esc AS STRING


up = CHR$(0) + CHR$(72)
left = CHR$(0) + CHR$(75)
right = CHR$(0) + CHR$(77)
down = CHR$(0) + CHR$(80)
pageup = CHR$(0) + CHR$(73)
pagedown = CHR$(0) + CHR$(81)
enter = CHR$(13)
esc = CHR$(27)


FOR u = 1 TO 500
   x = INT(RND * 22) + 1
   y = INT(RND * 40) + 1
   COLOR 11
   LOCATE x, y: PRINT "Û"
   square(x, y).status = 11
NEXT u

DO
   x = INT(RND * 22) + 1
   y = INT(RND * 40) + 1
   COLOR 13
   IF square(x, y).status = 0 OR square(x, y).status = 11 THEN LOCATE x, y: PRINT "": square(x, y).status = 13: h = h + 1
LOOP UNTIL h = 50

DO
   x = INT(RND * 22) + 1
   y = INT(RND * 40) + 1
   COLOR 14
   IF square(x, y).status = 0 OR square(x, y).status = 11 THEN LOCATE x, y: PRINT "": square(x, y).status = 14: i = i + 1
LOOP UNTIL i = 50

DO
   x = INT(RND * 22) + 1
   y = INT(RND * 40) + 1
   COLOR 12
   IF square(x, y).status = 0 OR square(x, y).status = 11 THEN LOCATE x, y: PRINT "": square(x, y).status = 15: c = c + 1
LOOP UNTIL c = 50

DO
   x = INT(RND * 22) + 1
   y = INT(RND * 40) + 1
   COLOR 7
   IF square(x, y).status = 0 OR square(x, y).status = 11 THEN LOCATE x, y: PRINT "": square(x, y).status = 12: e = e + 1
LOOP UNTIL e = 46
Spade = 4

FOR x = 1 TO 22
   FOR y = 1 TO 80
      IF square(x, y).status = 0 THEN
         row = x: col = y: f = 1
         EXIT FOR
      END IF
   NEXT y
   IF f = 1 THEN EXIT FOR
NEXT x

t# = TIMER
time = 210
COLOR 7
LOCATE 24, 25: PRINT "Score: "; STR$(score); "00"
LOCATE row, col: PRINT ""

DO
   move$ = INKEY$
   hrtattack = 1
   SELECT CASE move$
      CASE "d", "D"
         IF diamond >= 7 THEN
            hrtattack = 0
            IF pop = 0 THEN diamond = diamond - 7
            score = score + 50
            COLOR 3
            IF row = 1 THEN row = 2
            IF col = 1 THEN col = 2
            IF row = 22 THEN row = 21
            IF col = 40 THEN col = 39
            LOCATE row, col: PRINT ""
            COLOR 14
            LOCATE row - 1, col: PRINT "": LOCATE row + 1, col: PRINT ""
            LOCATE row, col + 1: PRINT CHR$(26): LOCATE row, col - 1: PRINT ""
           
            DO
               d$ = INKEY$
               SELECT CASE d$
                  CASE CHR$(0) + CHR$(72)
                     qq = row - 1: qr = row - 1: qc = col
                     r = 1: s = -1: done = 1: d = 1
                  CASE CHR$(0) + CHR$(75)
                     qq = col - 1: qr = row: qc = col - 1
                     r = 1: s = -1: done = 1: d = 2
                  CASE CHR$(0) + CHR$(77)
                     qq = col + 1: qr = row: qc = col + 1
                     r = 40: s = 1: done = 1: d = 3
                  CASE CHR$(0) + CHR$(80)
                     qq = row + 1: qr = row + 1: qc = col
                     r = 22: s = 1: done = 1: d = 4
              END SELECT
            LOOP UNTIL done = 1
              IF d = 1 OR d = 4 THEN
               FOR x = qq TO r STEP s
                    COLOR 14
                    IF o = 1 THEN SOUND 300 + x, .3
                    LOCATE x, qc: PRINT ""
                    IF square(x, qc).status = 11 THEN square(x, qc).status = 0
                    FOR y = 1 TO 1000: NEXT y
               NEXT x
              ELSE
               FOR x = qq TO r STEP s
                    COLOR 14
                    LOCATE qr, x: PRINT ""
                    IF square(qr, x).status = 11 THEN square(qr, x).status = 0
                    IF o = 1 THEN SOUND 300 + x, .3
                    FOR y = 1 TO 1000: NEXT y
               NEXT x
              END IF
              FOR x = qq TO r STEP s
                 GOSUB suit
                 FOR y = 1 TO 1000: NEXT y
              NEXT x
            done = 0
            FOR x = row - 1 TO row + 1
               FOR y = col - 1 TO col + 1
                  Check x, y
               NEXT y
            NEXT x
            hrtattack = 1
            END IF
      CASE "h", "H"
         IF heart >= 10 THEN
            IF pop = 0 THEN heart = heart - 10
            score = score + 100
            IF current > 3 THEN GOTO jkl
            FOR x = 1 TO 22
               FOR y = 1 TO 40
                  COLOR 13: LOCATE x: PRINT STRING$(40, "")
                  IF current = 0 THEN
                     IF square(x, y).status = 12 THEN square(x, y).status = 15: t = t + x: e = e - 1: c = c + 1: IF o = 1 THEN SOUND 37 + t / 10, .5
                  ELSEIF current = 1 THEN
                     IF square(x, y).status = 15 THEN square(x, y).status = 14: t = t + x: c = c - 1: i = i + 1: IF o = 1 THEN SOUND 37 + t / 10, .5
                  ELSEIF current = 2 THEN
                     IF square(x, y).status = 14 THEN square(x, y).status = 13: t = t + x: i = i - 1: h = h + 1: IF o = 1 THEN SOUND 37 + t / 10, .5
                  ELSEIF current = 3 THEN
                     IF square(x, y).status = 11 THEN square(x, y).status = 0: t = t + x: IF o = 1 THEN SOUND 37 + t / 10, .5
                  ELSE
                 END IF
               NEXT y
               FOR y = 1 TO 40
                  hrtattack = 1
                  Check x, y
               NEXT y
            NEXT x
jkl:  
            IF current > 3 THEN
                LOCATE 12, 12: PRINT "10 seconds added!"
                FOR p = 1 TO 10000: NEXT p
                COLOR 1, 1: LOCATE 12, 12: PRINT "10 seconds added!"
                FOR u = 12 TO 35
                   Check 12, u
                NEXT u
               time = time + 10
            END IF

            current = current + 1
         END IF
      CASE "c", "C"
         hrtattack = 0
         IF club >= 5 THEN
         score = score + 15
         IF pop = 0 THEN club = club - 5
         COLOR 3
         IF row = 1 OR row = 2 THEN row = 3
         IF col = 1 OR col = 2 THEN col = 3
         IF row = 22 OR row = 21 THEN row = 20
         IF col = 40 OR col = 39 THEN col = 38
         LOCATE row, col: PRINT ""
         

            COLOR 12
            LOCATE row - 2, col - 2:  PRINT "  "
            LOCATE row - 1, col - 1:   PRINT ""
            LOCATE row, col - 2:      PRINT ""
            LOCATE row + 1, col - 1:   PRINT ""
            LOCATE row + 2, col - 2:  PRINT "  "
            IF o = 1 THEN SOUND 500, 1
         FOR x = 1 TO 30000: NEXT x
        
         COLOR 12
            LOCATE row - 2, col - 2:  PRINT "   "
            LOCATE row - 1, col - 2:  PRINT "   "
            LOCATE row, col - 2:      PRINT "    "
            LOCATE row + 1, col - 2:  PRINT "   "
            LOCATE row + 2, col - 2:  PRINT "   "
         IF o = 1 THEN SOUND 500, 1
         FOR x = 1 TO 30000: NEXT x
         COLOR 1
            LOCATE row - 2, col - 2:  PRINT "   "
            LOCATE row - 1, col - 2:  PRINT "   "
            LOCATE row, col - 2:      PRINT "    "
            LOCATE row + 1, col - 2:  PRINT "   "
            LOCATE row + 2, col - 2:  PRINT "   "
         IF o = 1 THEN SOUND 500, 1
            FOR x = row - 2 TO row + 2
               FOR y = col - 2 TO col + 2
                  Check x, y
               NEXT y
            NEXT x
         END IF
         hrtattack = 1
      CASE "s", "S"
         IF Spade >= 4 THEN
         hrtattack = 0
         score = score + 5
         IF pop = 0 THEN Spade = Spade - 4
         IF row = 1 THEN row = 2
         IF col = 1 THEN col = 2
         IF row = 22 THEN row = 21
         IF col = 40 THEN col = 39
         
         IF o = 1 THEN SOUND 500, 1
         COLOR 7
         LOCATE row - 1, col: PRINT "": LOCATE row + 1, col: PRINT ""
         LOCATE row, col - 1: PRINT "": LOCATE row, col + 1: PRINT ""
         FOR x = 1 TO 30000: NEXT x
         COLOR 1
         LOCATE row - 1, col: PRINT "": LOCATE row + 1, col: PRINT ""
         LOCATE row, col - 1: PRINT "": LOCATE row, col + 1: PRINT ""
         COLOR 7
         LOCATE row - 1, col - 1: PRINT "": LOCATE row - 1, col + 1: PRINT ""
         LOCATE row + 1, col - 1: PRINT "": LOCATE row + 1, col + 1: PRINT ""
         FOR x = 1 TO 30000: NEXT x
         IF o = 1 THEN SOUND 500, 1
         COLOR 1
         LOCATE row - 1, col - 1: PRINT "": LOCATE row - 1, col + 1: PRINT ""
         LOCATE row + 1, col - 1: PRINT "": LOCATE row + 1, col + 1: PRINT ""
         FOR x = row - 1 TO row + 1
            FOR y = col - 1 TO col + 1
               Check x, y
            NEXT y
         NEXT x
        END IF
        hrtattack = 1
      CASE up
         COLOR 1: LOCATE row, col: PRINT ""
         IF row - 1 >= 1 THEN row = row - 1 ELSE row = 22
         IF square(row, col).status = 11 THEN row = row + 1
         IF row > 22 THEN row = 1
      CASE left
         COLOR 1: LOCATE row, col: PRINT ""
         IF col - 1 >= 1 THEN col = col - 1 ELSE col = 40
         IF square(row, col).status = 11 THEN col = col + 1
         IF col > 40 THEN col = 1
      CASE right
         COLOR 1: LOCATE row, col: PRINT ""
         IF col + 1 <= 40 THEN col = col + 1 ELSE col = 1
         IF square(row, col).status = 11 THEN col = col - 1
         IF col < 1 THEN col = 40
      CASE down
         COLOR 1: LOCATE row, col: PRINT ""
         IF row + 1 <= 22 THEN row = row + 1 ELSE row = 1
         IF square(row, col).status = 11 THEN row = row - 1
         IF row < 1 THEN row = 22
      CASE "p", "P"
         LOCATE 23, (40 - LEN("  Game Paused.  Push P to continue.  ")) / 2
         PRINT "  Game Paused.  Push P to continue.  "
         DO
            pppp$ = LCASE$(INKEY$)
         LOOP UNTIL pppp$ = "o" OR pppp$ = "p"
        
         IF pppp$ = "o" THEN
            DO
               rrrr$ = LCASE$(INKEY$)
            LOOP UNTIL rrrr$ <> ""          'this starts the input of a secret
            IF rrrr$ = "p" THEN pop = 1     'password
         END IF
        
         IF pop = 1 AND rrrr$ = "p" THEN
            LOCATE 23, (40 - LEN("        Unlimited Attacks.       ")) / 2
            PRINT "        Unlimited Attacks.       "
            DO: LOOP UNTIL INKEY$ <> ""
         END IF                             'if password = pop then unlimited
                                            'attacks are present
         rrrr$ = "": pppp$ = ""
        
         COLOR 1
         LOCATE 23, (40 - LEN("  Game Paused.  Push P to continue.  ")) / 2
         PRINT "  Game Paused.  Push P to continue.  "
      CASE "o", "O"
         IF o = 1 THEN sound$ = "OFF"
         IF o = 0 THEN sound$ = "ON"
         LOCATE 23, (40 - LEN("  Sound is " + sound$ + ".  Push o to continue.  ")) / 2
         PRINT "  Sound is " + sound$ + ".  Push o to continue.  "
         DO: LOOP UNTIL LCASE$(INKEY$) = "o"
         COLOR 1
         LOCATE 23, (40 - LEN("  Sound is " + sound$ + ".  Push o to continue.  ")) / 2
         PRINT "  Sound is " + sound$ + ".  Push o to continue.  "
         IF o = 0 THEN o = 1 ELSE o = 0
      CASE "x", "X"
         LOCATE 23, (40 - LEN("Do you want to exit Mannie? (Y or N)")) / 2
         PRINT "Do you want to exit Mannie?  (Y or N)"
         DO: l$ = LCASE$(INKEY$): LOOP UNTIL l$ = "y" OR l$ = "n"
         IF l$ = "y" THEN EXIT DO
         l$ = ""
         COLOR 1
         LOCATE 23, (40 - LEN("Do you want to exit Mannie? (Y or N)")) / 2
         PRINT "Do you want to exit Mannie?  (Y or N)"
END SELECT

   IF score > 99999 THEN score = 99999
   IF time > 9999 THEN time = 9999

   COLOR 7
   IF t# + 1 <= TIMER THEN
      time = time - 1: t# = TIMER
      IF time < 11 THEN
         COLOR 15
         IF o = 1 THEN SOUND 100, 1
      END IF
   END IF
   IF time < 11 THEN COLOR 15
   LOCATE 24, 5: PRINT "Time:  "; time
   IF time <= 0 THEN EXIT DO
  
   IF move$ <> "" THEN
      IF t# + 1 <= TIMER THEN t = 0
      COLOR 3
      LOCATE row, col: PRINT ""
      IF square(row, col).status = 13 THEN score = score + 50: heart = heart + 1: h = h - 1
      IF square(row, col).status = 14 THEN score = score + 20: diamond = diamond + 1: i = i - 1
      IF square(row, col).status = 15 THEN score = score + 10: club = club + 1: c = c - 1
      IF square(row, col).status = 12 THEN score = score + 5: Spade = Spade + 1: e = e - 1
      IF square(row, col).status <> 0 THEN IF o = 1 THEN SOUND 250, .5
      square(row, col).status = 0
      COLOR 7
      LOCATE 23, 3: PRINT "="; Spade; "    ="; club; "    ="; diamond; "    ="; heart
      LOCATE 24, 25: PRINT "Score: "; STR$(score); "00"
      IF time < 11 THEN COLOR 15
      IF h = 0 AND i = 0 AND c = 0 AND e = 0 THEN EXIT DO
   END IF
LOOP

COLOR 7
score = score + time + (Spade * 5) + (club * 10) + (diamond * 20) + (heart * 50)
IF score > 99999 THEN score = 99999

m$ = STR$(score) + "00"
score = VAL(m$)


CLS
LOCATE 12
PRINT "Your total score:  "; score
DO: LOOP UNTIL INKEY$ <> ""

OPEN "c:\boxes\topten.man" FOR INPUT AS #1
FOR x = 1 TO 10
  INPUT #1, guy(x), mscore(x)
  IF score >= mscore(x) AND mmm = 0 THEN keep# = mscore(x): kepp$ = guy(x): naming = 1: mscore(x) = score: mmm = 1: place = x: x = x + 1: guy(x) = kepp$: mscore(x) = keep#
NEXT x


IF naming = 1 THEN
COLOR 7, 1
CLS
LOCATE 10, 15: PRINT "Enter Initials:"
LOCATE 12, (40 - LEN(n$)) / 2: PRINT " "; n$ + "_"


   DO
      s$ = UCASE$(INKEY$)
      SELECT CASE s$
         CASE "-" TO "~"
            IF LEN(n$) < 3 THEN n$ = n$ + s$
         CASE CHR$(8)
            IF LEN(n$) > 0 THEN n$ = LEFT$(n$, LEN(n$) - 1)
         CASE enter
            EXIT DO
      END SELECT
      IF s$ <> "" THEN
         COLOR 7
         LOCATE 12, (40 - LEN(n$)) / 2: PRINT " "; n$ + "_ "
      END IF
   LOOP
   guy(place) = n$
END IF

CLOSE
OPEN "c:boxes\topten.man" FOR OUTPUT AS #1

FOR x = 1 TO 10
   WRITE #1, guy(x), mscore(x)
NEXT x
CLOSE

CLS
LOCATE 7, 11: PRINT "   Name  ³  Score  "
LOCATE 8, 11: PRINT "ÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ"
              r$ = " \\. \   \³  #######"
FOR x = 1 TO 10
   LOCATE 8 + x, 10: PRINT USING r$; STR$(x); guy(x); mscore(x)
   IF x = 10 THEN LOCATE 18, 10: PRINT STR$(10); "."
NEXT x

DO: LOOP UNTIL INKEY$ <> ""

CHAIN "c:boxes\boxes"
END


suit:
IF d = 2 OR d = 3 THEN
   Check qr, x
ELSE
   Check x, qc
END IF

RETURN


Illegal:
SELECT CASE ERR
   CASE 62
      RESUME NEXT
   CASE ELSE
      RESUME NEXT
END SELECT
RESUME NEXT

Help:
   F1Help
RETURN

SUB Check (arow, acol)


SELECT CASE square(arow, acol).status
   CASE 0
         square(arow, acol).status = 0
         COLOR , 1: LOCATE arow, acol: PRINT " "
   CASE 11
      IF hrtattack = 0 THEN
         square(arow, acol).status = 0
         COLOR , 1: LOCATE arow, acol: PRINT " "
      ELSEIF hrtattack = 1 THEN
         square(arow, acol).status = 11
         COLOR 11: LOCATE arow, acol: PRINT "Û"
      END IF
   CASE 13
      COLOR 13:  LOCATE arow, acol: PRINT ""
   CASE 14
      COLOR 14:  LOCATE arow, acol: PRINT ""
   CASE 15
      COLOR 12:  LOCATE arow, acol: PRINT ""
   CASE 12
      COLOR 7:   LOCATE arow, acol: PRINT ""
END SELECT


END SUB

'F1Help:
'  Help "file" for Mannie--the latest thing in BOXES.
SUB F1Help

DIM direction  AS STRING
DIM colors     AS STRING
REDIM text(42) AS STRING
REDIM BOXES.color(5)

 text(1) = "    Thank you for playing the next best part of BOXES--Mannie!                "
 text(2) = "                                                                              "
 text(3) = "    Mannie is only a 1 player game.  You are the happy face located somewhere "
 text(4) = " around the upper left hand corner.  The object is to try to get a high score "
 text(5) = " by collecting the spades, clubs, diamonds, and hearts.  The only trouble is  "
 text(6) = " that some walls block your way to some of them. That is why you have special "
 text(7) = " attacks--moves that allow to break through these walls. To move Mannie, the  "
 text(8) = " happy face, use the arrow keys.  Pause the game by pushing `P'.  To toggle   "
 text(9) = " on or off sound effects, push `O'.  You have three and a half minutes to     "
text(10) = " to collect the items!  When you collect all the items or time runs out, you  "
text(11) = " will receive 100 pts. for each remaining second.  You will receive points    "
text(12) = " for the each remaining item you have.  Their point value is as follows.  The "
text(13) = " following list will show the point value of each item, the number of items   "
text(14) = " required to use the attack, the way to use the attack, and a description of  "
text(15) = " each attack:                                                                 "
text(16) = "             Spades:  500 pts.     Spades needed to use attack:  4; 5000 pts. "
text(17) = " Attack Description:  Destroys surrounding walls.  (Total Destruction:  8)    "
text(18) = "                      Type `S' to use the Spade Attack.                       "
text(19) = "                                                                              "
text(20) = "              Clubs:  1000 pts.     Clubs needed to use attack:  5; 15000 pts."
text(21) = " Attack Description:  Destroys surrounding walls and walls surrounding those. "
text(22) = "                      (Total Destruction:  15)                                "
text(23) = "                      Type `C' to use the Club Attack.                        "
text(24) = "                                                                              "
text(25) = "           Diamonds:  2000 pts.  Diamonds needed to use attack:  7; 50000 pts."
text(26) = " Attack Description:  You chose row or column to destroy that surrounds you.  "
text(27) = "                      Spade Attack used too.  (Minimum Destruction:  8)       "
text(28) = "                      Type `D' to use the Diamond Attack.                     "
text(29) = "                                                                              "
text(30) = "             Hearts:  5000 pts.   Hearts needed to use attack:  10; 100000 pts"
text(31) = " Attack Description:  The first time using it all Spades become Clubs.  The   "
text(32) = "                      second time causes Clubs to become Diamonds.  The third "
text(33) = "                      time makes all Diamonds become Hearts.  The fourth time "
text(34) = "                      causes all the walls to disappear.  Anytime after that  "
text(35) = "                      adds 10 seconds to your time.                           "
text(36) = "                      Type `H' to use the Heart Attack.                       "
text(37) = "                                                                              "
text(38) = " If you want to ever exit Mannie, simply push `X'.  You don't get any lives   "
text(39) = " in this game, and there is only one level.  Try to beat BST if you can.  If  "
text(40) = " you would like a special password in this game contact Matthew Pava.         "
text(41) = "******************************************************************************"
text(42) = " TMPCI(C) The Matthew Pava Company, Inc.(C)  Saturday, January 2nd, 1998      "
OPEN "c:\boxes\color.ini" FOR INPUT AS #1

FOR x = 1 TO 5
   INPUT #1, colors
   BOXES.color(x) = VAL(RIGHT$(colors, 1))
NEXT x

CLOSE

COLOR BOXES.color(1), BOXES.color(1)
CLS
WIDTH 80, 25
VIEW PRINT

COLOR BOXES.color(3), BOXES.color(2)

LOCATE 1, 2: PRINT "MANNIE Help               Use Arrow Keys, PageUp and PageDown Keys, and Enter."
LOCATE 1, 1: PRINT "Ú" + STRING$(78, "Ä") + "¿"

FOR x = 2 TO 22
   LOCATE x, 1: PRINT "³" + SPACE$(78) + "³"
NEXT x

LOCATE 22, 2: PRINT "À" + STRING$(78, "Ä") + "Ù"

start.row = 1

FOR x = 0 TO 20
   LOCATE x + 2, 2
   PRINT text(start.row + x)
NEXT x

LOCATE 22, 80: PRINT CHR$(25)
LOCATE 22, 1: PRINT CHR$(25)

DO
   direction = INKEY$
 
IF (direction = up AND start.row - 1 >= 1) OR (direction = down AND start.row + 1 <= 22) OR direction = pageup OR direction = pagedown OR direction = esc OR direction = enter THEN
   SELECT CASE direction
      CASE up
         IF start.row - 1 >= 1 THEN start.row = start.row - 1
      CASE down
         IF start.row + 1 <= 22 THEN start.row = start.row + 1
      CASE pageup
         start.row = 1
      CASE pagedown
         start.row = 22
      CASE esc, enter
         EXIT DO
   END SELECT
 
      FOR x = 0 TO 20
         LOCATE x + 2, 2
         PRINT text(start.row + x)
      NEXT x

   SELECT CASE start.row
      CASE 1
         LOCATE 22, 80: PRINT CHR$(25):  LOCATE 22, 1: PRINT CHR$(25)
         LOCATE 2, 80: PRINT "³":      LOCATE 2, 1: PRINT "³"
      CASE 22
         LOCATE 2, 80: PRINT CHR$(24): LOCATE 2, 1: PRINT CHR$(24)
         LOCATE 22, 80: PRINT "³":     LOCATE 22, 1: PRINT "³"
      CASE ELSE
         LOCATE 2, 80: PRINT CHR$(24): LOCATE 22, 80: PRINT CHR$(25)
         LOCATE 2, 1: PRINT CHR$(24):  LOCATE 22, 1: PRINT CHR$(25)
   END SELECT

END IF

LOOP

COLOR 1, 1
WIDTH 40, 25
VIEW PRINT 1 TO 25
CLS

FOR x = 1 TO 22
    FOR y = 1 TO 40
      Check x, y
    NEXT y
NEXT x

COLOR 3
LOCATE row, col: PRINT ""

END SUB

